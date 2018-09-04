# Path to your oh-my-zsh installation.
export ZSH=$HOME/.oh-my-zsh

# Set name of the theme to load. Optionally, if you set this to "random"
# it'll load a random theme each time that oh-my-zsh is loaded.
# See https://github.com/robbyrussell/oh-my-zsh/wiki/Themes
ZSH_THEME="robbyrussell"

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
        export PATH="${PATH:+"$PATH:"}$1"
    fi
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

    # Utility aliases
    alias cdiff='cdiff -s -w0 --ignore-space-at-eol'

    if [[ -x $(which rg) ]] ; then
        alias cgrep='rg -n -tcpp -tobjcpp'
    else
        alias cgrep='grep -Irn --include=\*.{cc,cpp,h,hpp,mm}'
    fi

    # Git aliases
    alias guf='git ls-files --others --exclude-standard'
    alias gno='git --no-pager diff --name-only'
    alias gfp='git fetch origin --prune'
    alias gfm='git fetch origin master:master'

    # zsh options
    unsetopt share_history
    unsetopt nomatch
    setopt rm_star_silent
}

init_shell
