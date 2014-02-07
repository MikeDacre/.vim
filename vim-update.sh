#!/bin/bash
#===============================================================================
#
#   DESCRIPTION:  Update vim in /usr/local - no GUI
#
#===============================================================================

VIMLOCATION=$HOME

mkdir -p $VIMLOCATION

hg clone https://vim.googlecode.com/hg/ vim-program
if [ !"$?" ] ; then
  echo "Download failed"
  exit
fi

cd vim-program
if [ !"$?" ] ; then
  echo "Couldn't enter download directory"
  exit
fi

./configure --with-features=huge --prefix=$VIMLOCATION --enable-perlinterp=yes --enable-rubyinterp --enable-pythoninterp --enable-cscope --disable-gui --without-x --with-compiledby=Mike --enable-multibyte
if [ !"$?" ] ; then
  echo "Configure failed"
  cd ..
  exit
fi

make
if [ !"$?" ] ; then
  echo "Make failed"
  cd ..
  exit
fi

make install
if [ !"$?" ] ; then
  echo "Make install failed"
  cd ..
  exit
fi

cd ..
rm -rf vim-program
if [ !"$?" ] ; then
  echo "Couldn't remove download directory"
  cd ..
  exit
fi

echo "Done!"
