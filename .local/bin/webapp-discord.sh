#!/bin/bash

# ╦ ╦┌─┐┬ ┬┌┬┐┌┬┐┌─┐┌┬┐╔═╗┌┐┌┌─┐┌─┐┌─┐
# ║║║├┤ ├─┤ │  │ ├─┤│││╚═╗│││├─┤├─┘└─┐
# ╚╩╝└─┘┴ ┴ ┴  ┴ ┴ ┴┴ ┴╚═╝┘└┘┴ ┴┴  └─┘
#
# Discord WebApp Launcher
# GitHub: https://github.com/Crowdrocker/Hypr-Snaps

chromium --app=https://discord.com/app \
    --class=discord-webapp \
    --name=Discord \
    --user-data-dir="$HOME/.config/chromium-webapps/discord" &