#!/bin/bash
#===============================================================================
#
#   DESCRIPTION:  Update vim in /usr/local - no GUI
#
#===============================================================================

git clone https://github.com/vim/vim.git vim-program

cd vim-program

./configure --with-features=huge --prefix=/home/dacre/usr --enable-perlinterp=yes --enable-rubyinterp --enable-python3interp --enable-cscope --with-compiledby=Mike --enable-multibyte

make

make uninstall

cd ..
rm -rf vim-program

echo "Done!"
