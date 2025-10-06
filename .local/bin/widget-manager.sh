#!/bin/bash
# File: ~/.local/bin/widget-manager.sh
# WehttamSnaps Widget Manager

WIDGET_DIR="$HOME/.config/quickshell/widgets"
TEMPLATE_DIR="$WIDGET_DIR/templates"

# Colors
PURPLE='\033[0;35m'
CYAN='\033[0;36m'
GREEN='\033[0;32m'
NC='\033[0m'

show_menu() {
    echo -e "${PURPLE}╔═══════════════════════════════════════╗${NC}"
    echo -e "${PURPLE}║   WehttamSnaps Widget Manager        ║${NC}"
    echo -e "${PURPLE}╚═══════════════════════════════════════╝${NC}"
    echo ""
    echo "1) Create new widget from template"
    echo "2) List all widgets"
    echo "3) Edit widget"
    echo "4) Delete widget"
    echo "5) Reload Quickshell"
    echo "0) Exit"
    echo ""
    read -p "Choose an option: " choice
}

create_widget() {
    echo -e "\n${CYAN}Available templates:${NC}"
    echo "1) Button Widget"
    echo "2) Info Panel"
    echo "3) Launcher Grid"
    echo "4) System Monitor"
    echo "5) Custom (blank)"

    read -p "Select template: " template
    read -p "Widget name: " widget_name

    case $template in
        1) cp "$TEMPLATE_DIR/button-widget.qml" "$WIDGET_DIR/${widget_name}.qml" ;;
        2) cp "$TEMPLATE_DIR/info-panel.qml" "$WIDGET_DIR/${widget_name}.qml" ;;
        3) cp "$TEMPLATE_DIR/launcher-grid.qml" "$WIDGET_DIR/${widget_name}.qml" ;;
        4) cp "$TEMPLATE_DIR/system-monitor.qml" "$WIDGET_DIR/${widget_name}.qml" ;;
        5)
            cat > "$WIDGET_DIR/${widget_name}.qml" << 'EOF'
import QtQuick
import Quickshell

PanelWindow {
    id: customWidget

    width: 300
    height: 200

    Rectangle {
        anchors.fill: parent
        color: "#1a1b26"
        border.color: "#8A2BE2"
        border.width: 2
        radius: 10

        Text {
            text: "Custom Widget"
            color: "#00FFFF"
            font.pixelSize: 20
            anchors.centerIn: parent
        }
    }
}
EOF
            ;;
    esac

    echo -e "${GREEN}Widget created: $WIDGET_DIR/${widget_name}.qml${NC}"
    echo "Add to shell.qml: import \"./widgets/${widget_name}.qml\""
}

list_widgets() {
    echo -e "\n${CYAN}Available widgets:${NC}"
    ls -1 "$WIDGET_DIR"/*.qml 2>/dev/null | xargs -n 1 basename
}

edit_widget() {
    list_widgets
    read -p "Widget name to edit: " widget_name

    if [ -f "$WIDGET_DIR/${widget_name}.qml" ]; then
        ${EDITOR:-nano} "$WIDGET_DIR/${widget_name}.qml"
    else
        echo "Widget not found!"
    fi
}

delete_widget() {
    list_widgets
    read -p "Widget name to delete: " widget_name
    read -p "Are you sure? (y/n): " confirm

    if [ "$confirm" = "y" ] && [ -f "$WIDGET_DIR/${widget_name}.qml" ]; then
        rm "$WIDGET_DIR/${widget_name}.qml"
        echo -e "${GREEN}Widget deleted${NC}"
    fi
}

reload_quickshell() {
    echo "Reloading Quickshell..."
    killall quickshell
    quickshell &
    echo -e "${GREEN}Quickshell reloaded${NC}"
}

# Main loop
while true; do
    show_menu

    case $choice in
        1) create_widget ;;
        2) list_widgets ;;
        3) edit_widget ;;
        4) delete_widget ;;
        5) reload_quickshell ;;
        0) exit 0 ;;
        *) echo "Invalid option" ;;
    esac

    echo ""
    read -p "Press Enter to continue..."
done
