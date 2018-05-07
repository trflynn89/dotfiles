# sublime

My Sublime Text language / theme settings. Also provides MIB and YANG syntax highlighting with tailf support.

Intended to be used with my [forked Sublime Packages](https://github.com/trflynn89/Packages) and [forked Seti theme](https://github.com/trflynn89/Seti_UI).

## Windows (powershell) installation

```
git clone https://github.com/trflynn89/dotfiles.git
git clone https://github.com/trflynn89/Packages.git
git clone https://github.com/trflynn89/Seti_UI.git

cmd /c mklink /J "$env:APPDATA/Sublime Text 3/Packages/Flynn" (convert-path ./dotfiles/sublime/Flynn)
cmd /c mklink /J "$env:APPDATA/Sublime Text 3/Packages/MIB" (convert-path ./dotfiles/sublime/MIB)
cmd /c mklink /J "$env:APPDATA/Sublime Text 3/Packages/YANG" (convert-path ./dotfiles/sublime/YANG)

cmd /c mklink /J "$env:APPDATA/Sublime Text 3/Packages/C++" (convert-path ./Packages/MIB)
cmd /c mklink /J "$env:APPDATA/Sublime Text 3/Packages/Makefile" (convert-path ./Packages/Makefile2)

cmd /c mklink /J "$env:APPDATA/Sublime Text 3/Packages/Seti_UI" (convert-path ./Seti_UI)
```

## Linux and OS X installation

```
sh -c "$(wget https://raw.githubusercontent.com/trflynn89/dotfiles/master/sublime/install.sh -O -)"
```
