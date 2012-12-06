#!/usr/bin/env zsh 
#===============================================================================
#
#          FILE:  update-vim.zsh
# 
#         USAGE:  ./update-vim.zsh 
# 
#   DESCRIPTION:  Simple script to update vim
# 
#       OPTIONS:  ---
#  REQUIREMENTS:  ---
#          BUGS:  ---
#         NOTES:  ---
#        AUTHOR: Mike Dacre
#       LICENCE: Copyright (c) 2011, Mike Dacre
#       COMPANY: 
#       CREATED: 11/11/2011 12:00:40 PM PST
#      REVISION:  ---
#===============================================================================

set -o nounset                              # Treat unset variables as an error

hg clone https://vim.googlecode.com/hg/ vim-program;

cd vim-program;

./configure --with-features=huge --prefix=/usr/local --enable-perlinterp=yes --enable-rubyinterp --enable-pythoninterp=yes --enable-python3interp=yes --enable-cscope --enable-gui=none --without-x --with-compiledby=Mike --enable-multibyte;
make;

sudo make install;

cd ..;
rm -rf vim-program;

echo "Done!";

