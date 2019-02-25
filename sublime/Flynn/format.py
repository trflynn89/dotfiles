import os
import shutil
import subprocess

import sublime
import sublime_plugin

FORMATTER = 'clang-format.exe' if (os.name == 'nt') else 'clang-format'
LANGUAGES = ('C', 'C++', 'Objective-C', 'Objective-C++', 'Java')
ENCODING = 'utf-8'

class FormatFileCommand(sublime_plugin.TextCommand):
    """
    Command to run clang-format on a file. If any selections are active, only
    those selections are formatted.
    """
    def __init__(self, *args, **kwargs):
        super(FormatFileCommand, self).__init__(*args, **kwargs)
        self.formatter = shutil.which(FORMATTER)

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
            process = subprocess.Popen(
                command,
                stdout=subprocess.PIPE,
                stderr=subprocess.PIPE,
                stdin=subprocess.PIPE,
                cwd=os.path.dirname(self.view.file_name()))

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
