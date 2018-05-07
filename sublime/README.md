# sublime

My Sublime Text language / theme settings. Requires Sublime Text 3.1 build 3170.

Intended to be used with the following forked projects:
* [Sublime Packages](https://github.com/trflynn89/Packages)
* [Seti Theme](https://github.com/trflynn89/Seti_UI).

## Installation

These commands will clone this project and the above forked projects in a folder
called "Sublime" in the user/home directory. If the projects already exist, they
are updated instead. Then, symbolic links are created to the Sublime Packages
directory to apply the settings.

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
