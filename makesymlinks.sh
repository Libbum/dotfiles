#!/bin/bash
############################
# .make.sh
# This script creates symlinks from the home directory to any desired dotfiles in ~/dotfiles
############################

########## Variables

host=$(hostname)
dir=~/.dotfiles                    # dotfiles directory
olddir=~/dotfiles_old             # old dotfiles backup directory
files="bash_profile bashrc dir_colors gitconfig tmux.conf vim vimrc scripts"    # list of files/folders to symlink in homedir
specfiles="xinitrc Xdefaults"  # system specific files
##########

cd ~

# create dotfiles_old in homedir
echo -n "Creating $olddir for backup of any existing dotfiles in ~ ..."
mkdir -p $olddir
echo " done"

# change to the dotfiles directory
echo -n "Changing to the $dir directory ..."
cd $dir
echo " done"

# move any existing dotfiles in homedir to dotfiles_old directory, then create symlinks from the homedir to any files in the ~/dotfiles directory specified in $files
for file in $files; do
    [ -f ~/.$file ] && mv ~/.$file ~/dotfiles_old/
    echo "Creating symlink to $file in home directory."
    ln -s $dir/$file ~/.$file
done

echo "Moved any existing dotfiles from ~ to $olddir"

echo -n "Configuring any system specific files ..."
for file in $specfiles; do
    [ -f ~/.$file ] && mv ~/.$file ~/dotfiles_old/
    echo "Creating symlink to $file in home directory."
    ln -s $dir/includes/$host/$file ~/.$file
done
if [ -f $dir/includes/$host/vimrc.local ];
then
   [ -f ~/.vimrc.local ] && mv ~/.vimrc.local ~/dotfiles_old/
   ln -s $dir/includes/$host/vimrc.local ~/.vimrc.local
fi
echo " done"

#Below will be usefull later when I get around to moving to zsh

#function install_zsh {
## Test to see if zshell is installed.  If it is:
#if [ -f /bin/zsh -o -f /usr/bin/zsh ]; then
#    # Clone my oh-my-zsh repository from GitHub only if it isn't already present
#    if [[ ! -d $dir/oh-my-zsh/ ]]; then
#        git clone http://github.com/michaeljsmalley/oh-my-zsh.git
#    fi
#    # Set the default shell to zsh if it isn't currently set to zsh
#    if [[ ! $(echo $SHELL) == $(which zsh) ]]; then
#        chsh -s $(which zsh)
#    fi
#else
#    # If zsh isn't installed, get the platform of the current machine
#    platform=$(uname);
#    # If the platform is Linux, try an apt-get to install zsh and then recurse
#    if [[ $platform == 'Linux' ]]; then
#        sudo apt-get install zsh
#        install_zsh
#    # If the platform is OS X, tell the user to install zsh :)
#    elif [[ $platform == 'Darwin' ]]; then
#        echo "Please install zsh, then re-run this script!"
#        exit
#    fi
#fi
#}

#install_zsh
