dotfiles
========

Various configuration files my linux set-ups. 

Installing
==========

Clone this repository anywhere you like (I use ~/.dotfiles), then run:
git submodule update --init --recursive
to update submodules.
Run makesymlinks.sh to symlink the appropreate stuff. Be sure to modify this file if you don't use ~/.dotfiles

TODO
====

- [X] Modularise this puppy so that my main config sits in the master branch, then submodules load in for specific machine additions (or something like that).
- [X] Most of .bash_profile is for Soma only - move into local module
- [X] Move dvorak keybindings to submodule or check if keymap is dvorak before applying them
- [X] Fenchurch's dir_colours is massive compared to Soma's. Check if any of it is wanted before killing it off
- [X] Switch to 256 colours if loggin in externally to Soma
- [X] Look in to putty colour overrides.
- [X] Move Xdefaults to Xresources
- [X] Really not a fan of the hybrid color scheme, molokai is nice, but too bright. Need a new one. [Now using [αποκλίνων](https://github.com/Libbum/vim-apoklinon)]
- [X] Fork vim-markdown [Added liquid submodule instead, may need to add a few more Octopress markups]
- [X] Fix answerback for urxvt [Increased read length to 7. Update Putty answerback to "ApokPuT"]
- [X] Get dir_colours in order
- [X] dir_colors does not need a separate legacy file, if seding out the offending lines and passing the result to dircolors works
- [X] {vim} needs better tab management
- [X] {vim} rewrite keyboard layout functions to clear both non standard layouts to switch to qwerty, then call other n-s clear function before activating current
- [X] {vim} Vayu is having a spasm with some form of error when saving in vim. Check that out...
- [X] put Soma above FUCKUP in .ssh/config on all machines
- [X] {getClientHost} Reverse dns for hosts that cannot be found in config [partially done]
- [X] {getClientHost} raverse ssh chain to origin (ie, if tunneling through a gateway machine, we need to find the origin) [completed to one hop (not n)] {Also got around these using callbacks}
