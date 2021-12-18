export NAME=jahor
export EDITOR=nvim
alias emacs="emacs -nw ."
alias exa="exa --icons"
alias ex="exa -1"
alias ls="ls --color=auto"
export LS_COLORS="di=01;34:ln=01;93:ex=01;31:or=01;90:cd=01;35:fi=01;32"
export NNN_FCOLORS="010104010203030808050505"
alias please="sudo"
alias nvd="neovide --multigrid"

cd() {
    builtin cd "$@" && ls
}
[ ! -s ~/.config/mpd/mpd.pid ] && mpd 2> /dev/null
