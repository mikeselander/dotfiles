#!/bin/bash
set -euo pipefail
IFS=$'\n\t'

#######################################
# Print a friendly message to the screen.
# Arguments:
#   Message to display
# Returns:
#   None
#######################################
print_message() {
	MESSAGE=$1

	echo tput setaf 2 "\n  $MESSAGE" tput sgr0
}

#######################################
# Print an error message to the screen.
# Arguments:
#   Message to display
# Returns:
#   None
#######################################
print_error() {
	MESSAGE=$1

	tput setaf 1 "\n  $MESSAGE" tput sgr0
}

#######################################
# Ensure that we have required software installed before continuing.
# Arguments:
#   None
# Returns:
#   None
#######################################
check_for_software() {
	HAS_XCODE=`xcode-select --version || echo "false"`

	if [[ $HAS_XCODE = "false" ]]; then
		print_error "You must have Xcode CLI tools installed to continue"
		exit;
	fi
}

#######################################
# I like Bash.
# Arguments:
#   None
# Returns:
#   None
#######################################
use_bash() {
  chsh -s /bin/bash
}

#######################################
# Ensure that Brew is properly setup.
# Arguments:
#   None
# Returns:
#   None
#######################################
brew_me() {
    print_message "🕚 Brew"

    ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
    brew cleanup
    brew doctor
}

#######################################
# Ensure that necessary CLI utils are installed
# Arguments:
#   None
# Returns:
#   None
#######################################
cli_utils() {
    print_message "🕚 Brewing CLI Utils"

    utils=(
        direnv
        htop
        httpie
        wget
        thefuck
        yarn
    );

    for i in ${utils[@]}; do
        brew install $i;
    done

    # Liquid Prompt Start
    cd ~
    git clone https://github.com/nojhan/liquidprompt.git
    source liquidprompt/liquidprompt
}

#######################################
# Ensure that necessary applications are installed
# Arguments:
#   None
# Returns:
#   None
#######################################
programs() {
    print_message "🕚 Brewing Programs"

    programs=(
        1password
        backuploupe
        caffeine
        docker
        dropbox
        firefox
        google-chrome
        iterm2
        kap
        kitematic
        postman
        private-eye
        sequel-pro
        skype
        slack
        spotify
        the-unarchiver
        toggl
        transmit
        visual-studio-code
        whatsapp
        zeplin
        zoomus
    );

    for i in ${programs[@]}; do
        brew cask install $i;
    done
}

#######################################
# Ensure that necessary Visual Code extensions are available.
# Arguments:
#   None
# Returns:
#   None
#######################################
visual_code_extensions() {
    print_message "🕚 Adding Visual Code extensions"

    extensions=(
        dbaeumer.vscode-eslint
        eg2.vscode-npm-script
        ionutvmi.path-autocomplete
        christian-kohler.npm-intellisense
    );

    for i in ${extensions[@]}; do
        code --install-extension $i --force
    done
}

#######################################
# Ensure that Node and accompaniments are available
# Arguments:
#   None
# Returns:
#   None
#######################################
node_deps() {
    print_message "🕚 Adding Node and accompaniments"

    brew install node

    # NVM
    wget -qO- https://raw.githubusercontent.com/creationix/nvm/v0.33.11/install.sh | bash

    extensions=(
        bower
        cordova
        pnpm
        nodemon
    );

    for i in ${extensions[@]}; do
        npm install -g $i
    done
}

#######################################
# Ensure that PHP and accompaniments are available
# Arguments:
#   None
# Returns:
#   None
#######################################
php_deps() {
    print_message "🕚 Adding PHP and accompaniments"

    # Ruby
    brew install rbenv ruby-build
    ruby -v

    # PHP
    # @todo:: homebrew/PHP no longer works.
    brew tap homebrew/php
    mv composer.phar /usr/local/bin/composer

    # MySQL
    brew install mysql
    brew services start mysql

    # WP_CLI
    curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar
    php wp-cli.phar --info

    # Pear
    cd ~
    pear version
    curl -O  http://pear.php.net/go-pear.phar
    php -d detect_unicode=0 go-pear.phar
}

#######################################
# Ensure that PHPCS is installed and available.
# Arguments:
#   None
# Returns:
#   None
#######################################
install_phpcs() {
    brew install php-code-sniffer
    composer create-project wp-coding-standards/wpcs:dev-master --no-dev
}

#######################################
# Copy files from this directory into their appropriate locations.
# Arguments:
#   None
# Returns:
#   None
#######################################
copy_files() {
    print_message "🕚 Copying configuration files to their correct location"

    cp ./.bash_profile ~/.bash_profile
    cp ./.bashrc ~/.bashrc
    cp ./.gitconfig ~/.gitconfig
    cp ./.gitignore_global ~/.gitignore_global

    # Ensure that gitignore global is respected at the user path.
    git config --global core.excludesfile ~/.gitignore_global
}
