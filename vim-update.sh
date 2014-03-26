#!/bin/bash
#===============================================================================
#
#   DESCRIPTION:  Update vim in /usr/local - no GUI
#
#===============================================================================

VIMLOCATION=$HOME

mkdir -p $VIMLOCATION

hg clone https://vim.googlecode.com/hg/ vim-program

cd vim-program

./configure --with-features=huge --prefix=$VIMLOCATION --enable-perlinterp=yes --enable-rubyinterp --enable-pythoninterp --enable-cscope --disable-gui --without-x --with-compiledby=Mike --enable-multibyte

make

make install

cd ..
rm -rf vim-program

echo "Done!"
