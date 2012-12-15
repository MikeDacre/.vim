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
#        AUTHOR: Michael Dacre (BlackPhoenix),
#       LICENCE: Copyright (c) 2011, Michael Dacre
#       CREATED: 11/10/2011 22:16:34 PST
#      REVISION: 1.1
#       REVISED: 23-11-11 10:26:44
#===============================================================================

set -o nounset                              # Treat unset variables as an error

# Get general repository changes first

git pull origin master;

# Check if this is a first run or not
if [ -d ~/.vim/bundle ]; then
  if [ "$(ls -A bundle/nerdtree)" ]; then


    # If not, just update all plugins
    cd bundle;

    # Now get all individual plugin updates
    for i in *; do
      cd $i;
      git add .;
      git commit -am "Syncing";
      git pull;
      cd ..;
    done

    cd ../pathogensource;
    git pull;
    cd ..;

    # Do generic update stuff first
    git submodule update;
    git submodule foreach git submodule init;
    git submodule foreach git submodule update;

    rm autoload/pathogen.vim;
    mkdir -p autoload;
    cd autoload;
    ln -s ../pathogensource/autoload/pathogen.vim .;
    cd ..;

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
    rm ~/.vim/bundle/bashsupport/bash-support/templates/Templates;
    cp ~/.vim/templates/bash-support-TEMPLATE ~/.vim/bundle/bashsupport/bash-support/templates/Templates;

    rm ~/.vim/bundle/csupport/c-support/templates/Templates;
    cp ~/.vim/templates/c-support-TEMPLATE ~/.vim/bundle/csupport/c-support/templates/Templates;

    rm ~/.vim/bundle/perlsupport/perl-support/templates/Templates;
    cp ~/.vim/templates/perl-support-TEMPLATE ~/.vim/bundle/perlsupport/perl-support/templates/Templates;

    git add .;
    git commit -a -m "Updated" ;
    git push origin master;

  else
    # If this is a first run, clone everything
    echo "Building new repo";
    rm -rf bundle/*;
    rm -rf pathogensource;

    git add .;
    git commit -a -m "Cleaning new repo";

    git submodule add git://github.com/scrooloose/nerdtree.git bundle/nerdtree;
    git submodule add git://github.com/jcfaria/Vim-R-plugin.git bundle/rplugin;
    git submodule add git://github.com/tpope/vim-fugitive.git bundle/fugitive;
    git submodule add git://github.com/sjl/gundo.vim.git bundle/gundo;
    git submodule add git://github.com/msanders/snipmate.vim.git bundle/snipmate;
    git submodule add git://github.com/tpope/vim-surround.git bundle/surround;
    git submodule add git://github.com/vim-scripts/bash-support.vim.git bundle/bashsupport;
    git submodule add git://github.com/vim-scripts/perl-support.vim.git bundle/perlsupport;
    git submodule add git://github.com/vim-scripts/c.vim.git bundle/csupport;
    git submodule add git://github.com/vim-scripts/AutoComplPop.git bundle/autocomplpopup;
    git submodule add git://github.com/vim-scripts/sessionman.vim.git bundle/sessionman;
    git submodule add git://github.com/vim-scripts/bufexplorer.zip.git bundle/bufexplorer;
    git submodule add git://github.com/vim-scripts/taglist.vim.git bundle/taglist;
    git submodule add git://github.com/vim-scripts/python.vim--Vasiliev.git bundle/pythonsyntax;
    git submodule add git://github.com/codito/python-mode.git bundle/pythonmode;
    git submodule add git://github.com/scrooloose/nerdcommenter.git bundle/commenter;
    git submodule add git://github.com/mirell/vim-matchit.git bundle/matchit;
    git submodule add git://github.com/superjudge/tasklist-pathogen.git bundle/tasklist;
    git submodule add git://github.com/mileszs/ack.vim.git bundle/ack;
    git submodule add git://github.com/fs111/pydoc.vim.git bundle/pydoc;
    git submodule add git://github.com/vim-scripts/python.vim.git bundle/pythonmenu;
    git submodule add git://github.com/rson/vim-conque.git bundle/conque;
    git submodule add git://github.com/benmills/vimux.git bundle/vimux;
    git submodule add git://github.com/vim-scripts/dbext.vim.git bundle/dbext;
    git submodule add git://github.com/exu/pgsql.vim.git bundle/pgsql_syntax;

    git submodule add git://github.com/tpope/vim-pathogen.git pathogensource;
    rm autoload/pathogen.vim;
    mkdir -p autoload;
    cd autoload;
    ln -s ../pathogensource/autoload/pathogen.vim .;
    cd ..;

    # Make python mode python 3 compatible
    cd bundle/pythonmode/;
    git checkout origin/python3;
    cd ../..;

    # Sync all
    git submodule init;
    git submodule update;
    git submodule foreach git submodule init;
    git submodule foreach git submodule update;

    mv -f ~/.vimrc ~/vimrc_old_`date "+%y%m%d%k%M"` &>/dev/null;
    ln -s ~/.vim/vimrc ~/.vimrc;

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
    rm ~/.vim/bundle/bashsupport/bash-support/templates/Templates;
    cp ~/.vim/templates/bash-support-TEMPLATE ~/.vim/bundle/bashsupport/bash-support/templates/Templates;
    cd ~/.vim/bundle/bashsupport;
    git add .;
    git commit -a -m "Synced template file";

    rm ~/.vim/bundle/csupport/c-support/templates/Templates;
    cp ~/.vim/templates/c-support-TEMPLATE ~/.vim/bundle/csupport/c-support/templates/Templates;
    cd ~/.vim/bundle/csupport;
    git add .;
    git commit -a -m "Synced template file";

    rm ~/.vim/bundle/perlsupport/perl-support/templates/Templates;
    cp ~/.vim/templates/perl-support-TEMPLATE ~/.vim/bundle/perlsupport/perl-support/templates/Templates;
    cd ~/.vim/bundle/perlsupport;
    git add .;
    git commit -a -m "Synced template file";

    cd ~/.vim;

    git add .;
    git commit -a -m "Created new repo in $HOST";
    git push origin master;

  fi
else
  echo "Bundle directory absent, needs repair"
fi

echo "Done!";

