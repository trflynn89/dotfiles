import os
import shutil
import subprocess

import sublime
import sublime_plugin

FORMATTERS = ['clang-format']
if os.name == 'nt':
    FORMATTERS.extend(['clang-format.bat', 'clang-format.exe'])

LANGUAGES = ('C', 'C++', 'Objective-C', 'Objective-C++', 'Java')
ENCODING = 'utf-8'

def get_project_setting(window, setting_key):
    """
    Load a project setting from the given window, with environment variable
    expansion.
    """
    project_data = window.project_data()

    if project_data and ('settings' in project_data):
        settings = project_data['settings']

        if setting_key in settings:
            return os.path.expandvars(settings[setting_key])

    return None

class FormatFileCommand(sublime_plugin.TextCommand):
    """
    Command to run clang-format on a file. If any selections are active, only
    those selections are formatted.
    """
    def __init__(self, *args, **kwargs):
        super(FormatFileCommand, self).__init__(*args, **kwargs)

        formatter_directory = get_project_setting(
            sublime.active_window(),
            'clang_format_directory'
        )

        valid = lambda f: f and os.path.isfile(f) and os.access(f, os.X_OK)

        for formatter in FORMATTERS:
            if formatter_directory:
                candidate = os.path.join(formatter_directory, formatter)
            else:
                candidate = shutil.which(formatter)

            if valid(candidate):
                self.formatter = candidate
                break

        else:
            self.formatter = None

    def run(self, edit):
        command = [self.formatter, '-assume-filename', self.view.file_name()]

        for region in self.view.sel():
            if region.empty():
                continue

            command.extend(['-offset', str(region.begin())])
            command.extend(['-length', str(region.size())])

        region = sublime.Region(0, self.view.size())
        contents = self.view.substr(region)

        try:
            startupinfo = None
            if os.name == 'nt':
                startupinfo = subprocess.STARTUPINFO()
                startupinfo.dwFlags |= subprocess.STARTF_USESHOWWINDOW

            process = subprocess.Popen(
                command,
                stdout=subprocess.PIPE,
                stderr=subprocess.PIPE,
                stdin=subprocess.PIPE,
                startupinfo=startupinfo,
                cwd=os.path.dirname(self.view.file_name())
            )

            (formatted, error) = process.communicate(contents.encode(ENCODING))
        except Exception as ex:
            sublime.error_message('Format exception: ' + str(ex))
            (formatted, error) = (None, None)

        if error:
            sublime.error_message('Format error: ' + error.decode(ENCODING))

        elif formatted:
            sublime.status_message('Formatted file')
            self.view.replace(edit, region, formatted.decode(ENCODING))

    def is_enabled(self):
        (syntax, _) = os.path.splitext(self.view.settings().get('syntax'))
        supported = any(syntax.endswith(lang) for lang in LANGUAGES)

        return supported and bool(self.view.file_name())

    def is_visible(self):
        return bool(self.formatter)

class FormatFileListener(sublime_plugin.EventListener):
    """
    Listener to reload the format file plugin when the project settings have
    changed.
    """
    def on_post_save_async(self, view):
        window = view.window()

        if view.file_name() == window.project_file_name():
            sublime_plugin.reload_plugin(__name__)
