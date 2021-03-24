# sublime

My Sublime Text language settings, theme settings, and plugins. Requires Sublime Text 3 build 3170.

Intended to be used with the following forked projects:
* [Sublime Packages](https://github.com/trflynn89/Packages)
* [Seti Theme](https://github.com/trflynn89/Seti_UI)

## Installation

These commands will clone this project and the above forked projects in a folder called "Sublime" in
the user/home directory. Then, symbolic links are created to the Sublime Packages directory to apply
the settings.

Open Sublime Text once after installation - this will setup needed directories.

**Close Sublime Text before continuing.**

### Windows (PowerShell)

PowerShell must be run as an administrator to create the symbolic links.

```PowerShell
Invoke-Command -ScriptBlock ([Scriptblock]::Create((New-Object Net.WebClient).DownloadString('https://raw.githubusercontent.com/trflynn89/dotfiles/main/sublime/install.ps1')))
```

### Linux and OS X

```bash
bash -c "$(curl -fsSL https://raw.githubusercontent.com/trflynn89/dotfiles/main/sublime/install.sh)"
```

## Plugins

The above installation also installs the following plugins:

* [sublime-clang-format](https://github.com/trflynn89/sublime-clang-format)
* [sublime-copy-paths](https://github.com/trflynn89/sublime-copy-paths)

## Language Servers

For projects wishing to use a language server, install the [LSP](https://github.com/sublimelsp/LSP)
package from Package Control. Then modify the project's settings:

1. Disable Sublime's indexing of each folder in the project with `index_exclude_patterns`:

```json
"folders": [
    {
        "path": "project",
        "index_exclude_patterns": [ "*" ],
    },
],
```

2. Configure the LSP package settings (e.g. for clangd):

```json
"settings": {
    "LSP": {
        "only_show_lsp_completions": true,
        "clangd": {
            "command": ["clangd", "--background-index"],
            "enabled": true,
        },
    },
}
```
