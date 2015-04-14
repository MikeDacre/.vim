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

./configure --with-features=huge --prefix=/usr/local --enable-perlinterp=yes --enable-rubyinterp --enable-python3interp --enable-cscope --with-compiledby=Mike --enable-multibyte

make

#make install

cd ..
#rm -rf vim-program

echo "Done!"
