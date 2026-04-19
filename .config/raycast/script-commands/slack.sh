#!/bin/bash

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title Slack
# @raycast.mode silent

# Optional parameters:
# @raycast.icon ./slack.png

osascript <<'APPLESCRIPT'
tell application "Arc" to activate
delay 0.10

tell application "System Events"
  key code 102
  delay 0.02
  keystroke "3" using control down
  delay 0.05
  keystroke "5" using command down
end tell
APPLESCRIPT
