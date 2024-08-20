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
HISTFILE=~/.zsh_history
HISTSIZE=10000
SAVEHIST=10000
setopt appendhistory

ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=8'

if [[ $(uname -a | grep Ubuntu) ]] then
    syntax_highligting=/usr/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
    autosuggestions=/usr/share/zsh-autosuggestions/zsh-autosuggestions.zsh
fi

if [[ $(uname -a | grep Darwin) ]] then
    syntax_highligting=/opt/homebrew/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
    autosuggestions=/opt/homebrew/share/zsh-autosuggestions/zsh-autosuggestions.zsh
else
    syntax_highligting=/usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
    autosuggestions=/usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh
fi

[ -f $syntax_highligting ] && source $syntax_highligting
[ -f $autosuggestions ] && source $autosuggestions

ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=8'
