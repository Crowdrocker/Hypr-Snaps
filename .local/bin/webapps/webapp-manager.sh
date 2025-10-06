#!/bin/bash
# File: ~/.local/bin/webapps/webapp-manager.sh

WEBAPPS_DIR="$HOME/.local/bin/webapps"
ICONS_DIR="$HOME/.local/share/icons/webapps"

show_menu() {
    echo "╔═══════════════════════════════════════╗"
    echo "║   WehttamSnaps WebApp Manager         ║"
    echo "╚═══════════════════════════════════════╝"
    echo ""
    echo "1) Create new WebApp"
    echo "2) List all WebApps"
    echo "3) Edit WebApp"
    echo "4) Delete WebApp"
    echo "5) Launch WebApp"
    echo "6) Download WebApp icons"
    echo "0) Exit"
    echo ""
    read -p "Choose an option: " choice
}

create_webapp() {
    echo ""
    read -p "WebApp name (e.g., YouTube): " NAME
    read -p "URL: " URL
    read -p "Workspace (1-9): " WORKSPACE
    read -p "Browser (firefox/chromium): " BROWSER

    SCRIPT_NAME=$(echo "$NAME" | tr '[:upper:]' '[:lower:]' | tr ' ' '-')

    cat > "$WEBAPPS_DIR/${SCRIPT_NAME}.sh" << EOF
#!/bin/bash
# WebApp: $NAME
# URL: $URL

case $BROWSER in
    firefox)
        firefox --class "$NAME-WebApp" --new-window "$URL" &
        ;;
    chromium)
        mkdir -p "\$HOME/.config/webapps/$SCRIPT_NAME"
        chromium --app="$URL" \\
            --user-data-dir="\$HOME/.config/webapps/$SCRIPT_NAME" \\
            --class="$NAME-WebApp" &
        ;;
esac

sleep 2
niri msg set-window-rule "app_id:$NAME-WebApp" "workspace:$WORKSPACE"
notify-send "🌐 $NAME" "WebApp launched"
EOF

    chmod +x "$WEBAPPS_DIR/${SCRIPT_NAME}.sh"
    echo "✓ Created: $WEBAPPS_DIR/${SCRIPT_NAME}.sh"
    echo ""
    echo "Add keybind to Niri config:"
    echo "Mod+Key { spawn \"$WEBAPPS_DIR/${SCRIPT_NAME}.sh\"; }"
}

list_webapps() {
    echo ""
    echo "Available WebApps:"
    ls -1 "$WEBAPPS_DIR"/*.sh 2>/dev/null | xargs -n 1 basename
}

launch_webapp() {
    list_webapps
    echo ""
    read -p "Enter WebApp script name: " SCRIPT

    if [ -f "$WEBAPPS_DIR/$SCRIPT" ]; then
        "$WEBAPPS_DIR/$SCRIPT"
    else
        echo "WebApp not found!"
    fi
}

# Main loop
while true; do
    show_menu

    case $choice in
        1) create_webapp ;;
        2) list_webapps ;;
        3) ${EDITOR:-nano} "$WEBAPPS_DIR" ;;
        4) list_webapps; read -p "Delete which?: " DEL; rm "$WEBAPPS_DIR/$DEL" ;;
        5) launch_webapp ;;
        6) download-icons.sh ;;
        0) exit 0 ;;
        *) echo "Invalid option" ;;
    esac

    read -p "Press Enter to continue..."
done
