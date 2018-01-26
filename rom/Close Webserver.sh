status_code="`wget -O /dev/null 0.0.0.0:4000 2>&1 | grep -F HTTP | cut -d ' ' -f 6`"
printf "\033c"
if [ "$status_code" = "200" ]
then 
    fuser -k -TERM -n tcp 4000
    printf "\033c"
    echo "Closing Spotify server"
    sleep 5
    printf "\033c"
    exit 0
else
    echo "Port 4000 is not reachable"
    exit 1
fi
