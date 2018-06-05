#!/bin/sh

sudo RM -R /Users/*/Library/Application\ Support/PaloAltoNetworks/GlobalProtect/*

launchctl unload /Library/LaunchAgents/com.paloaltonetworks.gp.pangps.plist

launchctl load /Library/LaunchAgents/com.paloaltonetworks.gp.pangps.plist

exit 0
