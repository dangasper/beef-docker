#!/bin/bash

# Set beef password
sed -i "/credentials:/{n;n;/passwd:/{s/beef/$BEEF_PASSWORD/}}" config.yaml

# Set beef user
sed -i "/credentials:/{n;/user:/{s/beef/$BEEF_USER/}}" config.yaml

# Change Hook settings
sed -i "/hook_file:/{s/hook.js/$BEEF_HOOK/}" config.yaml
sed -i "/hook_session_name:/{s/BEEFHOOK/$BEEF_HOOK_SESSION_NAME/}" config.yaml

# Turn on websockets
sed -i "/websocket:/{n;{/enable:/{s/false/true/}}}" config.yaml

# Change evasion to true
sed -i "/evasion:/{n;{/enable:/{s/false/true/}}}" config.yaml

# Update GeoIP
echo Y | /bin/bash /opt/beef/update-geoipdb

exec ruby beef -x

