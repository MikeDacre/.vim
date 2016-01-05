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
# Last modified: 2016-01-05 14:49
#===============================================================================

VIM_HOME="$HOME/.vim"

fix_plugin_bugs () {
  # Fix plugin bugs
  echo "Fixing plugin bugs"

  # Remove conflicting templates for perl
  rm $VIM_HOME/bundle/perl-support.vim/perl-support/templates/Templates  2>/dev/null
  cp $VIM_HOME/templates/perl-support-TEMPLATE $VIM_HOME/bundle/perl-support.vim/perl-support/templates/Templates

  # Link new templates
  echo "Taking care of templates"
  cd $VIM_HOME/bundle/vim-template/
  rm -rf templates
  ln -f -s ../../templates .
  cd $VIM_HOME

  # Prevent snipmate from taking tab
  echo "Patching snipmate"
  rm $VIM_HOME/bundle/vim-snipmate/after/plugin/snipMate.vim
  cp $VIM_HOME/patches/snipMate.vim $VIM_HOME/bundle/vim-snipmate/after/plugin/snipMate.vim

  # Delete broken links
  echo "Removing any broken symlinks"
  find -L bundle -type l | xargs rm
}

# Check that bundle folder exists
if [ -d $VIM_HOME/bundle ]; then
  # Go to vim folder
  cd $VIM_HOME

  # # Update pathogen
  # cd $VIM_HOME/vim-pathogen
  # git checkout master
  # git pull
  # cd $VIM_HOME
  # rm $VIM_HOME/autoload/pathogen.vim
  # mkdir -p autoload
  # cd autoload
  # ln -s ../vim-pathogen/autoload/pathogen.vim .
  # cd ..

  # # Update vim-bundle
  # cd $VIM_HOME/vim-bundle
  # git checkout master
  # git pull
  # cd $VIM_HOME

  # # Update every module
  # while read p; do
    # $VIM_HOME/vim-bundle/vim-bundle update $p
    # printf "\033[0m"
  # done < plugin-list

  # Do my stuff to bundles
  fix_plugin_bugs

else
  echo "Bundle directory absent, needs repair"
fi

echo "Done!"

