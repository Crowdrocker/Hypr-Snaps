#!/bin/bash

# ╦ ╦┌─┐┬ ┬┌┬┐┌┬┐┌─┐┌┬┐╔═╗┌┐┌┌─┐┌─┐┌─┐
# ║║║├┤ ├─┤ │  │ ├─┤│││╚═╗│││├─┤├─┘└─┐
# ╚╩╝└─┘┴ ┴ ┴  ┴ ┴ ┴┴ ┴╚═╝┘└┘┴ ┴┴  └─┘
#
# Twitch WebApp Launcher
# GitHub: https://github.com/Crowdrocker/Hypr-Snaps

chromium --app=https://twitch.tv \
    --class=twitch-webapp \
    --name=Twitch \
    --user-data-dir="$HOME/.config/chromium-webapps/twitch" &