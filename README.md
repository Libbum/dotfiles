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
- [ ] Fenchurch's dir_colours is massive compared to Soma's. Check if any of it is wanted before killing it off
- [ ] Switch to 256 colours if loggin in externally to Soma
- [ ] Look in to putty colour overrides, .Xdefaults without an X session
- [ ] Move Xdefaults to Xresources
- [X] Really not a fan of the hybrid color scheme, molokai is nice, but too bright. Need a new one. [Now using [αποκλίνων](https://github.com/Libbum/vim-apoklinon)]
