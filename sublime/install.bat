@echo off & setlocal

set SUBLIME_DIR=%UserProfile%\Sublime
set PACKAGES_DIR=%AppData%\Sublime Text 3\Packages

call:clone_or_update dotfiles
if %errorlevel% GEQ 1 goto :eof

call:clone_or_update Packages
if %errorlevel% GEQ 1 goto :eof

call:clone_or_update Seti_UI
if %errorlevel% GEQ 1 goto :eof

mklink "%PACKAGES_DIR%\User\Preferences.sublime-settings" %SUBLIME_DIR%\dotfiles\sublime\Preferences.sublime-settings

mklink /D "%PACKAGES_DIR%\Flynn" %SUBLIME_DIR%\dotfiles\sublime\Flynn
mklink /D "%PACKAGES_DIR%\MIB" %SUBLIME_DIR%\dotfiles\sublime\MIB
mklink /D "%PACKAGES_DIR%\YANG" %SUBLIME_DIR%\dotfiles\sublime\YANG

mklink /D "%PACKAGES_DIR%\C++" %SUBLIME_DIR%\Packages\C++
mklink /D "%PACKAGES_DIR%\Makefile" %SUBLIME_DIR%\Packages\Makefile2

mklink /D "%PACKAGES_DIR%\Seti_UI" %SUBLIME_DIR%\Seti_UI

exit /B 0

:clone_or_update
    set github="https://github.com/trflynn89"
    set project=%1

    if exist %SUBLIME_DIR%\%project% (
        git -C %SUBLIME_DIR%\%project% pull
        if %errorlevel% GEQ 1 echo Could not update %project% & exit /B /1
    ) else (
        git clone %github%/%project%.git %SUBLIME_DIR%\%project%
        if %errorlevel% GEQ 1 echo Could not clone %project% & exit /B /1
    )

    exit /B /0
