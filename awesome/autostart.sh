#!/bin/bash

function run {
    if ! pgrep $1 ;
    then
        $@&
    fi
}

run picom -b --config  $HOME/.config/awesome/picom.conf
#setxkbmap -model "pc105" -layout "us,ru" -option "grp:caps_toggle,grp_led:scroll"
setxkbmap -model "pc105" -layout "us,ru" -option "grp:shift_caps_switch,grp_led:scroll"
#run volumeicon
#run usr/bin/emacs --daemon
#run mocp -S
#run mpd
#run /usr/bin/mocp -S
#run /usr/bin/mocp -G
#run yandex-disk start
run /usr/bin/feh --randomize --bg-fill ~/Изображения/wallpapers/*
#run clipmenud
#run ~/soft/Telegram/Telegram
