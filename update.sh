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
else
  # If this is a first run, clone everything
  rm -rf bundle/*;

  `git submodule add https://github.com/scrooloose/nerdtree.git bundle/nerdtree`;
  `git submodule add https://github.com/tpope/vim-fugitive.git bundle/fugitive`;
  `git submodule add https://github.com/msanders/snipmate.vim.git bundle/snipmate`;
  `git submodule add https://github.com/tpope/vim-surround.git bundle/surround`;
  `git submodule add https://github.com/vim-scripts/bash-support.vim.git bundle/bashsupport`;
  `git submodule add https://github.com/vim-scripts/perl-support.vim.git bundle/perlsupport`;
  `git submodule add https://github.com/vim-scripts/c.vim.git bundle/csupport`;
  `git submodule add https://github.com/vim-scripts/Vim-R-plugin.git bundle/rplugin`;
  `git submodule add https://github.com/scrooloose/nerdcommenter.git bundle/commenter`;
  `git submodule add https://github.com/vim-scripts/bufexplorer.zip.git bundle/bufexplorer`;
  `git submodule add https://github.com/rson/vim-conque.git bundle/vimconque`;
  `git submodule add https://github.com/mirell/vim-matchit.git bundle/matchit`;
  `git submodule add https://github.com/vim-scripts/sessionman.vim.git bundle/sessionman`;
  `git submodule add https://github.com/superjudge/tasklist-pathogen.git bundle/tasklist`;
  `git submodule add https://github.com/vim-scripts/taglist.vim.git bundle/taglist`;
  `git submodule add https://github.com/tpope/vim-git.git bundle/vimgit`;
  `git submodule add https://github.com/ervandew/supertab.git bundle/superbtab`;
  `git submodule add https://github.com/vim-scripts/Command-T.git bundle/commandt`;
  `git submodule add https://github.com/sjl/gundo.vim.git bundle/gundo`;
  `git submodule add https://github.com/mileszs/ack.vim.git bundle/ack`;
  `git submodule add https://github.com/klen/python-mode.git bundle/pythonmode`;
  `git submodule add https://github.com/jcrocholl/pep8.git bundle/pep8`;
  `git submodule add https://github.com/JoseBlanca/vim-for-python.git bundle/vimforpython `;

  # Sync all
  `git submodule init`;
  `git submodule update`;
  `git submodule foreach git submodule init`;
  `git submodule foreach git submodule update`;

fi

git add .;
git commit -a -m "Updated" ;
git push origin master;

echo "Done!";

