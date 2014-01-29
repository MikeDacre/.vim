my-vim
======

My personal .vim folder.  Uses vim-bundle and pathogen to manage plugins.
Not intended for public use, there are better .vimrc files out there; 
feel free to use it however you please though!

Use
---

Clone repo: ```git clone --recursive https://github.com/MikeDacre/my-vim.git ~/.vim```

Create vimrc symlink: ```ln -s ~/.vim/vimrc ~/.vimrc```

Update all plugins: ```~/.vim/update.sh```


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
