#!/bin/bash
# Clear Screen
printf "\033c"
read -p "Enter Username: " username
read -p "Enter Password: " password
echo 'username='$username > /home/pi/RetroPie/roms/spotify/credentials.config
echo 'password='$password >> /home/pi/RetroPie/roms/spotify/credentials.config
echo ''