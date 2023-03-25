#!/usr/bin/env bash
SUBLIME_DIR="${HOME}/Sublime"
HOST_OS="$(uname -s)"

if [[ ${HOST_OS} == "Darwin" ]] ; then
    if [[ -d "${HOME}/Library/Application Support/Sublime Text 3" ]] ; then
        PACKAGES_DIR="${HOME}/Library/Application Support/Sublime Text 3/Packages"
    else
        PACKAGES_DIR="${HOME}/Library/Application Support/Sublime Text/Packages"
    fi
    PREFERENCES="Preferences (OSX).sublime-settings"
elif [[ ${HOST_OS} == "Linux" ]] ; then
    if [[ -d "${HOME}/.config/sublime-text-3" ]] ; then
        PACKAGES_DIR="${HOME}/.config/sublime-text-3/Packages"
    else
        PACKAGES_DIR="${HOME}/.config/sublime-text/Packages"
    fi
    PREFERENCES="Preferences (Linux).sublime-settings"
else
    echo "Unknown host: ${HOST_OS}"
    exit 1
fi

clone()
{
    local github="https://github.com/trflynn89"
    local project="${1}"

    git clone "${github}/${project}.git" "${SUBLIME_DIR}/${project}.tmp"

    if [[ $? -ne 0 ]] ; then
        echo "Could not fetch ${project}"
        exit 1
    fi

    rm -rf "${SUBLIME_DIR}/${project}"
    mv "${SUBLIME_DIR}/${project}.tmp" "${SUBLIME_DIR}/${project}"
}

make_link()
{
    local source="${SUBLIME_DIR}/${1}"
    local dest

    if [[ $# -eq 1 ]] ; then
        dest="$PACKAGES_DIR/$(basename ${1})"
    else
        dest="$PACKAGES_DIR/$2"
    fi

    rm -rf "${dest}"
    ln -sf "${source}" "${dest}"
}

clone dotfiles
clone Packages
clone Seti_UI
clone sublime-copy-paths
clone sublime-format

git -C "${SUBLIME_DIR}/Packages" remote add upstream https://github.com/sublimehq/Packages.git

make_link "dotfiles/sublime/LSP.sublime-settings" "User/LSP.sublime-settings"
make_link "dotfiles/sublime/LSP-clangd.sublime-settings" "User/LSP-clangd.sublime-settings"
make_link "dotfiles/sublime/Preferences.sublime-settings" "User/Preferences.sublime-settings"
make_link "dotfiles/sublime/$PREFERENCES" "Preferences.sublime-settings"

make_link "dotfiles/sublime/Default"
make_link "dotfiles/sublime/Flynn"
make_link "dotfiles/sublime/GN"

make_link "Packages/C++"
make_link "Packages/Objective-C"
make_link "Packages/Makefile"
make_link "Packages/Java"

make_link "Seti_UI"

make_link "sublime-copy-paths"
make_link "sublime-format"
