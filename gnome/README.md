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

    * Dash to Dock `dash-to-dock@micxgx.gmail.com`
        * Position and size
            * Icon size limit: 32px
        * Launchers
            * Show trash can: off
            * Show mounted volumes and devices: off
        * Behavior
            * Click action: Focus or show previews

    * Night Light Slider `night-light-slider.timur@linux.com`
        * Show always

    * Hide Activities Button `hide-activities-button@gnome-shell-extensions.bookmarkd.xyz`

    * Volume Scroller `volume_scroller@trflynn89.pm.me`

    ```bash
    ln -sf $(pwd)/volume_scroller@trflynn89.pm.me ~/.local/share/gnome-shell/extensions
    ```

### Enable

1. Applications menu

2. Desktop icons
    * Uncheck personal folder and trash icon
    * Uncheck 'Mounted Volumes'

3. User themes

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

1. Background color: #151718
2. Palette entry 4: #a2e9f6
3. Palette entry 12: #6fb4ff
4. Palette entry 14: #34e2e2

### Scrolling

1. Uncheck "Limit scrollback"


# GCC 10

```bash
sudo apt install -y gcc-10 g++-10
sudo update-alternatives --install /usr/bin/gcc gcc /usr/bin/gcc-10 1000 --slave /usr/bin/g++ g++ /usr/bin/g++-10 --slave /usr/bin/gcov gcov /usr/bin/gcov-10
```
