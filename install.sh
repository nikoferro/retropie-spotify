#!/bin/sh
# CLEAR SCREEN
printf "\033c"
# MAKE FOLDER READABLE
chmod -R +r './'
# CHECK FOR SPOTIFY KEY
if [ ! -f './key/spotify_appkey.key' ]
then
	echo 'There is no spotify_appkey.key file inside the ./key folder.'
	echo 'The Spotify developer key can be obtained from https://developer.spotify.com/my-account/keys'
	exit 1
else
	echo 'Spotify developer key found!'
fi
# MAKE A COPY OF THE DEFAULT ES_SYSTEMS FILE IF A COPY DOESNT EXIST
# THIS IS FOR SAFER CUSTOMIZATION
if [ -f '/opt/retropie/configs/all/emulationstation/es_systems.cfg' ]
then
	echo 'A custom es_systems.cfg found.'
else
	echo 'Creating custom es_systems.cfg'
	cp /etc/emulationstation/es_systems.cfg /opt/retropie/configs/all/emulationstation/es_systems.cfg
fi

# ONCE THE COPY IS MADE, CREATE THE SPOTIFY SYSTEM IN THE CUSTOM FILE
if grep -q '<name>spotify</name>' '/opt/retropie/configs/all/emulationstation/es_systems.cfg'
then
	echo 'Spotify is already setup in your es_systems.cfg file'
else
	echo 'Adding spotify system list'
	xmlstarlet ed --omit-decl --inplace \
		-s '//systemList' -t elem -n 'system' \
		-s '//systemList/system[last()]' -t elem -n 'name' -v 'spotify'\
		-s '//systemList/system[last()]' -t elem -n 'fullname' -v 'Spotify'\
		-s '//systemList/system[last()]' -t elem -n 'path' -v '/home/pi/RetroPie/roms/spotify'\
		-s '//systemList/system[last()]' -t elem -n 'extension' -v '.sh'\
		-s '//systemList/system[last()]' -t elem -n 'command' -v 'sudo %ROM%'\
		-s '//systemList/system[last()]' -t elem -n 'theme' -v 'spotify'\
		/opt/retropie/configs/all/emulationstation/es_systems.cfg
fi

# COPY CARBON THEME
if [ ! -d '/opt/retropie/configs/all/emulationstation/themes' ]
then
	mkdir -p /opt/retropie/configs/all/emulationstation/themes
fi

if [ -d '/opt/retropie/configs/all/emulationstation/themes/carbon' ]
then
	echo 'There is already a custom carbon copy - skipping this step'
else
	echo 'Copying the carbon theme for customization'
	cp -R '/etc/emulationstation/themes/carbon' '/opt/retropie/configs/all/emulationstation/themes/carbon'
fi

# INSTALL SPOTIFY THEME (THIS IS NEEDED TO SHOW THE LOGO)
if [ -d '/opt/retropie/configs/all/emulationstation/themes/carbon/spotify' ]
then
	echo 'Spotify theme folder is already setup'
else
	echo 'Adding spotify theme'
	cp -R './themes/carbon/spotify' '/opt/retropie/configs/all/emulationstation/themes/carbon/spotify'
fi

# INSTALL SPOTIFY ROM
if [ -d '/home/pi/RetroPie/roms/spotify' ]
then
	echo 'Spotify rom folder is already setup'
else
	echo 'Installing Spotify Rom'
	# DOWNLOAD SPOTIFY WEB CONNECT
	if [ -d './temp' ]
	then
		rm -rf temp
	fi
	mkdir temp
	wget -q --show-progress https://github.com/Fornoth/spotify-connect-web/releases/download/0.0.3-alpha/spotify-connect-web_0.0.3-alpha.tar.gz -P ./temp
	mkdir -p ./temp/spotify-connect-web
	tar zxf ./temp/spotify-connect-web_0.0.3-alpha.tar.gz -C ./temp
	rm -rf ./temp/spotify-connect-web/static
	rm -rf ./temp/spotify-connect-web/templates
	rm -rf ./temp/spotify-connect-web/console_callbacks.py
	cp -R './rom/.' '/home/pi/RetroPie/roms/spotify'
	cp -R './key/.' '/home/pi/RetroPie/roms/spotify'
	cp -R './temp/spotify-connect-web/.' '/home/pi/RetroPie/roms/spotify'
	# ENABLE FILE EXECUTION
	chmod -R +x '/home/pi/RetroPie/roms/spotify'
	rm -rf temp
	# install deps
	sudo apt-get clean
	sudo apt-get update
	sudo apt-get install xinit Xorg midori unclutter matchbox-window-manager -y --fix-missing
fi

