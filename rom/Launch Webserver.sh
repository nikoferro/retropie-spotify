#!/bin/bash
# Clear Screen
printf "\033c"
if [ -f "/home/pi/RetroPie/roms/spotify/credentials.config" ]
then
    # Check if port 4000 is available
    status_code="`wget -O /dev/null 0.0.0.0:4000 2>&1 | grep -F HTTP | cut -d ' ' -f 6`"
    source /home/pi/RetroPie/roms/spotify/credentials.config
    if [ "$status_code" = "200" ]
    then
        printf "\033c"
        echo "There is already a process running on port 4000. Are you sure you are not already running spotify?"
        # Commenting this out for a keyboardless experience
        # while true; do
        #     read -p "Do you wish to kill this process [yes/no]?" yn
        #     case $yn in
        #         [Yy]* ) fuser -k -TERM -n tcp 4000 ; break;;
        #         [Nn]* ) exit;;
        #         * ) echo "Please answer yes or no.";;
        #     esac
        # done
        sleep 5
        printf "\033c"
        exit 1
    fi
    # Run spotify server
    echo 'Loading...'
    cd /home/pi/RetroPie/roms/spotify
    ./spotify-connect-web --username $username --password $password --bitrate 320 --playback_device sysdefault:CARD=ALSA --name RetroPie > /dev/null &
    tries=0
    until [ $tries -ge 5 ]
    do
        # Check if server is responding
        # Means that spotify server is up
        status_code="`wget -O /dev/null 0.0.0.0:4000 2>&1 | grep -F HTTP | cut -d ' ' -f 6`"
        if [ "$status_code" = "200" ]
        then
            printf "\033c"
            echo "Spotify server is now running in the background"
            sleep 5
            printf "\033c"
            exit 0
        fi
        tries=$[$tries+1]
        sleep 5
    done
    printf "\033c"
    # Time for user to read the message
    echo "Spotify server failed to start. Please make sure port 4000 is free and try again."
    sleep 5
    printf "\033c"
    exit 1
else
    printf "\033c"
	echo "There are no credentials set, please select Set Credentials option first"
    # Time for user to understand what went wrong
    sleep 5
    printf "\033c"
    exit 1
fi

