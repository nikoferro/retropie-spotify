#!/bin/bash
echo "Checking if Spotify server is running..."
tries=0
until [ $tries -ge 5 ]
do
    # Check if server is responding
    # Means that spotify server is up
    status_code="`wget -O /dev/null 0.0.0.0:4000 2>&1 | grep -F HTTP | cut -d ' ' -f 6`"
    if [ "$status_code" = "200" ]
    then
        chmod +x /home/pi/RetroPie/roms/spotify/.bash/exit.sh
        chmod +x /home/pi/RetroPie/roms/spotify/.bash/fullscreen.sh
        xinit /home/pi/RetroPie/roms/spotify/.bash/fullscreen.sh  >/dev/null 2>&1
        break
    fi
    tries=$[$tries+1]
    sleep 5
done
status_code="`wget -O /dev/null 0.0.0.0:4000 2>&1 | grep -F HTTP | cut -d ' ' -f 6`"
printf "\033c"
if [ "$status_code" != "200" ]
then
    echo "Spotify server is not running, please select the Launch Webserver option first"
    sleep 5
fi
printf "\033c"
exit 0