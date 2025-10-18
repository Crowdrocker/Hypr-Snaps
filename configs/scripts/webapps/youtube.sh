#!/bin/bash
# ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
# WehttamSnaps Hyprland Setup - YouTube Webapp
# GitHub: https://github.com/Crowdrocker
# ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

# Launch YouTube as a webapp
firefox --new-window --class="youtube-webapp" "https://www.youtube.com" &

# Alternative: Use Chromium-based browser
# chromium --app="https://www.youtube.com" --class="youtube-webapp" &