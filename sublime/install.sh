SUBLIME_DIR=$HOME/Sublime
HOST_OS=$(uname -s)

clone_or_update()
{
    if [[ $# -ne 1 ]] ; then
        echo "Usage: $0 <project>"
        return 1
    fi

    local github="https://github.com/trflynn89"
    local project="$1"

    if [[ -d $SUBLIME_DIR/$project ]] ; then
        git -C $SUBLIME_DIR/$project pull

        if [[ $? -ne 0 ]] ; then
            echo "Could not update $project.git"
            exit 1
        fi

        popd
    else
        git clone $github/$project.git $SUBLIME_DIR/$project

        if [[ $? -ne 0 ]] ; then
            echo "Could not clone $project.git"
            exit 1
        fi
    fi
}

if [[ $HOST_OS == "Darwin" ]] ; then
    dst_dir="~/Library/Application Support/Sublime Text 3/Packages"
elif [[ $HOST_OS == "Linux" ]] ; then
    dst_dir="~/.config/sublime-text-3/Packages"
else
    echo "Unknown host: $(HOST_OS)"
    exit 1
fi

clone_or_update dotfiles
clone_or_update Packages
clone_or_update Seti_UI

ln -sf $(SUBLIME_DIR)/dotfiles/sublime/Preferences.sublime-settings $dst_dir/User

ln -sf $(SUBLIME_DIR)/dotfiles/sublime/Flynn $dst_dir
ln -sf $(SUBLIME_DIR)/dotfiles/sublime/MIB $dst_dir
ln -sf $(SUBLIME_DIR)/dotfiles/sublime/YANG $dst_dir

ln -sf $(SUBLIME_DIR)/Packages/C++ $dst_dir
ln -sf $(SUBLIME_DIR)/Packages/Makefile2 $dst_dir/Makefile

ln -sf $(SUBLIME_DIR)/Seti_UI $dst_dir/Seti_UI
