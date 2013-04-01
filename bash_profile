#
# ~/.bash_profile
#

[[ -f ~/.bashrc ]] && . ~/.bashrc

eval $(keychain --eval --agents ssh,gpg -Q --quiet id_rsa)

export PATH="$HOME/.rbenv/bin:$PATH"
eval "$(rbenv init -)"
