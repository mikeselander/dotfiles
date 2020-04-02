#!/bin/bash
set -euo pipefail
IFS=$'\n\t'

# Import our utilities.
. utilities.sh

use_bash

# Verify that we're setup properly.
check_for_software

# Copy configuration files to their home
copy_files

# Brew - the magic is here.
brew_me

# Start off with some CLI utils.
cli_utils

# Install programs.
programs

# Visual Code extensions.
visual_code_extensions

# Node et. al.
node_deps

# PHP et. al
php_deps
install_phpcs

print_message "✅ Installation Complete"
