### 2021 Update: Archiving this, since Spotify api has changed a lot since this was published, and it no longer works with a .key file

If anyone wants to keep maintaining this project and upgrade it to use the current Spotify api please reach out and i will unarchive it, but for now, i will keep it closed

----


# Spotify as a "console" for Retropie

This is basically an easy way to install https://github.com/Fornoth/spotify-connect-web on your Retropie and make it available as a console on the main menu.

<img src="https://user-images.githubusercontent.com/8658960/35447446-85ddce6e-0296-11e8-9c74-3ed590ceb6aa.jpg" width="200" height="200"><img src="https://user-images.githubusercontent.com/8658960/35445914-f44aa9bc-0291-11e8-960a-ba479c33cd50.jpg" width="200" height="200">

### What it does

* Stream Spotify to your Retropie while gaming / on the menu / on fullscreen mode with the cover art of what you are listening

### Limitations

* Right now only works on with the carbon theme. So its recommended to be setup on a Retropie clean install
* You will need `spotify_appkey.key` (can be obtained from https://developer.spotify.com/my-account/keys )

## Install

- `ssh` into your Retropie and `git clone https://github.com/nikoferro/retropie-spotify.git`. Instructions on how to connect through ssh explained here https://github.com/RetroPie/RetroPie-Setup/wiki/SSH).
- Put your `spotify_appkey.key` into the `key` folder (located inside of what you just downloaded). If the `spotify_appkey.key` file is not present inside the `key` folder, the installer will exit since the developer key is necessary for spotify connect to work.
- Inside the downloaded folder `sh install.sh`.

After the installation is finished, just reboot your Retropie and everything should be ready.

## Usage

You need to set your Spotify credentials first. There is an option called `Set Credentials` inside the Spotify menu that should now appear on emustation (needless to say, you will need a keyboard for this step)

After setting credentials you can Launch your webserver. If the web server is running, you are going to be able to stream music into your Retropie.

To go into Fullscreen Mode, the webserver needs to be running first.
To leave Fullscreen Mode, just stop streaming into Retropie
