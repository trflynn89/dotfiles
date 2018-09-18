import os

import sublime
import sublime_plugin

class CopyPathRelativeToProject(sublime_plugin.TextCommand):
    """
    Command to copy the path of the current file relative to the project's root
    directory.
    """
    def __init__(self, *args, **kwargs):
        super(CopyPathRelativeToProject, self).__init__(*args, **kwargs)
        self.relative_file_path = None

    def run(self, edit):
        sublime.set_clipboard(self.relative_file_path)
        sublime.status_message("Copied file path")

    def is_enabled(self):
        if not self.relative_file_path:
            window_variables = self.view.window().extract_variables()

            project_path = window_variables['folder']
            file_path = self.view.file_name()

            if project_path and file_path and file_path.startswith(project_path):
                self.relative_file_path = os.path.relpath(file_path, project_path)

        return bool(self.relative_file_path)
