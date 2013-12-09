# Path to your oh-my-zsh configuration.
ZSH=$HOME/.oh-my-zsh

# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
# Optionally, if you set this to "random", it'll load a random theme each
# time that oh-my-zsh is loaded.
#ZSH_THEME="edvardm"
ZSH_THEME="vsushkov"

# Set to this to use case-sensitive completion
# CASE_SENSITIVE="true"

# Comment this out to disable weekly auto-update checks
DISABLE_AUTO_UPDATE="true"

# Uncomment following line if you want to disable colors in ls
# DISABLE_LS_COLORS="true"

# Uncomment following line if you want to disable autosetting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment following line if you want red dots to be displayed while waiting for completion
COMPLETION_WAITING_DOTS="true"

unsetopt nomatch

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Example format: plugins=(rails git textmate ruby lighthouse)
plugins=(themes bundler git brew capistrano rbenv gem)
fpath=(/usr/local/share/zsh-completions $fpath)

export PATH="/usr/local/bin:$PATH"
export PATH="/usr/local/sbin:$PATH"

source $ZSH/oh-my-zsh.sh

export EDITOR="vim"
export VISUAL="vim"

#bindkey -v

# Customize to your needs...
alias l="ls -1"
alias ll="ls -lash"
alias la="ls -a"
alias u="t"
alias phpunit="vendor/bin/phpunit --colors"
alias :e="vim"
alias :q="exit"
alias vim="mvim"
alias gym="/Users/vsushkov/dev/bin/gym"
#alias git="hub"

autoload -U up-line-or-beginning-search
autoload -U down-line-or-beginning-search
zle -N up-line-or-beginning-search
zle -N down-line-or-beginning-search
bindkey "^[[A" up-line-or-beginning-search # Up
bindkey "^[[B" down-line-or-beginning-search # Down
