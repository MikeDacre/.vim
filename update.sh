#!/bin/bash 
#===============================================================================
#
#          FILE:  update.sh
# 
#         USAGE:  ./update.sh 
# 
#   DESCRIPTION:  A script to update all submodules in this vim repository
# 
#       OPTIONS:  ---
#  REQUIREMENTS:  ---
#          BUGS:  ---
#         NOTES:  ---
#        AUTHOR: YOUR NAME (), 
#       LICENCE: Copyright (c) 2011, YOUR NAME
#       COMPANY: 
#       CREATED: 11/10/2011 22:16:34 PST
#      REVISION:  ---
#===============================================================================

set -o nounset                              # Treat unset variables as an error

# Get general repository changes first
git pull origin master;

# Check if this is a first run or not
if [ "$(ls -A bundle/nerdtree)" ]; then
  # If not, just update all plugins
  cd bundle;

  # Now get all individual plugin updates
  for i in *; do
    cd $i;
    git pull;
    cd ..;
  done
  
  cd ..;
   
  # Deal with template files
  rm ~/.vim/bundle/bashsupport/bash-support/templates/Templates;
  cp ~/.vim/templates/bash-support-TEMPLATE ~/.vim/bundle/bashsupport/bash-support/templates/Templates;
  cd ~/.vim/bundle/bashsupport;
  git add .;
  git commit -a -m "Updated template";
  cd ~/.vim;

  rm ~/.vim/bundle/csupport/c-support/templates/Templates;
  cp ~/.vim/templates/c-support-TEMPLATE ~/.vim/bundle/csupport/c-support/templates/Templates;
  cd ~/.vim/bundle/csupport;
  git add .;
  git commit -a -m "Updated template";
  cd ~/.vim;

  rm ~/.vim/bundle/perlsupport/perl-support/templates/Templates;
  cp ~/.vim/templates/perl-support-TEMPLATE ~/.vim/bundle/perlsupport/perl-support/templates/Templates;
  cd ~/.vim/bundle/perlsupport;
  git add .;
  git commit -a -m "Updated template";
  cd ~/.vim;
 
  git add .;
  git commit -a -m "Updated" ;
  git push origin master;
 
else
  # If this is a first run, clone everything
  echo "Building new repo";
  rm -rf bundle/* &>/dev/null;
  git add . &>/dev/null;
  git commit -a -m "Cleaning new repo" &>/dev/null;

  git submodule add https://github.com/scrooloose/nerdtree.git bundle/nerdtree &>/dev/null;
  git submodule add https://github.com/tpope/vim-fugitive.git bundle/fugitive &>/dev/null;
  git submodule add https://github.com/msanders/snipmate.vim.git bundle/snipmate &>/dev/null;
  git submodule add https://github.com/tpope/vim-surround.git bundle/surround &>/dev/null;
  git submodule add https://github.com/vim-scripts/bash-support.vim.git bundle/bashsupport &>/dev/null;
  git submodule add https://github.com/vim-scripts/perl-support.vim.git bundle/perlsupport &>/dev/null;
  git submodule add https://github.com/vim-scripts/c.vim.git bundle/csupport &>/dev/null;
  git submodule add https://github.com/vim-scripts/Vim-R-plugin.git bundle/rplugin &>/dev/null;
  git submodule add https://github.com/scrooloose/nerdcommenter.git bundle/commenter &>/dev/null;
  git submodule add https://github.com/vim-scripts/bufexplorer.zip.git bundle/bufexplorer &>/dev/null;
  git submodule add https://github.com/rson/vim-conque.git bundle/vimconque &>/dev/null;
  git submodule add https://github.com/mirell/vim-matchit.git bundle/matchit &>/dev/null;
  git submodule add https://github.com/vim-scripts/sessionman.vim.git bundle/sessionman &>/dev/null;
  git submodule add https://github.com/superjudge/tasklist-pathogen.git bundle/tasklist &>/dev/null;
  git submodule add https://github.com/vim-scripts/taglist.vim.git bundle/taglist &>/dev/null;
  git submodule add https://github.com/tpope/vim-git.git bundle/vimgit &>/dev/null;
  git submodule add https://github.com/ervandew/supertab.git bundle/superbtab &>/dev/null;
  git submodule add https://github.com/vim-scripts/Command-T.git bundle/commandt &>/dev/null;
  git submodule add https://github.com/sjl/gundo.vim.git bundle/gundo &>/dev/null;
  git submodule add https://github.com/mileszs/ack.vim.git bundle/ack &>/dev/null;
  git submodule add https://github.com/klen/python-mode.git bundle/pythonmode &>/dev/null;
  git submodule add https://github.com/jcrocholl/pep8.git bundle/pep8 &>/dev/null;
  git submodule add https://github.com/JoseBlanca/vim-for-python.git bundle/vimforpython  &>/dev/null;

  # Sync all
  git submodule init &>/dev/null;
  git submodule update &>/dev/null;
  git submodule foreach git submodule init &>/dev/null;
  git submodule foreach git submodule update &>/dev/null;

  mv ~/.vimrc ~/vimrc_old;
  ln vimrc ~/.vimrc;

  # Deal with template files
  rm ~/.vim/bundle/bashsupport/bash-support/templates/Templates;
  cp ~/.vim/templates/bash-support-TEMPLATE ~/.vim/bundle/bashsupport/bash-support/templates/Templates;
  cd ~/.vim/bundle/bashsupport;
  git add .;
  git commit -a -m "Updated template";
  cd ~/.vim;

  rm ~/.vim/bundle/csupport/c-support/templates/Templates;
  cp ~/.vim/templates/c-support-TEMPLATE ~/.vim/bundle/csupport/c-support/templates/Templates;
  cd ~/.vim/bundle/csupport;
  git add .;
  git commit -a -m "Updated template";
  cd ~/.vim;

  rm ~/.vim/bundle/perlsupport/perl-support/templates/Templates;
  cp ~/.vim/templates/perl-support-TEMPLATE ~/.vim/bundle/perlsupport/perl-support/templates/Templates;
  cd ~/.vim/bundle/perlsupport;
  git add .;
  git commit -a -m "Updated template";
  cd ~/.vim;
 
  git add .;
  git commit -a -m "Updated" ;
  git push origin master;
 
  git add . &>/dev/null;
  git commit -a -m "Created new repo in `hostname`"  &>/dev/null;
  git push origin master;
   
fi


echo "Done!";

