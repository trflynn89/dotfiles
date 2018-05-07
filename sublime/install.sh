SUBLIME_DIR="$HOME/Sublime"
HOST_OS="$(uname -s)"

if [[ $HOST_OS == "Darwin" ]] ; then
    PACKAGES_DIR="$HOME/Library/Application Support/Sublime Text 3/Packages"
elif [[ $HOST_OS == "Linux" ]] ; then
    PACKAGES_DIR="$HOME/.config/sublime-text-3/Packages"
else
    echo "Unknown host: $(HOST_OS)"
    exit 1
fi

clone_or_update()
{
    local github="https://github.com/trflynn89"
    local project="$1"

    if [[ -d "$SUBLIME_DIR/$project" ]] ; then
        git -C "$SUBLIME_DIR/$project" pull
    else
        git clone $github/$project.git "$SUBLIME_DIR/$project"
    fi

    if [[ $? -ne 0 ]] ; then
        echo "Could not fetch $project"
        exit 1
    fi
}

clone_or_update dotfiles
clone_or_update Packages
clone_or_update Seti_UI

ln -sf "$SUBLIME_DIR/dotfiles/sublime/Preferences.sublime-settings" "$PACKAGES_DIR/User"

ln -sf "$SUBLIME_DIR/dotfiles/sublime/Flynn" "$PACKAGES_DIR"
ln -sf "$SUBLIME_DIR/dotfiles/sublime/MIB" "$PACKAGES_DIR"
ln -sf "$SUBLIME_DIR/dotfiles/sublime/YANG" "$PACKAGES_DIR"

ln -sf "$SUBLIME_DIR/Packages/C++" "$PACKAGES_DIR"
ln -sf "$SUBLIME_DIR/Packages/Makefile2" "$PACKAGES_DIR/Makefile"

ln -sf "$SUBLIME_DIR/Seti_UI" "$PACKAGES_DIR"
