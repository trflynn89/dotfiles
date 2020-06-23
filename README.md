# dotfiles

[sublime](sublime) - My Sublime Text language / theme settings.

[vscode](vscode) - My Visual Studio Code language / theme settings.

[gnome](gnome) - Instructions on how I've tweaked Gnome on Ubuntu.

[zshrc](zshrc) - In conjunction with [oh-my-zsh](https://github.com/robbyrussell/oh-my-zsh) and
[Powerlevel10k](https://github.com/romkatv/powerlevel10k).

```bash
ln -sf $(pwd)/zshrc ~/.zshrc
ln -sf $(pwd)/zshrc.p10k ~/.zshrc.p10k

git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ~/.oh-my-zsh/custom/themes/powerlevel10k
```

[vimrc](vimrc) - Taken from [A Good Vimrc](https://dougblack.io/words/a-good-vimrc.html).

```bash
ln -sf $(pwd)/vimrc ~/.vimrc
```

[keyboard_shortcuts.ahk](keyboard_shortcuts.ahk) - AutoHotkey script for:
* Controlling volume with a mouse
* Putting monitors to sleep
* Switching audio devices
