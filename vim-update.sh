#!/bin/bash
#===============================================================================
#
#   DESCRIPTION:  Update vim in /usr/local - no GUI
#
#===============================================================================

VIMLOCATION=$HOME/usr

mkdir -p $VIMLOCATION

git clone https://github.com/vim/vim.git vim-program

cd vim-program

./configure \
  --prefix=$VIMLOCATION \
  --with-features=huge \
  --with-compiledby='Mike Dacre' \
  --enable-gpm \
  --enable-acl \
  --with-x=no \
  --disable-gui \
  --enable-multibyte \
  --enable-cscope \
  --enable-netbeans \
  --enable-perlinterp \
  # --enable-pythoninterp=dynamic \
  --enable-python3interp \
  --enable-rubyinterp \
  --enable-luainterp \
  --enable-tclinterp

make

make && make install

cd ..
rm -rf vim-program

echo "Done!"
