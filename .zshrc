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
# DISABLE_AUTO_UPDATE="true"

# Uncomment following line if you want to disable colors in ls
# DISABLE_LS_COLORS="true"

# Uncomment following line if you want to disable autosetting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment following line if you want red dots to be displayed while waiting for completion
# COMPLETION_WAITING_DOTS="true"

unsetopt nomatch

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Example format: plugins=(rails git textmate ruby lighthouse)
plugins=(bundler git osx extract github)

source $ZSH/oh-my-zsh.sh
# source /etc/profile.d/rvm.sh

#PATH=/Applications/xampp/xamppfiles/bin:$PATH
#PATH=$PATH
M2_HOME=/Users/vsushkov/repos/system/apache-maven-2.2.1
export PATH="$(brew --prefix php54)/bin:$PATH"
PATH="$(brew --prefix josegonzalez/php/php54)/bin:$PATH"
PATH=$M2_HOME:$HOME/bin:/usr/local/bin:/usr/local/sbin:/Users/vsushkov/lib/android-sdk-macosx/tools:$PATH

#bindkey -v

# Customize to your needs...
alias l="ls -1"
alias ll="ls -lash"
alias la="ls -a"
alias u="t"
alias phpunit="phpunit --colors"
alias :e="vim"
alias :q="exit"

function rvmrcify {
    dir=`basename $PWD`
    ruby_version=1.9.3
    if [ $# -ne 0 ]
    then
        ruby_version=$1
    fi
    echo "rvm use --create $ruby_version@$dir" > .rvmrc
    source .rvmrc
}
