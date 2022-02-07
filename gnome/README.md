# Gnome Tweaks

## Preparation

Install Gnome Tweaks from Ubuntu Software Center, then open Tweaks.

## Appearance

### Themes

1. Applications: Matcha-dark-azul <https://www.gnome-look.org/p/1187179/>

    ```bash
    tar -xvf Matcha-azul.tar.xz
    mkdir ~/.themes
    mv Matcha-dark-azul ~/.themes/
    ```

2. Icons: Papirus-Dark <https://github.com/PapirusDevelopmentTeam/papirus-icon-theme/>

    ```bash
    sudo add-apt-repository ppa:papirus/papirus
    sudo apt update && sudo apt install -y papirus-icon-theme
    ```

3. Shell: Matcha-dark-azul

    Must first enable "User themes" extensions (see Extensions > Enable).

## Extensions

### Install

1. Preparation:

    ```bash
    sudo apt install -y gnome-shell-extensions
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

    * [User Themes](https://extensions.gnome.org/extension/19/user-themes/) `user-theme@gnome-shell-extensions.gcampax.github.com`

    * [Applications Menu](https://extensions.gnome.org/extension/6/applications-menu/) `apps-menu@gnome-shell-extensions.gcampax.github.com`

    * [Dash to Dock](https://extensions.gnome.org/extension/307/dash-to-dock/) `dash-to-dock@micxgx.gmail.com`
        * Position and size
            * Icon size limit: 32px
        * Launchers
            * Show trash can: off
            * Show mounted volumes and devices: off
        * Behavior
            * Click action: Focus or show previews

    * [Night Light Slider](https://extensions.gnome.org/extension/1276/night-light-slider/) `night-light-slider.timur@linux.com`
        * Show always

    * [Hide Activities Button](https://extensions.gnome.org/extension/4325/hide-activities-button/) `hide-activities-button@nmingori.gnome-shell-extensions.org`

    * [Volume Scroller](https://extensions.gnome.org/extension/4109/volume-scroller/) `volume_scroller@trflynn89.pm.me`

### Enable

1. Desktop icons
    * Uncheck personal folder and trash icon
    * Uncheck 'Mounted Volumes'

## Keyboard & Mouse

### Keyboard

1. Overview Shortcut: Right Super (depending on keyboard, really)

## Top Bar

1. Activities Overview Hot Corner: on

### Clock

1. Date: on
1. Seconds: on

## Window Titlebars

### Titlebar Actions

1. Double-Click: Toggle Maximize
2. Middle-Click: None

### Titlebar Buttons

1. Placement: Left

## Workspaces

1. Static Workspaces
2. Number of Workspaces: 3

# Terminal Profile

Install Material profile <https://mayccoll.github.io/Gogh/>

## Global

### General

1. Theme variant: Dark

## Profiles > Material

1. Set Material as default

### Text

1. Terminal bell: off

### Colors

1. Background color: #0d1117
2. Palette entry 4: #a2e9f6
3. Palette entry 12: #6fb4ff
4. Palette entry 14: #34e2e2

### Scrolling

1. Uncheck "Limit scrollback"


# GCC 11

```bash
sudo apt install -y gcc-11 g++-11

sudo update-alternatives --install /usr/bin/gcc gcc /usr/bin/gcc-11 1100
sudo update-alternatives --install /usr/bin/g++ g++ /usr/bin/g++-11 1100
sudo update-alternatives --install /usr/bin/gcov gcov /usr/bin/gcov-11 1100

sudo update-alternatives --install /usr/bin/cc cc /usr/bin/gcc-11 1100
sudo update-alternatives --install /usr/bin/c++ c++ /usr/bin/g++-11 1100
```
