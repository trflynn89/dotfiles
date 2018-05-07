# sublime

My Sublime Text language / theme settings. Also provides MIB and YANG syntax
highlighting with tailf support.

Intended to be used the following forked projects:
* [Sublime Packages](https://github.com/trflynn89/Packages)
* [Seti Theme](https://github.com/trflynn89/Seti_UI).

## Windows (PowerShell) installation

PowerShell must be run as an administrator to be able to create the symbolic
links.

```
Invoke-Command -ScriptBlock ([Scriptblock]::Create((New-Object Net.WebClient).DownloadString('https://raw.githubusercontent.com/trflynn89/dotfiles/master/sublime/install.ps1')))
```

## Linux and OS X installation

```
bash -c "$(curl -fsSL https://raw.githubusercontent.com/trflynn89/dotfiles/master/sublime/install.sh)"
```
