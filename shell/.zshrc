source ~/.profile
autoload -U compinit; compinit

zstyle ':completion:*' use-cache on
zstyle ':completion:*' menu select
zstyle ':completion:*:default' list-colors ${(s.:.)LS_COLORS}
zstyle ':completion:*' complete-options true
zstyle ':completion:*' matcher-list '' 'm:{a-zA-Z}={A-Za-z}' 'r:|[._-]=* r:|=*' 'l:|=* r:|=*'

zmodload zsh/complist

bindkey -e
bindkey -M menuselect '^[[Z' reverse-menu-complete

PROMPT="%F{green}[%f%F{yellow}%n%f%F{red}@%f%F{blue}%m%f %F{red}%~%f%F{green}]%f "
RPROMPT="%F{red}$0%f"
HISTFILE=~/.zsh_history
HISTSIZE=10000
SAVEHIST=10000
setopt appendhistory

syntax_highligting=/usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
autosuggestions=/usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh
[ -f $syntax_highligting ] && source $syntax_highligting
[ -f $autosuggestions ] && source $autosuggestions
ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=2'
