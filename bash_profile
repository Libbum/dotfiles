#
# ~/.bash_profile
#

[[ -f ~/.bashrc ]] && . ~/.bashrc

host=$(hostname -s)

# Host specific proflie additions
[ -f ~/.dotfiles/includes/"$host"/bash_profile ] && source ~/.dotfiles/includes/"$host"/bash_profile

