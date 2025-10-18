#!/bin/bash
# ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
# WehttamSnaps Hyprland Setup - Twitch Webapp
# GitHub: https://github.com/Crowdrocker
# ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

# Launch Twitch as a webapp
firefox --new-window --class="twitch-webapp" "https://www.twitch.tv/wehttamsnaps" &

# Alternative: Use Chromium-based browser
# chromium --app="https://www.twitch.tv/wehttamsnaps" --class="twitch-webapp" &