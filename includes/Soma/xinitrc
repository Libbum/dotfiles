[[ -f ~/.Xdefaults ]] && xrdb -merge ~/.Xdefaults

systemd --user & #run systemd as user instance
/home/genesis/.scripts/wpchanger #Starts nitrogen, in a manner that allows a cron job to change the wallpaper randomly

#seq 0 2 | xargs -l1 -I@ compton -b -d :0.@v

#DISPLAY=:0.0 setsid dwm &
#DISPLAY=:0.1 setsid dwm &
#DISPLAY=:0.2 setsid dwm &
#exec awesome
#exec dwm

case $1 in
dwm)
        xmodmap -e "keycode 108 = Super_L"  # reassign Alt_R to Super_L
        xmodmap -e "remove mod1 = Super_L"  # make sure X keeps it out of the mod1 group
        
        ~/.scripts/startdwm
        ;;
xmonad|*)
        xsetroot -cursor_name left_ptr
        setxkbmap -layout dvorak
        xmodmap -e "keycode 108 = Super_L"  # reassign Alt_R to Super_L
        xmodmap -e "remove mod1 = Super_L"  # make sure X keeps it out of the mod1 group
        exec xmonad
        ;;
esac

