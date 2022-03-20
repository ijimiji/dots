export PATH=~/.cargo/bin:~/bin:~/.local/bin:$PATH
export NAME=jahor
export EDITOR=nvim

export LS_COLORS="di=01;34:ln=01;93:ex=01;31:or=01;90:cd=01;35:fi=01;32"
export NNN_FCOLORS="010104010203030808050505"

[ $(uname) = Linux ] && alias ls="ls --color=auto"
alias x="startx"
alias please="sudo"

cd() {
    [[ -o interactive ]] && builtin cd "$@" && ls || builtin cd "$@"
}

[ ! -s ~/.config/mpd/mpd.pid ] && mpd 2> /dev/null
