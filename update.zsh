#!/usr/bin/env zsh
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
# Last modified: 2014-01-28 11:04
#===============================================================================


# Get general repository changes first

git pull origin master

fix_plugin_bugs () {

  # Fix plugin bugs
  sed -e 's/if match( expand("<sfile>"), expand("$HOME") ) == 0/if match( expand("~\/.vim\/bundle\/perlsupport\/plugin\/perl-support.vim"), expand("~") ) == 0/' ~/.vim/bundle/perlsupport/plugin/perl-support.vim > ~/.vim/bundle/perlsupport/plugin/perl-support2.vim
  sed -e 's/let s:plugin_dir\s\+= expand("<sfile>:p:h:h")/let s:plugin_dir  						= $HOME."\/.vim\/bundle\/perlsupport\/"/' ~/.vim/bundle/perlsupport/plugin/perl-support2.vim > ~/.vim/bundle/perlsupport/plugin/perl-support3.vim
  rm ~/.vim/bundle/perlsupport/plugin/perl-support.vim
  rm ~/.vim/bundle/perlsupport/plugin/perl-support2.vim
  mv ~/.vim/bundle/perlsupport/plugin/perl-support3.vim ~/.vim/bundle/perlsupport/plugin/perl-support.vim

  sed -e 's/if match( expand("<sfile>"), expand("$HOME") ) == 0/if match( expand("~\/.vim\/bundle\/csupport\/plugin\/c.vim"), expand("~") ) == 0/' ~/.vim/bundle/csupport/plugin/c.vim > ~/.vim/bundle/csupport/plugin/c2.vim
  sed -e 's/let s:plugin_dir\s\+= expand("<sfile>:p:h:h")/let s:plugin_dir  						= $HOME."\/.vim\/bundle\/csupport\/"/' ~/.vim/bundle/csupport/plugin/c2.vim > ~/.vim/bundle/csupport/plugin/c3.vim
  rm ~/.vim/bundle/csupport/plugin/c.vim
  rm ~/.vim/bundle/csupport/plugin/c2.vim
  mv ~/.vim/bundle/csupport/plugin/c3.vim ~/.vim/bundle/csupport/plugin/c.vim

  sed -e 's/if match( expand("<sfile>"), expand("$HOME") ) == 0/if match( expand("~\/.vim\/bundle\/bashsupport\/plugin\/bash-support.vim"), expand("~") ) == 0/' ~/.vim/bundle/bashsupport/plugin/bash-support.vim > ~/.vim/bundle/bashsupport/plugin/bash-support2.vim
  sed -e 's/let s:plugin_dir\s\+= expand("<sfile>:p:h:h")/let s:plugin_dir  						= $HOME."\/.vim\/bundle\/bashsupport\/"/' ~/.vim/bundle/bashsupport/plugin/bash-support2.vim > ~/.vim/bundle/bashsupport/plugin/bash-support3.vim
  rm ~/.vim/bundle/bashsupport/plugin/bash-support.vim
  rm ~/.vim/bundle/bashsupport/plugin/bash-support2.vim
  mv ~/.vim/bundle/bashsupport/plugin/bash-support3.vim ~/.vim/bundle/bashsupport/plugin/bash-support.vim

  # Deal with template files
  rm ~/.vim/bundle/bashsupport/bash-support/templates/Templates
  cp ~/.vim/templates/bash-support-TEMPLATE ~/.vim/bundle/bashsupport/bash-support/templates/Templates

  rm ~/.vim/bundle/csupport/c-support/templates/Templates
  cp ~/.vim/templates/c-support-TEMPLATE ~/.vim/bundle/csupport/c-support/templates/Templates

  rm ~/.vim/bundle/perlsupport/perl-support/templates/Templates
  cp ~/.vim/templates/perl-support-TEMPLATE ~/.vim/bundle/perlsupport/perl-support/templates/Templates

  # Add snippets
  rm ~/.vim/bundle/snipmate/snippets/python*
  rm ~/.vim/bundle/snipmate/snippets/perl.snippets
  rm ~/.vim/bundle/snipmate/snippets/sh.snippets

  # Deal with template files
  rm ~/.vim/bundle/bashsupport/bash-support/templates/Templates
  rm ~/.vim/bundle/bashsupport/bash-support/templates/bash.comments.template
  cp ~/.vim/templates/bash-support-TEMPLATE ~/.vim/bundle/bashsupport/bash-support/templates/Templates
  cp ~/.vim/templates/bash.comments.template ~/.vim/bundle/bashsupport/bash-support/templates/
  cd ~/.vim/bundle/bashsupport

  rm ~/.vim/bundle/csupport/c-support/templates/Templates
  rm ~/.vim/bundle/csupport/c-support/templates/c.comments.template
  cp ~/.vim/templates/c-support-TEMPLATE ~/.vim/bundle/csupport/c-support/templates/Templates
  cp ~/.vim/templates/c.comments.template ~/.vim/bundle/csupport/c-support/templates/
  cd ~/.vim/bundle/csupport

  rm ~/.vim/bundle/perlsupport/perl-support/templates/Templates
  rm ~/.vim/bundle/perlsupport/perl-support/templates/comments.templates
  cp ~/.vim/templates/perl-support-TEMPLATE ~/.vim/bundle/perlsupport/perl-support/templates/Templates
  cp ~/.vim/templates/perl.comments.templates ~/.vim/bundle/perlsupport/perl-support/templates/comments.templates
  cd ~/.vim/bundle/perlsupport
 
  # Link new templates
  for i in ~/.vim/templates/template.*; do
    ln -f -s $i ~/.vim/bundle/template/templates/
  done
  cd ~/.vim
  find -L bundle -type l -delete
}

# Check that bundle folder exists
if [ -d ~/.vim/bundle ]; then
  # Update pathogen
  cd ./pathogensource
  git checkout master
  git pull
  cd ..
  rm autoload/pathogen.vim
  mkdir -p autoload
  cd autoload
  ln -s ../pathogensource/autoload/pathogen.vim .
  cd ..

  # Update vim-bundle
  cd ./vim-bundle
  git checkout master
  git pull
  cd ..

  # Update every module
  while read p; do 
    echo vim-bundle update $p
  done < plugin-list
else
  echo "Bundle directory absent, needs repair"
fi

echo "Done!"

