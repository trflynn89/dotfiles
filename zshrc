#!/usr/bin/env zsh

# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

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

# Clear the terminal including scrollback history.
cls()
{
    printf '\033[2J\033[3J\033[1;1H'
}

# Use ffmpeg to convert a file to an MP4.
convert_to_mp4()
{
    if [[ $# -lt 1 ]] ; then
        echo "Usage: $0 <file to convert>"
        return 1
    fi

    local input="${1}"
    local output="${1%.*}.mp4"

    ffmpeg -i "${input}" -c copy -movflags +faststart "${output}"
}

# Switch primary clang / llvm installation
set_clang_version()
{
    if [[ $# -lt 1 ]] ; then
        echo "Usage: $0 <clang version>"
        return 1
    fi

    local version="${1}"

    sudo update-alternatives --install /usr/bin/clang clang /usr/bin/clang-${version} ${version}00 \
        --slave /usr/bin/clang++ clang++ /usr/bin/clang++-${version} \
        --slave /usr/bin/clang-cpp clang-cpp /usr/bin/clang-cpp-${version} \
        --slave /usr/bin/clang-format clang-format /usr/bin/clang-format-${version} \
        --slave /usr/bin/clangd clangd /usr/bin/clangd-${version} \
        --slave /usr/bin/ld.lld ld.lld /usr/bin/ld.lld-${version} \
        --slave /usr/bin/lld lld /usr/bin/lld-${version} \
        --slave /usr/bin/lld-link lld-link /usr/bin/lld-link-${version} \
        --slave /usr/bin/llvm-ar llvm-ar /usr/bin/llvm-ar-${version} \
        --slave /usr/bin/llvm-as llvm-as /usr/bin/llvm-as-${version} \
        --slave /usr/bin/llvm-bcanalyzer llvm-bcanalyzer /usr/bin/llvm-bcanalyzer-${version} \
        --slave /usr/bin/llvm-config llvm-config /usr/bin/llvm-config-${version} \
        --slave /usr/bin/llvm-cov llvm-cov /usr/bin/llvm-cov-${version} \
        --slave /usr/bin/llvm-diff llvm-diff /usr/bin/llvm-diff-${version} \
        --slave /usr/bin/llvm-dis llvm-dis /usr/bin/llvm-dis-${version} \
        --slave /usr/bin/llvm-dwarfdump llvm-dwarfdump /usr/bin/llvm-dwarfdump-${version} \
        --slave /usr/bin/llvm-extract llvm-extract /usr/bin/llvm-extract-${version} \
        --slave /usr/bin/llvm-link llvm-link /usr/bin/llvm-link-${version} \
        --slave /usr/bin/llvm-mc llvm-mc /usr/bin/llvm-mc-${version} \
        --slave /usr/bin/llvm-nm llvm-nm /usr/bin/llvm-nm-${version} \
        --slave /usr/bin/llvm-objcopy llvm-objcopy /usr/bin/llvm-objcopy-${version} \
        --slave /usr/bin/llvm-objdump llvm-objdump /usr/bin/llvm-objdump-${version} \
        --slave /usr/bin/llvm-ranlib llvm-ranlib /usr/bin/llvm-ranlib-${version} \
        --slave /usr/bin/llvm-readobj llvm-readobj /usr/bin/llvm-readobj-${version} \
        --slave /usr/bin/llvm-rtdyld llvm-rtdyld /usr/bin/llvm-rtdyld-${version} \
        --slave /usr/bin/llvm-size llvm-size /usr/bin/llvm-size-${version} \
        --slave /usr/bin/llvm-stress llvm-stress /usr/bin/llvm-stress-${version} \
        --slave /usr/bin/llvm-strip llvm-strip /usr/bin/llvm-strip-${version} \
        --slave /usr/bin/llvm-symbolizer llvm-symbolizer /usr/bin/llvm-symbolizer-${version} \
        --slave /usr/bin/llvm-tblgen llvm-tblgen /usr/bin/llvm-tblgen-${version}
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

    # Disable Homebrew anayltics
    if [[ $host_os == "Darwin" ]] ; then
        export HOMEBREW_NO_ANALYTICS=1
    fi

    # PATH changes
    path_add "$HOME/.local/bin"
    path_add "$HOME/.cargo/bin"

    if [[ $host_os == "Darwin" ]] ; then
        path_add "/opt/homebrew/bin"
        path_add "/Applications/Sublime Text.app/Contents/SharedSupport/bin"

        if [[ -x $(which xcode-select 2>/dev/null) ]] ; then
            local xcode_sdk_path=$(xcrun --sdk macosx --show-sdk-path)
            local xcode_lib_path="${xcode_sdk_path}/usr/lib"

            path_add "$(xcode-select -p)/Toolchains/XcodeDefault.xctoolchain/usr/bin"

            export LIBRARY_PATH="${LIBRARY_PATH:+$LIBRARY_PATH:}${xcode_lib_path}"
            export SDKROOT="${xcode_sdk_path}"
        fi
    fi

    # Utility aliases
    if [[ -x $(which rg 2>/dev/null) ]] ; then
        alias cgr='rg -n -tc -tcpp -tobjc -tobjcpp'
        alias ggr='rg -n -g \*.gn -g \*.gni'
        alias igr='rg -n -g \*.idl'
        alias jgr='rg -n -tjava'
        alias pgr='rg -n -tpy'
        alias wgr='rg -n -thtml -txml -tcss -tjs -tts'
    else
        alias cgr='grep -Irn --include=\*.{c,cc,cpp,h,hh,hpp,m,mm}'
        alias ggr='grep -Irn --include=\*.{gn,gni}'
        alias igr='grep -Irn --include=\*.{idl}'
        alias jgr='grep -Irn --include=\*.{java,jsp}'
        alias pgr='grep -Irn --include=\*.{py}'
        alias wgr='grep -Irn --include=\*.{html,xml,css,js,ts}'
    fi

    # Git aliases
    if [[ -x $(which ydiff 2>/dev/null) ]] ; then
        alias gd='ydiff -s -w0 --ignore-space-at-eol'
    fi

    alias gds='gd --staged'
    alias gbd='git branch -D'
    alias gch='git checkout HEAD'
    alias gfa='git fetch --all --no-tags --prune --jobs=10'
    alias gfp='git fetch origin --no-tags --prune'
    alias gfm='git fetch origin $(git_main_branch):$(git_main_branch)'
    alias gfu='git fetch upstream $(git_main_branch):$(git_main_branch)'
    alias gro='git rebase origin/$(git_main_branch) --autostash'
    alias gru='git rebase upstream/$(git_main_branch) --autostash'

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

    export HISTSIZE=10000000
    export SAVEHIST=10000000
    setopt hist_find_no_dups
    setopt hist_ignore_all_dups
    setopt hist_ignore_dups
    setopt hist_save_no_dups

    # Import machine specific zshrc
    for zshrc in $(ls ~/.zshrc.* 2>/dev/null) ; do
        source $zshrc
    done
}

init_shell
