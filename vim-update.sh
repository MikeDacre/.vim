#!/bin/bash
#===============================================================================
#
#   DESCRIPTION:  Update vim in /usr/local - no GUI
#
#===============================================================================

set -o nounset                              # Treat unset variables as an error

hg clone https://vim.googlecode.com/hg/ vim-program;

cd vim-program;

./configure --with-features=huge --prefix=/usr/local --enable-perlinterp=yes --enable-rubyinterp --enable-pythoninterp --enable-cscope --disable-gui --without-x --with-compiledby=Mike --enable-multibyte;
make;

sudo make install;

cd ..;
rm -rf vim-program;

echo "Done!";

