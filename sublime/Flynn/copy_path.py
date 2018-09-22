import os

import sublime
import sublime_plugin

class CopyFileNameCommand(sublime_plugin.TextCommand):
    """
    Command to copy only the file name of the current file.
    """
    def run(self, edit):
        sublime.set_clipboard(os.path.basename(self.view.file_name()))
        sublime.status_message('Copied file name')

    def is_enabled(self):
        return bool(self.view.file_name())

class CopyPathRelativeToProjectCommand(sublime_plugin.TextCommand):
    """
    Command to copy the path of the current file relative to the project's root
    directory.
    """
    def __init__(self, *args, **kwargs):
        super(CopyPathRelativeToProjectCommand, self).__init__(*args, **kwargs)
        self.relative_path = None

    def run(self, edit):
        sublime.set_clipboard(self.relative_path)
        sublime.status_message('Copied relative path')

    def is_enabled(self):
        if not self.relative_path:
            project_paths = self.view.window().folders()
            file_path = self.view.file_name() or str()

            candidates = [p for p in project_paths if file_path.startswith(p)]

            if candidates:
                project_path = min(candidates, key=len)
                self.relative_path = os.path.relpath(file_path, project_path)

        return bool(self.relative_path)
