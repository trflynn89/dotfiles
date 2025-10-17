# Terminal Installations

## Fedora

1. Enable RPM fusion

    ```bash
    sudo dnf install https://download1.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm
    ```

1. Enable full ffmpeg https://rpmfusion.org/Howto/Multimedia

    ```bash
    sudo dnf swap ffmpeg-free ffmpeg --allowerasing
    sudo dnf swap mesa-va-drivers mesa-va-drivers-freeworld
    sudo dnf swap mesa-vdpau-drivers mesa-vdpau-drivers-freeworld
    ```

1. Add [Sublime Text](https://www.sublimetext.com/docs/linux_repositories.html#yum) configuration

    ```bash
    sudo rpm -v --import https://download.sublimetext.com/sublimehq-rpm-pub.gpg
    sudo dnf config-manager --add-repo https://download.sublimetext.com/rpm/stable/x86_64/sublime-text.repo
    ```

1. Installations

    ```bash
    sudo dnf install -y arc-kde git python3 python3-pip ripgrep sublime-text vim zsh
    pip3 install setuptools
    pip3 install ydiff
    ```

1. Install [Ubuntu Font Family](https://design.ubuntu.com/font)

    ```bash
    mkdir -p ~/.local/share/fonts
    mv ubuntu-font-family-0.83 ~/.local/share/fonts
    ```

## Ubuntu

1. Add [Sublime Text](https://www.sublimetext.com/docs/linux_repositories.html#apt) configuration

    ```bash
    wget -qO - https://download.sublimetext.com/sublimehq-pub.gpg | gpg --dearmor | sudo tee /etc/apt/trusted.gpg.d/sublimehq-archive.gpg > /dev/null
    echo "deb https://download.sublimetext.com/ apt/stable/" | sudo tee /etc/apt/sources.list.d/sublime-text.list
    ```

1. Installations

    ```bash
    sudo apt install -y arc-kde curl git python3 python3-pip ripgrep sublime-text vim zsh
    pip3 install --break-system-packages setuptools
    pip3 install --break-system-packages ydiff
    ```

1. Firefox

    ```bash
    sudo apt install -y flatpak

    flatpak remote-add --if-not-exists flathub https://dl.flathub.org/repo/flathub.flatpakrepo
    flatpak install flathub org.mozilla.firefox
    ```

## Common

1. Installations

    ```bash
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
    ```

1. Configure git

    ```bash
    git config --global user.name "Timothy Flynn"
    git config --global user.email "trflynn89@pm.me"
    git config --global credential.helper store
    ```

# System Settings

## Input & Output

### Mouse & Touchpad

1. Mouse
    1. Pointer speed: 0.40
    1. Scrolling speed: 5 / 15

### Keyboard

1. Shortcuts
    1. Window Management
        1. Switch One Desktop Down: Ctrl+Alt+Down
        1. Switch One Desktop Up: Ctrl+Alt+Up
        1. Window One Desktop Down: Ctrl+Alt+Shift+Down
        1. Window One Desktop Up: Ctrl+Alt+Shift+Up

## Appearance & Style

1. Color & Themes
    1. Global Theme: Arc Dark
    1. Application Style: Breeze
    1. Window Decorations: Arc Dark
        1. Configure Titlebar Buttons
            1. Left icons: Close, minimize, maximize
            1. Right icons: More actions, on all desktops, help
    1. Cursors: Nordic-cursors

## Window Management

1. Virtual Desktops
    1. 3 rows, one desktop per row

## Security & Privacy

1. Screen Locking
    1. Lock screen automatically: Never
1. Recent Files
    1. Remember opened documents: Do not remember

## System

1. Power Management
    1. When inactive: Do nothing
    1. Dim automatically: Never
    1. Turn off screen: Never
1. Session
    1. Desktop Session
        1. On login, launch apps that were open: Start with an empty session

# Konsole

1. Settings
    1. Toolbars Shown
        1. Main Toolbar: Check
        1. Session Toolbar: Check
    1. Toolbar Settings (right-click on each of the above toolbars)
        1. Text Position
            1. Icons Only
    1. Configure Keyboard Shortcuts
        1. Select All: Ctrl+Shift+A

## Profiles

### General

1. General Settings
    1. Command: `/usr/bin/zsh`
    1. Terminal bell mode: Ignore Bell Events

### Appearance

1. Color scheme & font: Breeze

    | Name       | Color   | Intense Color |
    | -----------|---------|---------------|
    | Foreground | #c3c7d1 |               |
    | Background | #0d1016 |               |
    | Color 1    | #073641 | #129cbf       |
    | Color 2    | #eb606b | #eb606b       |
    | Color 3    | #a8ff60 | #56d364       |
    | Color 4    | #f7eb95 | #f7eb95       |
    | Color 5    | #a2e9f6 | #6fb4ff       |
    | Color 6    | #ff2490 | #6c71c3       |
    | Color 7    | #aeddff | #34e2e2       |
    | Color 8    | #ffffff | #ffffff       |

    1. Font: Ubuntu Mono 10pt

1. Cursor
    1. Color: Custom cursor color
        1. Cursor: #657b83
        1. Text: #657b83

### Scrolling

1. Scrollback: Unlimited
1. Highlighting:
    1. Highlight the lines coming into view: Uncheck

### Mouse

1. Text interaction
    1. Copy options
        1. Trim trailing spaces

## Tab Bar / Splitters

1. Appearance
    1. Miscellaneous
        1. Expand individual tab widths to full window

# Dolphin

## Places

1. Home
1. Desktop
1. Documents
1. Downloads
1. Pictures
1. Videos
1. workspace

## Hide sections

1. Remote
1. Recent

## Interface

1. Folders & Tabs
    1. Show on startup: Home folder

1. Confirmations
    1. Ask for confirmation in Dolphin when:
        1. Closing windows with multiple tabs: Uncheck

# Panel Widgets

1. Left Widgets
    1. Application Launcher
        1. Icon: start-here
        1. Show buttons for: Power and sessions
            1. Show action button captions: Uncheck
    1. Pager
        1. Show window outlines: Uncheck
    1. Icons-only Task Manager
        1. Appearance
            1. Show an indicator when a task is playing audio: Uncheck
        1. Behavior
            1. Show only tasks
                1. From current desktop: Uncheck

1. Middle Widgets
    1. Panel Spacer
    1. Digital Clock
        1. Appearance
            1. Information
                1. Show date: Always below time
            1. Show seconds: Always
            1. Date format: Long Date
    1. Panel Spacer

1. Right Widgets
    1. Total CPU Use
        1. Appearance
            1. Display Style: Line Chart
        1. Sensor Details
            1. Sensors
                1. Total Usage: #00aaff
    1. Memory Usage
        1. Appearance
            1. Display Style: Line Chart
        1. Sensor Details
            1. Sensors
                1. Used Physical Memory: #00aa00
    1. Network Speed
        1. Appearance
            1. Display Style: Line Chart
        1. Sensor Details
            1. Sensors
                1. Download Rate: #ff5500
                1. Upload Rate: #aa55ff
    1. Margins Separator
    1. System Tray
