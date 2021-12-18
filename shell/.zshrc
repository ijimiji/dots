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

source ~/.config/zsh/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
source ~/.config/zsh/zsh-autosuggestions/zsh-autosuggestions.zsh
