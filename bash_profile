#
# ~/.bash_profile
#

[[ -f ~/.bashrc ]] && . ~/.bashrc

host=${HOSTNAME%%[.0-9]*} #see bashrc for the reasons for this.

# Host specific proflie additions
[ -f ~/.dotfiles/includes/"$host"/bash_profile ] && source ~/.dotfiles/includes/"$host"/bash_profile

