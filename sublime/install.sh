SUBLIME_DIR="$HOME/Sublime"
HOST_OS="$(uname -s)"

if [[ $HOST_OS == "Darwin" ]] ; then
    PACKAGES_DIR="$HOME/Library/Application Support/Sublime Text 3/Packages"
    PREFERENCES="Preferences (OSX).sublime-settings"
elif [[ $HOST_OS == "Linux" ]] ; then
    PACKAGES_DIR="$HOME/.config/sublime-text-3/Packages"
    PREFERENCES="Preferences (Linux).sublime-settings"
else
    echo "Unknown host: $(HOST_OS)"
    exit 1
fi

clone_or_update()
{
    local github="https://github.com/trflynn89"
    local project="$1"

    if git -C "$SUBLIME_DIR/$project" rev-parse --git-dir > /dev/null 2>&1
    then
        git -C "$SUBLIME_DIR/$project" reset --hard
        git -C "$SUBLIME_DIR/$project" pull
    else
        rm -rf "$SUBLIME_DIR/$project"
        git clone $github/$project.git "$SUBLIME_DIR/$project"
    fi

    if [[ $? -ne 0 ]] ; then
        echo "Could not fetch $project"
        exit 1
    fi
}

make_link()
{
    local source="$SUBLIME_DIR/$1"
    local dest="$PACKAGES_DIR/$2"

    rm -rf "$dest"
    ln -sf "$source" "$dest"
}

clone_or_update dotfiles
clone_or_update Packages
clone_or_update Seti_UI

make_link "dotfiles/sublime/Preferences.sublime-settings" "User/Preferences.sublime-settings"
make_link "dotfiles/sublime/$PREFERENCES" "$PREFERENCES"

make_link "dotfiles/sublime/Flynn" "Flynn"
make_link "dotfiles/sublime/MIB" "MIB"
make_link "dotfiles/sublime/YANG" "YANG"
make_link "dotfiles/sublime/GN" "GN"

make_link "Packages/C++" "C++"
make_link "Packages/Makefile2" "Makefile"
make_link "Packages/Objective-C" "Objective-C"

make_link "Seti_UI" "Seti_UI"
