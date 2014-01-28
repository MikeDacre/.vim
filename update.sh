#!/usr/bin/bash
#===============================================================================
#
#          FILE:  update.zsh
#
#         USAGE:  ./update.zsh
#
#   DESCRIPTION:  A script to update all submodules in this vim repository
#
#  REQUIREMENTS:  Access to primary git repository and git protocol access
#          BUGS:  ---
#        AUTHOR: Michael Dacre
#       LICENCE: Open Source
#       CREATED: 11/10/2011 22:16:34 PST
#      REVISION: 1.1
# Last modified: 2014-01-28 15:55
#===============================================================================

VIM_HOME="$HOME/.vim"

fix_plugin_bugs () {
  # Fix plugin bugs
  echo "Fixing plugin bugs"

  # Remove conflicting templates for perl and C
  rm $VIM_HOME/bundle/vim-template/templates/{template.c,template.c++,template.cc,template.cpp,template.cxx,template.h} 2>/dev/null
  rm $VIM_HOME/bundle/c.vim/c-support/templates/Templates   2>/dev/null
  cp $VIM_HOME/templates/c-support-TEMPLATE $VIM_HOME/bundle/c.vim/c-support/templates/Templates

  rm $VIM_HOME/bundle/perl-support.vim/perl-support/templates/Templates  2>/dev/null
  cp $VIM_HOME/templates/perl-support-TEMPLATE $VIM_HOME/bundle/perl-support.vim/perl-support/templates/Templates
  rm $VIM_HOME/bundle/c.vim/c-support/templates/Templates  2>/dev/null
  rm $VIM_HOME/bundle/c.vim/c-support/templates/c.comments.template  2>/dev/null
  cp $VIM_HOME/templates/c-support-TEMPLATE $VIM_HOME/bundle/c.vim/c-support/templates/Templates
  cp $VIM_HOME/templates/c.comments.template $VIM_HOME/bundle/c.vim/c-support/templates/

  # Remove builtin snippets that I have replaces
  rm $VIM_HOME/bundle/snipmate.vim/snippets/python*  2>/dev/null
  rm $VIM_HOME/bundle/snipmate.vim/snippets/perl.snippets  2>/dev/null
  rm $VIM_HOME/bundle/snipmate.vim/snippets/sh.snippets  2>/dev/null

  # Link new templates
  for i in $VIM_HOME/templates/template.*; do
    ln -f -s $i $VIM_HOME/bundle/vim-template/templates/
  done
  cd $VIM_HOME
  find -L bundle -type l -delete
}

# Check that bundle folder exists
if [ -d $VIM_HOME/bundle ]; then
  # Update pathogen
  cd ./vim-pathogen
  git checkout master
  git pull
  cd ..
  rm autoload/pathogen.vim
  mkdir -p autoload
  cd autoload
  ln -s ../vim-pathogen/autoload/pathogen.vim .
  cd ..

  # Update vim-bundle
  cd ./vim-bundle
  git checkout master
  git pull
  cd ..

  # Update every module
  while read p; do
    vim-bundle update $p
  done < plugin-list

  # Do my stuff to bundles
  fix_plugin_bugs

else
  echo "Bundle directory absent, needs repair"
fi

echo "Done!"

