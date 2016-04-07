#!/bin/bash
############################
# .make.sh
# This script creates symlinks from the home directory to any desired dotfiles in ~/dotfiles
############################

########## Variables

host=${HOSTNAME%%[.0-9]*}       #multiple checks. Remove full domain, remove multiple login servers for clustered machines (Vayu2, Vayu3 etc), circumvent Soma's hostname -s ipv6 lag
dir=~/.dotfiles                    # dotfiles directory
olddir=~/dotfiles_old             # old dotfiles backup directory
folders="vim scripts"             # list of directories to symlink to homedir
files="bash_profile bashrc tmux.conf vimrc latexmkrc"    # list of file to symlink in homedir
specfiles="xinitrc xprofile Xresources vimrc.local gitconfig ghci zathurarc"  # system specific files, these do not have to exist
#TODO: Sort this out so it just finds the files rather than having to list them
##########

cd ~

# create dotfiles_old in homedir
echo -n "Creating $olddir for backup of any existing dotfiles in ~ ..."
mkdir -p $olddir
echo " done"

# move any existing dotfiles in homedir to dotfiles_old directory, then create symlinks from the homedir to any files in the ~/dotfiles directory specified in $files
for file in $files; do
    [ -L ~/.$file ] && rm ~/.$file  #Unlink files that already exist incase of script being run twice (new files, accedental re-runs etc)
    [ -f ~/.$file ] && mv ~/.$file ~/dotfiles_old/
    echo "Creating symlink to $file in home directory."
    ln -s $dir/$file ~/.$file
done


for folder in $folders; do
    [ -L ~/.$folder ] && rm ~/.$folder  #Unlink files that already exist incase of script being run twice (new files, accedental re-runs etc)
    [ -d ~/.$folder ] && mv ~/.$folder ~/dotfiles_old/
    echo "Creating symlink to $folder in home directory."
    ln -s $dir/$folder ~/.$folder
done

#dir_colors. NOTE: This section is specific to my configuration, I suggest you look at my dircolors-apoklinon repo for information
[ -f ~/.dir_colors ] && mv ~/.dir_colors ~/dotfiles_old
[ -f ~/.dir_colors.8bit ] && mv ~/.dir_colors.8bit ~/dotfiles_old
[ -f ~/.dir_colors.RGB ] && mv ~/.dir_colors.RGB ~/dotfiles_old
ln -s $dir/includes/dir_colors/dir_colors.8bit ~/.dir_colors.8bit
ln -s $dir/includes/dir_colors/dir_colors.RGB ~/.dir_colors.RGB

echo "Moved any existing dotfiles and folders from ~ to $olddir"

echo "Configuring any system specific files ..."
for file in $specfiles; do
  if [ -f $dir/includes/$host/$file ];
  then
      [ -L ~/.$file ] && rm ~/.$file  #Unlink files that already exist incase of script being run twice (new files, accedental re-runs etc)
      [ -f ~/.$file ] && mv ~/.$file ~/dotfiles_old/
      echo "Creating symlink to $file in home directory."
      ln -s $dir/includes/$host/$file ~/.$file
  fi
done

echo "Updating any submodules ..."
cd $dir
git submodule foreach git pull origin master
cd ..

echo "Setup complete."

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
