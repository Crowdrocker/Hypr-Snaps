#!/bin/bash

# ╦ ╦┌─┐┬ ┬┌┬┐┌┬┐┌─┐┌┬┐╔═╗┌┐┌┌─┐┌─┐┌─┐
# ║║║├┤ ├─┤ │  │ ├─┤│││╚═╗│││├─┤├─┘└─┐
# ╚╩╝└─┘┴ ┴ ┴  ┴ ┴ ┴┴ ┴╚═╝┘└┘┴ ┴┴  └─┘
#
# ChatGPT WebApp Launcher
# GitHub: https://github.com/Crowdrocker/Hypr-Snaps

chromium --app=https://chat.openai.com \
    --class=chatgpt-webapp \
    --name=ChatGPT \
    --user-data-dir="$HOME/.config/chromium-webapps/chatgpt" &