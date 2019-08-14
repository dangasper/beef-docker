#!/bin/bash

if [ -z "$BEEF_PROXY_IP" ]
then
	BEEF_PROXY_IP=`curl ifconfig.me`
else
	echo "Public listening IP is: $BEEF_PROXY_IP"
fi

# Set beef password
echo "Beef password set as: $BEEF_PASSWORD"
sed -i "/credentials:/{n;n;/passwd:/{s/beef/$BEEF_PASSWORD/}}" config.yaml

# Set beef user
echo "Beef user set as: $BEEF_USER"
sed -i "/credentials:/{n;/user:/{s/beef/$BEEF_USER/}}" config.yaml

# Change Hook settings
echo "Hook file name: $BEEF_HOOK"
echo "Session cookie: $BEEF_HOOK_SESSION_NAME"
sed -i "/hook_file:/{s/hook.js/$BEEF_HOOK/}" config.yaml
sed -i "/hook_session_name:/{s/BEEFHOOK/$BEEF_HOOK_SESSION_NAME/}" config.yaml

# Change public IP for listening
sed -i "/http:/,/database:/{0,/#public:/{s/#public/public/}};{0,/public:/{s/\"\"/\"$BEEF_PROXY_IP\"/}}" config.yaml

# Turn on websockets
sed -i "/websocket:/{n;{/enable:/{s/false/true/}}}" config.yaml

# Change evasion to true
sed -i "/evasion:/{n;{/enable:/{s/false/true/}}}" config.yaml

# Update GeoIP
echo Y | /bin/bash /opt/beef/update-geoipdb

exec ruby beef -x

