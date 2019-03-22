# sublime

My Sublime Text language settings, theme settings, and plugins. Requires Sublime
Text 3.1 build 3170.

Intended to be used with the following forked projects:
* [Sublime Packages](https://github.com/trflynn89/Packages)
* [Seti Theme](https://github.com/trflynn89/Seti_UI)

## Installation

These commands will clone this project and the above forked projects in a folder
called "Sublime" in the user/home directory. If the projects already exist, they
are updated instead. Then, symbolic links are created to the Sublime Packages
directory to apply the settings.

**Close Sublime Text before installing.**

### Windows (PowerShell)

On Windows 8 and earlier, PowerShell must be run as an administrator to be able
to create the symbolic links. PowerShell can be launched normally on Windows 10.

```PowerShell
Invoke-Command -ScriptBlock ([Scriptblock]::Create((New-Object Net.WebClient).DownloadString('https://raw.githubusercontent.com/trflynn89/dotfiles/master/sublime/install.ps1')))
```

### Linux and OS X

```bash
bash -c "$(curl -fsSL https://raw.githubusercontent.com/trflynn89/dotfiles/master/sublime/install.sh)"
```

## Plugins

The above installation adds the following plugins to the Command Palette and
right-click context menu:

* [copy_file_name](Flynn/copy_path.py) - Copy the name of the current file.
* [copy_file_directory](Flynn/copy_path.py) - Copy the directory of the current
file.
* [copy_file_path_relative_to_project](Flynn/copy_path.py) - Copy the path of
the current file relative to its project's root directory.
* [copy_file_directory_relative_to_project](Flynn/copy_path.py) - Copy the
directory of the current file relative to its project's root directory.
* [copy_file_path_as_include_macro](Flynn/copy_path.py) - Copy the path of the
current file relative to its project's root directory as a C/C++ #include macro.
* [copy_file_path_as_header_guard](Flynn/copy_path.py) - Copy the path of the
current file relative to its project's root directory as a C/C++ header guard.
* [format_file](Flynn/format.py) - Run clang-format on the current file. If any
selections are active, only those selections are formatted.
