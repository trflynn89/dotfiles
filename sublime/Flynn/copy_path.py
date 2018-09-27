import os

import sublime
import sublime_plugin

class RelativePath(object):
    """
    Class to determine and store the path of the current file relative to its
    project's root directory.
    """
    def __init__(self):
        self.relative_path = None

    def __call__(self, view):
        if not self.relative_path:
            project_paths = view.window().folders()
            file_path = view.file_name() or str()

            # This file may appear under multiple projects (e.g. if a subpath of
            # an existing project was added as a folder). Pick the project with
            # the shortest path length to get the top-most project path.
            candidates = [p for p in project_paths if file_path.startswith(p)]

            if candidates:
                project_path = min(candidates, key=len)
                self.relative_path = os.path.relpath(file_path, project_path)

        return self.relative_path

class CopyFileNameCommand(sublime_plugin.TextCommand):
    """
    Command to copy the name of the current file.
    """
    def run(self, edit):
        sublime.set_clipboard(os.path.basename(self.view.file_name()))
        sublime.status_message('Copied file name')

    def is_enabled(self):
        return bool(self.view.file_name())

class CopyFileDirectoryCommand(sublime_plugin.TextCommand):
    """
    Command to copy the directory of the current file.
    """
    def run(self, edit):
        sublime.set_clipboard(os.path.dirname(self.view.file_name()))
        sublime.status_message('Copied file directory')

    def is_enabled(self):
        return bool(self.view.file_name())

class CopyFilePathRelativeToProjectCommand(sublime_plugin.TextCommand):
    """
    Command to copy the path of the current file relative to its project's root
    directory.
    """
    def __init__(self, *args, **kwargs):
        super(CopyFilePathRelativeToProjectCommand, self).__init__(
            *args, **kwargs)
        self.relative_path = RelativePath()

    def run(self, edit):
        sublime.set_clipboard(self.relative_path(self.view))
        sublime.status_message('Copied relative file')

    def is_enabled(self):
        return bool(self.relative_path(self.view))

class CopyFileDirectoryRelativeToProjectCommand(sublime_plugin.TextCommand):
    """
    Command to copy the directory of the current file relative to its project's
    root directory.
    """
    def __init__(self, *args, **kwargs):
        super(CopyFileDirectoryRelativeToProjectCommand, self).__init__(
            *args, **kwargs)
        self.relative_path = RelativePath()

    def run(self, edit):
        sublime.set_clipboard(os.path.dirname(self.relative_path(self.view)))
        sublime.status_message('Copied relative directory')

    def is_enabled(self):
        return bool(self.relative_path(self.view))
