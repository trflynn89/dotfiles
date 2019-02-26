import os
import shutil
import subprocess

import sublime
import sublime_plugin

# List of possible names the clang-format binary may have
FORMATTERS = ['clang-format']
if os.name == 'nt':
    FORMATTERS.extend(['clang-format.bat', 'clang-format.exe'])

# List of languages supported for use with clang-format
LANGUAGES = ('C', 'C++', 'Objective-C', 'Objective-C++', 'Java', 'JavaScript')

def get_project_setting(setting_key):
    """
    Load a project setting from the active window, with environment variable
    expansion.
    """
    project_data = sublime.active_window().project_data()

    if project_data and ('settings' in project_data):
        settings = project_data['settings']

        if setting_key in settings:
            return os.path.expandvars(settings[setting_key])

    return None

def find_binary(directory, binaries):
    """
    Search for one of a list of binaries in the given directory or on the system
    PATH. Return the first valid binary that is found.
    """
    is_directory = lambda d: d and os.path.isdir(d) and os.access(d, os.R_OK)
    is_binary = lambda f: f and os.path.isfile(f) and os.access(f, os.X_OK)

    # First search through the given directory for any of the binaries
    for binary in (binaries if is_directory(directory) else []):
        binary = os.path.join(directory, binary)
        if is_binary(binary):
            return binary

    # Then fallback onto the system PATH
    for binary in binaries:
        binary = shutil.which(binary)
        if is_binary(binary):
            return binary

    return None

def execute_command(command, working_directory, stdin=None):
    """
    Execute a command list in the given working directory, optionally piping in
    an input string. Returns the standard output of the command, or None if an
    error occurred.
    """
    startup_info = None

    # On Windows, prevent a command prompt from showing
    if os.name == 'nt':
        startup_info = subprocess.STARTUPINFO()
        startup_info.dwFlags |= subprocess.STARTF_USESHOWWINDOW

    try:
        encoding = 'utf-8'

        process = subprocess.Popen(
            command,
            stdin=subprocess.PIPE,
            stdout=subprocess.PIPE,
            stderr=subprocess.PIPE,
            cwd=working_directory,
            startupinfo=startup_info,
        )

        if stdin:
            stdin = stdin.encode(encoding)

        (stdout, stderr) = process.communicate(input=stdin)

        if stderr:
            sublime.error_message('Error: ' + stderr.decode(encoding))
        elif stdout:
            return stdout.decode(encoding)

    except Exception as ex:
        sublime.error_message('Exception: ' + str(ex))

    return None

class FormatFileCommand(sublime_plugin.TextCommand):
    """
    Command to run clang-format on a file. If any selections are active, only
    those selections are formatted.

    This plugin by default loads clang-format from the system PATH. But because
    Sublime doesn't source ~/.zshrc or ~/.bashrc, any PATH changes made there
    will not be noticed. So, users may set "clang_format_directory" in their
    project's settings, and that directory is used instead of PATH. Example:

        {
            "folders": [],
            "settings": {
                "clang_format_directory": "$HOME/workspace/tools",
            }
        }

    Any known environment variables in the setting's value will be expanded.
    """
    def run(self, edit):
        command = [self.formatter, '-assume-filename', self.view.file_name()]

        for region in self.view.sel():
            if not region.empty():
                command.extend(['-offset', str(region.begin())])
                command.extend(['-length', str(region.size())])

        working_directory = os.path.dirname(self.view.file_name())

        region = sublime.Region(0, self.view.size())
        contents = self.view.substr(region)

        contents = execute_command(command, working_directory, stdin=contents)

        if contents:
            self.view.replace(edit, region, contents)

    def is_enabled(self):
        (syntax, _) = os.path.splitext(self.view.settings().get('syntax'))
        supported = any(syntax.endswith(lang) for lang in LANGUAGES)

        return supported and bool(self.view.file_name())

    def is_visible(self):
        clang_format_directory = get_project_setting('clang_format_directory')
        self.formatter = find_binary(clang_format_directory, FORMATTERS)

        return bool(self.formatter)
