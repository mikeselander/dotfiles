# include .bashrc if it exists
if [ -f "$HOME/.bashrc" ]; then
    . "$HOME/.bashrc"
fi

alias composer="php /usr/local/bin/composer.phar"
alias gitco='function _gitco(){ git checkout $1; git pull; }; _gitco'

eval $(thefuck --alias)
