sublime
=======

My sublime language / theme settings. Provides simplified language settings for C/C++ and slightly personalized syntax highlighting. Also provides MIB and YANG syntax highlighting with tailf support.

Editing language resources
------

To edit language/syntax settings, I use PackageResourceViewer. This sublime plugin can be installed with the Package Control plugin.

#####Package Control

Install the Package Control plugin here:
https://sublime.wbond.net/installation

#####ITG Theme

Install the ITG Theme from here:
https://github.com/itsthatguy/theme-itg-flat

#####PackageResourceViewer

Once Package Control is installed, hit Ctrl+Shift+P to open the Command Palette (or go to "Tools > Command Palette...").

In the popup box, start typing "instpkg", which sublime will auto-complete to "Package Control: Install Package". Select this option by hitting enter. Next, start typing PackageResourceViewer and select it. In a few seconds this package will be installed.

#####Editing resources

We can now edit any language file with PackageResourceViewer. Open the Command Palatte and start typing Open Resource. You can then select any language you want to edit, e.g. C++. Replace the C.tmLanguage and C++.tmLanguage files with the files in this repository.

#####Editing syntax highlighting

Copy the Flynn.tmTheme file to same location as the Preferences.sublime-settings file. Then select "Preferences > Color Scheme > User > Flynn". FYI once this file is saved, it can be opened with PackageResourceViewer.

Editing user settings
------

Go to "Preferences >  Settings - User" and replace the file contents with Preferences.sublime-settings file in this repository. This will use the Flynn color scheme with the Seti theme.

YANG syntax highlighting
------

Open the Command Palette, start typing "instpkg" and select the Install Package option. Start typing YANG, and select "YANG Syntax Highlighting".

The yang-syntax.tmLanguage file in this repository fixes some issues with this package and adds support for the "tailf:" statements. Open the Command Palette, start typing Open Resource, and open the YANG > yang-syntax.tmLanguage file. Replace its contents with the file in this repository.

MIB syntax highlighting
------

Create a directory called MIB in the same directory as the C++, YANG, User, etc. directories. Place MIB.tmLanguage from this repository in the MIB directory.

Other recommended packages
------

Makefile Improved: https://sublime.wbond.net/packages/Makefile%20Improved
