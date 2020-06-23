#!/usr/bin/env zsh

# Path to your oh-my-zsh installation.
export ZSH=$HOME/.oh-my-zsh

# Set name of the theme to load. Optionally, if you set this to "random"
# it'll load a random theme each time that oh-my-zsh is loaded.
# See https://github.com/robbyrussell/oh-my-zsh/wiki/Themes
ZSH_THEME="powerlevel10k/powerlevel10k"

# Uncomment the following line to disable auto-setting terminal title.
DISABLE_AUTO_TITLE="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
DISABLE_UNTRACKED_FILES_DIRTY="true"

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(
  git
)

source $ZSH/oh-my-zsh.sh

# Add a directory to $PATH if it exists and isn't already in $PATH
path_add()
{
    if [[ -d "$1" ]] && [[ ":$PATH:" != *":$1:"* ]] ; then
        export PATH="$1:$PATH"
    fi
}

# Print terminal colors.
term_colors()
{
    for i in {0..255} ; do
        print -Pn "%K{$i}  %k%F{$i}${(l:3::0:)i}%f " ${${(M)$((i%6)):#3}:+$'\n'}
    done
}

# Initialize everything needed on the shell
init_shell()
{
    local host_os=$(uname -s)

    # On OS X, override keypad bindings
    if [[ $host_os == "Darwin" ]] ; then
        bindkey -s "^[Op" "0"  # 0
        bindkey -s "^[Oq" "1"  # 1
        bindkey -s "^[Or" "2"  # 2
        bindkey -s "^[Os" "3"  # 3
        bindkey -s "^[Ot" "4"  # 4
        bindkey -s "^[Ou" "5"  # 5
        bindkey -s "^[Ov" "6"  # 6
        bindkey -s "^[Ow" "7"  # 7
        bindkey -s "^[Ox" "8"  # 8
        bindkey -s "^[Oy" "9"  # 9
        bindkey -s "^[Ok" "+"  # +
        bindkey -s "^[Om" "-"  # -
        bindkey -s "^[Oj" "*"  # *
        bindkey -s "^[Oo" "/"  # /
        bindkey -s "^[On" "."  # .
        bindkey -s "^[OM" "^M" # Enter
    fi

    # PATH changes
    path_add "$HOME/.local/bin"
    path_add "$HOME/.cargo/bin"

    # Utility aliases
    if [[ -x $(which rg 2>/dev/null) ]] ; then
        alias cgr='rg -n -tc -tcpp -tobjc -tobjcpp'
        alias jgr='rg -n -tjava'
        alias pgr='rg -n -tpy'
        alias wgr='rg -n -thtml -txml -tcss -tjs'
    else
        alias cgr='grep -Irn --include=\*.{c,cc,cpp,h,hh,hpp,m,mm}'
        alias jgr='grep -Irn --include=\*.{java,jsp}'
        alias pgr='grep -Irn --include=\*.{py}'
        alias wgr='grep -Irn --include=\*.{html,xml,css,js}'
    fi

    # Git aliases
    if [[ -x $(which ydiff 2>/dev/null) ]] ; then
        alias gd='ydiff -s -w0 --ignore-space-at-eol'
    fi
    alias gfp='git fetch origin --prune'
    alias gfm='git fetch origin master:master'
    alias gch='git checkout HEAD'
    alias gbd='git branch -D'
    alias gds='gd --staged'

    # Set vim as the default system editor
    if [[ -x $(which vim 2>/dev/null) ]] ; then
        export VISUAL=vim
        export EDITOR="$VISUAL"
    fi

    # Disable gcov/llvm error reporting. GCC 9 is particularly verbose.
    export GCOV_ERROR_FILE="/dev/null"
    export LLVM_PROFILE_FILE="/dev/null"

    # zsh options
    unsetopt auto_cd
    unsetopt nomatch
    unsetopt share_history
    setopt rm_star_silent

    # Import machine specific zshrc
    for zshrc in $(ls ~/.zshrc.* 2>/dev/null) ; do
        source $zshrc
    done
}

init_shell
