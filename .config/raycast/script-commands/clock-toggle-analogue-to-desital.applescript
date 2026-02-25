#!/usr/bin/osascript

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title Clock Toggle analogue to desital
# @raycast.mode compact

# Optional parameters:
# @raycast.icon 🕰

# Documentation:
# @raycast.description try     set currentValue to (do shell script "defaults read com.apple.menuextra.clock 'IsAnalog'") as integer as boolean on error     set currentValue to false end try do shell script "defaults write com.apple.menuextra.clock 'IsAnalog' -bool " & (not currentValue) 
# @raycast.author ume

try
	set currentValue to (do shell script "defaults read com.apple.menuextra.clock 'IsAnalog'") as integer as boolean
on error
	set currentValue to false
end try
do shell script "defaults write com.apple.menuextra.clock 'IsAnalog' -bool " & (not currentValue)
