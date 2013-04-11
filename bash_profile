#
# ~/.bash_profile
#

[[ -f ~/.bashrc ]] && . ~/.bashrc

hosttmp=$(hostname -s)
host=${hosttmp%[0-9]} #cluster with multiple login nodes fix

# Host specific proflie additions
[ -f ~/.dotfiles/includes/"$host"/bash_profile ] && source ~/.dotfiles/includes/"$host"/bash_profile

