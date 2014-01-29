Mike's Vim Folder
=================

My personal .vim folder.  Uses vim-bundle and pathogen to manage plugins.
Not intended for public use, there are better .vimrc files out there; 
feel free to use it however you please though!

Use
---

Clone repo: ```git clone --recursive https://github.com/MikeDacre/.vim.git $HOME/.vim```

Create vimrc symlink: ```ln -s ~/.vim/vimrc ~/.vimrc```

Update all plugins: ```~/.vim/update.sh```

Note: I have provided a script to update vim itself at ```~/.vim/vim-update.sh```, but 
this install a GUI-free version in /usr/local.  This is great for headless nodes where
you have write access to /usr/local, but otherwise it should be modified.

I recommend changing ```--prefix``` to ```$HOME/usr``` and then adding ```$HOME/usr/bin```
to the start of your $PATH.  Also, you can erase the ```--disable-gui``` and ```--without-x```
config parameters if you want gVim.

To add new plugins just add the reference to your plugin to ```~/.vim/plugin-list```
To remove, remove the bundle file, and remove the entry in ```~/.vim/plugin-list```

update.sh
---------
This is just a wrapper for vim-bundle, which allows the refreshing of plugins,
it also contains a little bug fix function that manipulates templates and snippets
to meet my needs... it is very unlikely that these will work for you.

Note on vim-scripts/bashsupport.vim
------------------------------------
I removed this plugin, it had some weird conflicts that I just couldn't figure out
and I don't do enough bash coding to need it.  Be aware that this config is 
incompatible with vim-scripts/bashsupport.vim, I get a bunch of random errors.
