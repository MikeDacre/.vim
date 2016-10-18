#!/bin/bash
#===============================================================================
#
#   DESCRIPTION:  Update vim in /usr/local - no GUI
#
#===============================================================================

VIMLOCATION=$HOME

mkdir -p $VIMLOCATION

git clone https://github.com/vim/vim.git vim-program

cd vim-program

./configure \
  --prefix=$HOME/usr \
  --with-features=huge \
  --with-compiledby='Mike Dacre' \
  --enable-gpm \
  --enable-acl \
  --with-x=no \
  --disable-gui \
  --enable-multibyte \
  --enable-cscope \
  --enable-netbeans \
  --enable-perlinterp=dynamic \
  --enable-pythoninterp=dynamic \
  --enable-python3interp=dynamic \
  --enable-rubyinterp=dynamic \
  --enable-luainterp=dynamic \
  --enable-tclinterp=dynamic

make

make install

cd ..
#rm -rf vim-program

echo "Done!"
