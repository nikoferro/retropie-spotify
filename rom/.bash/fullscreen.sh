#!/bin/sh
xset -dpms
xset s off
xset s noblank
unclutter &
matchbox-window-manager -use_cursor no -use_titlebar no  &

/usr/bin/midori -e Fullscreen -a "http://localhost:4000"