#!/bin/bash
plist="/Library/LaunchDaemons/com.domain.helper.launch.plist"
loggedInUser=$(/bin/ls -l /dev/console | /usr/bin/awk '{ print $3 }')
app="/Library/Application Support/Domain/Helper/TestDistributedNotification"

if [ -f "$app" ] && [ "$loggedInUser" != "_mbusersetup" ] && [ $(pgrep Finder | wc -l) -gt 0 ]; then

    "$app"
    rm "$plist"
    launchctl remove com.nestec.helper.launch
fi

exit 0
