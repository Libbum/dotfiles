#
#  Default initial .bashrc for the ac.  
#
#  Much of your environment should be setup in your .profile or
#  .bash_profile file.  The environment configured there will be
#  inherited by subshells, scripts, batch job etc.  This file 
#  (.bashrc) should only be used to define aliases, functions and, 
#  where necessary, terminal settings.  By default this file will 
#  be sourced for every bash shell and script so avoid unnecessary 
#  actions.  
#
#  See your .profile file for examples of how to add paths to 
#  software in your environment.
#  See http://nf.nci.org.au/facilities/software/modules.php
#  for instructions on how to set your environment to use specific
#  software packages.
#
#  $Id: default.bashrc,v 1.3 2008/12/18 00:08:09 dbs900 Exp $
#

#  Avoid going through here more than once in a shell


[[ $- != *i* ]] && return


#  Source global definitions to get the module command defined.
#  If you remove this from your file and/or you reset the BASH_ENV (or
#  ENV) variables,  you risk getting "module command not found"
#  errors from batch jobs.

if [ -f /etc/bashrc ]; then
    . /etc/bashrc
fi

if [ -n "$PS1" ]; then
##
##  Setup aliases etc for interactive session here
##
##  Any noisy output should go in here.  Output in non-interactive
##  sessions can cause failure. 
##
##  Put any tty settings in here

# echo I am an interactive session, so it is ok to be a bit noisy.
  true
fi

#nf_bashrc_sourced=YES

# COLOURS
#######################################################

#call locale to set colour fallback
source ~/.scripts/localeCheck

source ~/.scripts/apoklinonManage

#Some supercomputing clusters tend to use a dog old version of dir_colors - primarily to piss me off.
if [ $(echo "$(dircolors --version | head -n1 | awk '{ print $4 }') < 7.5" | bc) -eq 1 ]; then
    [ $apoklinonRGB -eq 1 ] && eval `dircolors -b <(sed -e '/RESET/d' -e '/MULTIHARDLINK/d' -e '/CAPABILITY/d' $HOME/.dir_colors.RGB)` || eval `dircolors -b <(sed -e '/RESET/d' -e '/MULTIHARDLINK/d' -e '/CAPABILITY/d' $HOME/.dir_colors.8bit)`
else
    [ $apoklinonRGB -eq 1 ] && eval `dircolors -b $HOME/.dir_colors.RGB` || eval `dircolors -b $HOME/.dir_colors.8bit`
fi

blueg=${blue#\\e[}
export GREP_OPTIONS='--color=auto' GREP_COLOR=${blueg%m}

#-------------------------------------------------------------
# The 'ls' family (this assumes you use a recent GNU ls)
#-------------------------------------------------------------
#alias ll="ls -l --group-directories-first"
alias ls='ls -hF --color'  # add colors for filetype recognition
alias la='ls -Al'          # show hidden files
alias lx='ls -lXB'         # sort by extension
alias lk='ls -lSr'         # sort by size, biggest last
alias lc='ls -ltcr'        # sort by and show change time, most recent last
alias lu='ls -ltur'        # sort by and show access time, most recent last
alias lt='ls -ltr'         # sort by date, most recent last
alias lm='ls -al |more'    # pipe through 'more'
alias lr='ls -lR'          # recursive ls
alias tree='tree -Csu'     # nice alternative to 'recursive ls'

# If your version of 'ls' doesn't support --group-directories-first try this:
function ll(){ ls -l "$@"| egrep "^d" ; ls -lXB "$@" 2>&-| \
                egrep -v "^d|total "; }

alias dud='du -sh' #requires directory
alias vi='vim'

# NOTES
#######################################################

# To temporarily bypass an alias, we preceed the command with a \  
# EG:  the ls command is aliased, but to use the normal ls command you would 
# type \ls 


function ii() {
    echo -e "\nYou are logged on ${jazzberry}$HOST"
    echo -e "\nAdditionnal information:$reset " ; uname -a
    echo -e "\n${jazzberry}Users logged on:$reset " ; w -h
    echo -e "\n${jazzberry}Current date :$reset " ; date
    echo -e "\n${jazzberry}Machine stats :$reset " ; uptime
    echo -e "\n${jazzberry}Memory stats :$reset " ; free
    echo
}

# Various variables
host=${HOSTNAME%%[.0-9]*}
Host=${host[@]^}
Time12h="\T"
Time12a="\@"
PathShort="\w"
PathFull="\W"
NewLine="\n"
Jobs="\j"

export PS1=$davgrayp$Host$resetp'$(git branch &>/dev/null;\
if [ $? -eq 0 ]; then \
    echo "$(echo `git status` | grep "nothing to commit" > /dev/null 2>&1; \
    if [ "$?" -eq "0" ]; then \
        # @4 - Clean repository - nothing to commit
        echo "'$bluep'"$(__git_ps1 " (%s)"); \
    else \
       # @5 - Changes to working tree
       echo "'$brickp'"$(__git_ps1 " {%s}"); \
    fi) '$sandyp$PathShort$resetp'\$ "; \
else \
   # @2 - Prompt when not in GIT repo
   echo " '$aquap$PathShort$resetp'\$ "; \
fi)'


# Host specific proflie additions
[ -f ~/.dotfiles/includes/"$host"/bashrc ] && source ~/.dotfiles/includes/"$host"/bashrc

