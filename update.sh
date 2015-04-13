#!/bin/bash
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
# Last modified: 2015-04-13 14:35
#===============================================================================

VIM_HOME="$HOME/.vim"

fix_plugin_bugs () {
  # Fix plugin bugs
  echo "Fixing plugin bugs"

  # Remove conflicting templates for perl
  rm $VIM_HOME/bundle/perl-support.vim/perl-support/templates/Templates  2>/dev/null
  cp $VIM_HOME/templates/perl-support-TEMPLATE $VIM_HOME/bundle/perl-support.vim/perl-support/templates/Templates

  # Remove builtin snippets that I have replaces
  cd $VIM_HOME/snippets
  for i in *; do
    rm $VIM_HOME/bundle/snipmate.vim/snippets/$i 2>/dev/null
  done
  cd $VIM_HOME

  # Link new templates
  cd $VIM_HOME/templates
  for i in \=template\=*; do
    cd $VIM_HOME/bundle/vim-template/templates/
    rm $i 2>/dev/null 
    ln -f -s $VIM_HOME/templates/$i $i
  done
  cd $VIM_HOME/bundle/vim-table-mode/plugin/
  patch < $VIM_HOME/patches/table-mode.patch
  cd $VIM_HOME

  # Delete broken links
  find -L bundle -type l | xargs rm
}

# Check that bundle folder exists
if [ -d $VIM_HOME/bundle ]; then
  # Go to vim folder
  cd $VIM_HOME

  # Update pathogen
  cd $VIM_HOME/vim-pathogen
  git checkout master
  git pull
  cd $VIM_HOME
  rm $VIM_HOME/autoload/pathogen.vim
  mkdir -p autoload
  cd autoload
  ln -s ../vim-pathogen/autoload/pathogen.vim .
  cd ..

  # Update vim-bundle
  cd $VIM_HOME/vim-bundle
  git checkout master
  git pull
  cd $VIM_HOME

  # Update every module
  while read p; do
    $VIM_HOME/vim-bundle/vim-bundle update $p
  done < plugin-list

  # Do my stuff to bundles
  fix_plugin_bugs

else
  echo "Bundle directory absent, needs repair"
fi

echo "Done!"

