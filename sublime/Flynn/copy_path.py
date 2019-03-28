import os
import re

import sublime
import sublime_plugin

class RelativePath(object):
    """
    Class to determine and store the path of the current file relative to its
    project's root directory.
    """
    def __init__(self):
        self.project_path = None
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
                self.project_path = min(candidates, key=len)
                self.relative_path = os.path.relpath(file_path, self.project_path)

        return (self.relative_path, self.project_path)

class RelativePathCommand(sublime_plugin.TextCommand):
    """
    Base class for commands which need relative path information.
    """
    def __init__(self, *args, **kwargs):
        super(RelativePathCommand, self).__init__(*args, **kwargs)
        self.relative_path = RelativePath()

    def is_enabled(self):
        return all(self.relative_path(self.view))

class CFamilyCommand(RelativePathCommand):
    """
    Base class for commands specific to the C/C++ family of languages.
    """
    LANGUAGES = ('C', 'C++', 'Objective-C', 'Objective-C++')
    HEADERS = ('.h', '.hh', '.hpp')

    def to_header_file(self):
        (relative_path, project_path) = self.relative_path(self.view)
        (path, ext) = os.path.splitext(relative_path)

        if ext not in self.HEADERS:
            for header in self.HEADERS:
                new_path = path + header

                if os.path.isfile(os.path.join(project_path, new_path)):
                    return new_path

        return relative_path

    def is_enabled(self):
        (syntax, _) = os.path.splitext(self.view.settings().get('syntax'))
        supported = any(syntax.endswith(lang) for lang in self.LANGUAGES)

        return supported and super(CFamilyCommand, self).is_enabled()

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

class CopyFilePathRelativeToProjectCommand(RelativePathCommand):
    """
    Command to copy the path of the current file relative to its project's root
    directory.
    """
    def run(self, edit):
        (relative_path, _) = self.relative_path(self.view)

        sublime.set_clipboard(relative_path)
        sublime.status_message('Copied relative file')

class CopyFileDirectoryRelativeToProjectCommand(RelativePathCommand):
    """
    Command to copy the directory of the current file relative to its project's
    root directory.
    """
    def run(self, edit):
        (relative_path, _) = self.relative_path(self.view)

        sublime.set_clipboard(os.path.dirname(relative_path))
        sublime.status_message('Copied relative directory')

class CopyFilePathAsIncludeMacroCommand(CFamilyCommand):
    """
    Command to copy the path of the current file relative to its project's root
    directory as a C/C++ #include macro.
    """
    def run(self, edit):
        header_file = self.to_header_file().replace(os.path.sep, '/')
        include = '#include "%s"' % (header_file)

        sublime.set_clipboard(include)
        sublime.status_message('Copied include guard')

class CopyFilePathAsHeaderGuardCommand(CFamilyCommand):
    """
    Command to copy the path of the current file relative to its project's root
    directory as a C/C++ header guard.
    """
    def run(self, edit):
        header_file = self.to_header_file().upper() + '_'
        header_file = re.sub('[^0-9A-Z]+', '_', header_file)

        sublime.set_clipboard(header_file)
        sublime.status_message('Copied include guard')
