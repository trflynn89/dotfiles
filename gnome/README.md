# Gnome Tweaks

## Preparation

Install Gnome Tweaks from Ubuntu Software Center, then open Tweaks.

## Appearance

### Themes

1. Applications: Matcha-azul <https://www.gnome-look.org/p/1187179/>

    ```bash
    tar -xvf Matcha-azul.tar.xz
    mkdir ~/.themes
    mv Matcha-azul ~/.themes/
    ```

2. Icons: Papirus-Light <https://github.com/PapirusDevelopmentTeam/papirus-icon-theme/>

    ```bash
    sudo add-apt-repository ppa:papirus/papirus
    sudo apt update && sudo apt install -y papirus-icon-theme
    ```

## Desktop

### Icons on Desktop

1. Uncheck 'Trash'
2. Uncheck 'Mounted Volumes'

## Extensions

1. Preparation:

    ```bash
    sudo apt-get install -y gnome-shell-extensions
    mkdir ~/.local/share/gnome-shell/extensions
    ```

    Then log out & back in

2. Extension installation steps:

    Download extension package <https://extensions.gnome.org>

    ```bash
    unzip [package name].[version].shell-extension.zip -d [package name]
    mv [package name] ~/.local/share/gnome-shell/extensions
    ```

    Then log out & back in

3. Extensions to install:

    * Dynamic Panel Transparency
        * Background
            * Enable custom opacity
                * Maximized Opacity: 70%
                * Unmaximized Opacity: 15%
            * Remove excess panel styling

    * Night Light Slider
        * Show always

    * Volume Scroll

## Keyboard & Mouse

### Keyboard

1. Overview Shortcut: Right Super (depending on keyboard, really)

## Top Bar

1. Application Menu: off
2. Activities Overview Hot Corner: on

### Clock

1. Date: on
1. Seconds: on

## Windows

### Titlebar Actions

1. Double-Click: Toggle Maximize

### Titlebar Buttons

1. Placement: Left

## Workspaces

1. Static Workspaces
2. Number of Workspaces: 3

# Terminal Profile

Install Material profile <https://mayccoll.github.io/Gogh/>

Go to Edit > Preferences > Material

## Profiles

1. Set Material as default

## Text

1. Terminal bell: off

## Colors

1. Color Palette Color 12: #6fb4ff
2. Color Palette Color 14: #34e2e2

# GCC 8

```bash
sudo apt-get install -y gcc-8 g++-8

sudo update-alternatives --install /usr/bin/gcc gcc /usr/bin/gcc-7 700 --slave /usr/bin/g++ g++ /usr/bin/g++-7
sudo update-alternatives --install /usr/bin/gcc gcc /usr/bin/gcc-8 800 --slave /usr/bin/g++ g++ /usr/bin/g++-8

sudo update-alternatives --install /usr/bin/gcov gcov /usr/bin/gcov-7 700
sudo update-alternatives --install /usr/bin/gcov gcov /usr/bin/gcov-8 800
```
