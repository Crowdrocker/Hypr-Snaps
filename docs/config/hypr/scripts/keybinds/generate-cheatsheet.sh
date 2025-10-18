#!/bin/bash

# ╔══════════════════════════════════════════════════════════════════════╗
# ║                                                                      ║
# ║  __        __   _     _   _                    ____                  ║
# ║  \ \      / /__| |__ | |_| |_ __ _ _ __ ___   / ___| _ __   __ _    ║
# ║   \ \ /\ / / _ \ '_ \| __| __/ _` | '_ ` _ \  \___ \| '_ \ / _` |   ║
# ║    \ V  V /  __/ | | | |_| || (_| | | | | | |  ___) | | | | (_| |   ║
# ║     \_/\_/ \___|_| |_|\__|\__\__,_|_| |_| |_| |____/|_| |_|\__,_|   ║
# ║                                                                      ║
# ║  Auto-Generate Keybind Cheat Sheet                                   ║
# ║  GitHub: https://github.com/Crowdrocker                              ║
# ║                                                                      ║
# ╚══════════════════════════════════════════════════════════════════════╝

# Configuration
HYPR_CONFIG="$HOME/.config/hypr/modules/binds.conf"
OUTPUT_DIR="$HOME/.config/hypr-snaps/docs"
OUTPUT_FILE="$OUTPUT_DIR/KEYBINDS.md"
TEMP_FILE="/tmp/keybinds_temp.md"

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
PURPLE='\033[0;35m'
CYAN='\033[0;36m'
NC='\033[0m' # No Color

# ASCII Art Logo
LOGO="
 __        __   _     _   _                    ____
 \ \      / /__| |__ | |_| |_ __ _ _ __ ___   / ___| _ __   __ _ _ __  ___
  \ \ /\ / / _ \ '_ \| __| __/ _\` | '_ \` _ \  \___ \| '_ \ / _\` | '_ \/ __|
   \ V  V /  __/ | | | |_| || (_| | | | | | |  ___) | | | | (_| | |_) \__ \\
    \_/\_/ \___|_| |_|\__|\__\__,_|_| |_| |_| |____/|_| |_|\__,_| .__/|___/
                                                                  |_|
"

# Function to print colored output
print_status() {
    echo -e "${BLUE}[*]${NC} $1"
}

print_success() {
    echo -e "${GREEN}[✓]${NC} $1"
}

print_error() {
    echo -e "${RED}[✗]${NC} $1"
}

print_warning() {
    echo -e "${YELLOW}[!]${NC} $1"
}

# Function to parse keybind line
parse_keybind() {
    local line="$1"
    local bind_type modifier key action description

    # Extract bind type (bind, binde, bindm)
    bind_type=$(echo "$line" | grep -oP '^(bind|binde|bindm)')

    # Extract modifier and key
    if echo "$line" | grep -q "bind.*="; then
        modifier=$(echo "$line" | sed -n 's/.*= *\([^,]*\),.*/\1/p' | xargs)
        key=$(echo "$line" | sed -n 's/.*,[^,]*,\s*\([^,]*\),.*/\1/p' | xargs)
        action=$(echo "$line" | sed -n 's/.*,[^,]*,[^,]*,\s*\(.*\)/\1/p' | xargs)
    fi

    # Return parsed values
    echo "$bind_type|$modifier|$key|$action"
}

# Function to format modifier keys
format_modifier() {
    local mod="$1"
    # Replace spaces with +
    mod="${mod// / + }"
    # Capitalize first letter of each word
    mod=$(echo "$mod" | awk '{for(i=1;i<=NF;i++) $i=toupper(substr($i,1,1)) tolower(substr($i,2))}1')
    echo "$mod"
}

# Function to get description from comment
get_description() {
    local prev_line="$1"
    if echo "$prev_line" | grep -q "^#.*"; then
        echo "$prev_line" | sed 's/^# *//'
    else
        echo ""
    fi
}

# Function to detect category from section header
get_category() {
    local line="$1"
    if echo "$line" | grep -q "^# ═.*"; then
        # Get next line for category name
        return 1
    elif echo "$line" | grep -qP "^#.*(?:System|Core|Application)"; then
        echo "system"
    elif echo "$line" | grep -qP "^#.*(?:Noctalia|Shell)"; then
        echo "noctalia"
    elif echo "$line" | grep -qP "^#.*(?:WebApp|Web)"; then
        echo "webapps"
    elif echo "$line" | grep -qP "^#.*(?:Work|Photography)"; then
        echo "photography"
    elif echo "$line" | grep -qP "^#.*(?:Gaming|Entertainment)"; then
        echo "gaming"
    elif echo "$line" | grep -qP "^#.*(?:Stream|Record)"; then
        echo "streaming"
    elif echo "$line" | grep -qP "^#.*(?:Audio|Volume|Sound)"; then
        echo "audio"
    elif echo "$line" | grep -qP "^#.*(?:Brightness|Display)"; then
        echo "brightness"
    elif echo "$line" | grep -qP "^#.*(?:Window Management)"; then
        echo "window"
    elif echo "$line" | grep -qP "^#.*(?:Workspace)"; then
        echo "workspace"
    elif echo "$line" | grep -qP "^#.*(?:Utilit|System)"; then
        echo "utilities"
    elif echo "$line" | grep -qP "^#.*(?:JARVIS|J.A.R.V.I.S)"; then
        echo "jarvis"
    else
        echo "other"
    fi
}

# Function to create markdown header
create_header() {
    cat > "$TEMP_FILE" << 'EOF'
# WehttamSnaps Keybindings Reference

```
 __        __   _     _   _                    ____
 \ \      / /__| |__ | |_| |_ __ _ _ __ ___   / ___| _ __   __ _ _ __  ___
  \ \ /\ / / _ \ '_ \| __| __/ _` | '_ ` _ \  \___ \| '_ \ / _` | '_ \/ __|
   \ V  V /  __/ | | | |_| || (_| | | | | | |  ___) | | | | (_| | |_) \__ \
    \_/\_/ \___|_| |_|\__|\__\__,_|_| |_| |_| |____/|_| |_|\__,_| .__/|___/
                                                                  |_|
```

**GitHub:** [Crowdrocker](https://github.com/Crowdrocker)
**Auto-generated:** $(date '+%Y-%m-%d %H:%M:%S')

> ⚠️ This file is auto-generated from your Hyprland config.
> Do not edit manually! Changes will be overwritten.
> Edit: `~/.config/hypr/modules/binds.conf` instead.

---

## 📑 Table of Contents

- [System & Core Applications](#system--core-applications)
- [Noctalia Shell Controls](#noctalia-shell-controls)
- [WebApps](#webapps)
- [Work & Photography](#work--photography)
- [Gaming & Entertainment](#gaming--entertainment)
- [Streaming & Recording](#streaming--recording)
- [Audio Controls](#audio-controls)
- [Brightness Controls](#brightness-controls)
- [Window Management](#window-management)
- [Workspace Management](#workspace-management)
- [System Utilities](#system-utilities)
- [J.A.R.V.I.S. Integration](#jarvis-integration)

---

## ⌨️ Modifier Keys

- **SUPER** = Windows/Command key
- **SHIFT** = Shift key
- **CTRL** = Control key
- **ALT** = Alt key

---

EOF
}

# Function to parse binds and create sections
parse_and_create_sections() {
    local current_category=""
    local current_section=""
    local prev_line=""

    # Arrays to store keybinds by category
    declare -A category_binds

    while IFS= read -r line || [ -n "$line" ]; do
        # Skip empty lines and logo comments
        [[ -z "$line" || "$line" =~ ^#.*═ || "$line" =~ ^#.*║ ]] && { prev_line="$line"; continue; }

        # Detect section headers
        if echo "$line" | grep -qP "^# [A-Z].*"; then
            current_section=$(echo "$line" | sed 's/^# *//')
            prev_line="$line"
            continue
        fi

        # Parse keybind lines
        if echo "$line" | grep -qP "^(bind|binde|bindm)"; then
            # Extract components
            local modifier=$(echo "$line" | sed -n 's/.*= *\([^,]*\),.*/\1/p' | xargs)
            local key=$(echo "$line" | sed -n 's/.*,[^,]*,\s*\([^,]*\),.*/\1/p' | xargs)
            local action=$(echo "$line" | sed -n 's/.*,[^,]*,[^,]*,\s*\(.*\)/\1/p' | xargs)

            # Get description from inline comment or previous line
            local description=""
            if echo "$line" | grep -q "#"; then
                description=$(echo "$line" | sed -n 's/.*#\s*\(.*\)/\1/p')
            elif echo "$prev_line" | grep -q "^#"; then
                description=$(echo "$prev_line" | sed 's/^# *//')
            else
                # Generate description from action
                description=$(echo "$action" | sed 's/exec, //; s/exec //; s/,.*//; s/~\/\.config\/hypr\/scripts\///')
            fi

            # Format modifier for display
            local formatted_mod=$(format_modifier "$modifier")

            # Determine category
            local category="other"
            if [[ "$current_section" =~ [Ss]ystem|[Cc]ore|[Aa]pplication ]]; then
                category="system"
            elif [[ "$current_section" =~ [Nn]octalia|[Ss]hell ]]; then
                category="noctalia"
            elif [[ "$current_section" =~ [Ww]eb[Aa]pp ]]; then
                category="webapps"
            elif [[ "$current_section" =~ [Ww]ork|[Pp]hotography ]]; then
                category="photography"
            elif [[ "$current_section" =~ [Gg]aming|[Ee]ntertainment ]]; then
                category="gaming"
            elif [[ "$current_section" =~ [Ss]treaming|[Rr]ecording ]]; then
                category="streaming"
            elif [[ "$current_section" =~ [Aa]udio|[Vv]olume ]]; then
                category="audio"
            elif [[ "$current_section" =~ [Bb]rightness ]]; then
                category="brightness"
            elif [[ "$current_section" =~ [Ww]indow ]]; then
                category="window"
            elif [[ "$current_section" =~ [Ww]orkspace ]]; then
                category="workspace"
            elif [[ "$current_section" =~ [Uu]tilit ]]; then
                category="utilities"
            elif [[ "$current_section" =~ JARVIS|J\.A\.R\.V\.I\.S ]]; then
                category="jarvis"
            fi

            # Store keybind
            local keybind_entry="| \`$formatted_mod + $key\` | $description |"
            category_binds[$category]+="$keybind_entry"$'\n'
        fi

        prev_line="$line"
    done < "$HYPR_CONFIG"

    # Generate markdown sections
    generate_markdown_sections
}

# Function to generate markdown sections
generate_markdown_sections() {
    local categories=(
        "system:System & Core Applications"
        "noctalia:Noctalia Shell Controls"
        "webapps:WebApps"
        "photography:Work & Photography"
        "gaming:Gaming & Entertainment"
        "streaming:Streaming & Recording"
        "audio:Audio Controls"
        "brightness:Brightness Controls"
        "window:Window Management"
        "workspace:Workspace Management"
        "utilities:System Utilities"
        "jarvis:J.A.R.V.I.S. Integration"
    )

    for cat_entry in "${categories[@]}"; do
        local cat_key="${cat_entry%%:*}"
        local cat_title="${cat_entry#*:}"

        # Create section header
        echo "" >> "$TEMP_FILE"
        echo "## 🎯 $cat_title" >> "$TEMP_FILE"
        echo "" >> "$TEMP_FILE"
        echo "| Keybind | Action |" >> "$TEMP_FILE"
        echo "|---------|--------|" >> "$TEMP_FILE"

        # Add keybinds for this category (placeholder for now)
        echo "| \`SUPER + Key\` | Action description |" >> "$TEMP_FILE"
    done
}

# Function to add footer
add_footer() {
    cat >> "$TEMP_FILE" << 'EOF'

---

## 📚 Quick Reference

### Most Used Keybinds

```
┌─────────────────────────────────────────────────────┐
│                  ESSENTIAL BINDS                     │
├─────────────────────────────────────────────────────┤
│ SUPER + Return          Terminal                     │
│ SUPER + Space           App Launcher                 │
│ SUPER + Q               Close Window                 │
│ SUPER + L               Lock Screen                  │
│ SUPER + 1-9             Switch Workspace             │
├─────────────────────────────────────────────────────┤
│                  QUICK ACCESS                        │
├─────────────────────────────────────────────────────┤
│ SUPER + F               File Manager                 │
│ SUPER + B               Browser                      │
│ SUPER + G               Gaming Mode                  │
│ SUPER + S               Control Center               │
└─────────────────────────────────────────────────────┘
```

---

## 🔧 Regenerate This File

To regenerate this keybindings reference:

```bash
~/.config/hypr/scripts/keybinds/generate-cheatsheet.sh
```

Or reload Hyprland (it will auto-regenerate):

```bash
SUPER + Shift + R
```

---

**Made with ❤️ by Matthew (WehttamSnaps)**
*"It just works!"*

**GitHub:** [Crowdrocker](https://github.com/Crowdrocker) | **Twitch:** [WehttamSnaps](https://twitch.tv/WehttamSnaps)
EOF
}

# Function to create simple keybind list
create_simple_list() {
    print_status "Creating simple keybind list..."

    local in_section=0
    local current_section=""

    while IFS= read -r line || [ -n "$line" ]; do
        # Detect section headers
        if echo "$line" | grep -qP "^# ═{3,}"; then
            in_section=1
            continue
        fi

        if [[ $in_section -eq 1 ]]; then
            if echo "$line" | grep -qP "^# [A-Z]"; then
                current_section=$(echo "$line" | sed 's/^# *//')
                echo "" >> "$TEMP_FILE"
                echo "## $current_section" >> "$TEMP_FILE"
                echo "" >> "$TEMP_FILE"
                echo "| Keybind | Action |" >> "$TEMP_FILE"
                echo "|---------|--------|" >> "$TEMP_FILE"
                in_section=0
                continue
            fi
        fi

        # Parse bind lines
        if echo "$line" | grep -qP "^(bind|binde|bindm)"; then
            local modifier=$(echo "$line" | sed -n 's/.*= *\([^,]*\),.*/\1/p' | xargs)
            local key=$(echo "$line" | sed -n 's/.*,[^,]*,\s*\([^,]*\),.*/\1/p' | xargs)
            local action=$(echo "$line" | sed -n 's/.*,[^,]*,[^,]*,\s*\(.*\)/\1/p' | xargs)

            # Clean up action
            action=$(echo "$action" | sed 's/exec, //; s/exec //; s/,.*//; s/~\/\.config\/hypr\/scripts\///')
            action=$(echo "$action" | cut -c1-50)

            # Format modifier
            modifier=$(format_modifier "$modifier")

            # Write to file
            echo "| \`$modifier + $key\` | $action |" >> "$TEMP_FILE"
        fi
    done < "$HYPR_CONFIG"
}

# Main function
main() {
    echo -e "${PURPLE}$LOGO${NC}"
    echo -e "${CYAN}═══════════════════════════════════════════════════════════${NC}"
    echo -e "${CYAN}Auto-Generate Keybind Cheat Sheet${NC}"
    echo -e "${CYAN}═══════════════════════════════════════════════════════════${NC}"
    echo ""

    # Check if config file exists
    if [ ! -f "$HYPR_CONFIG" ]; then
        print_error "Hyprland keybind config not found: $HYPR_CONFIG"
        exit 1
    fi

    print_success "Found keybind config: $HYPR_CONFIG"

    # Create output directory if it doesn't exist
    if [ ! -d "$OUTPUT_DIR" ]; then
        print_status "Creating output directory: $OUTPUT_DIR"
        mkdir -p "$OUTPUT_DIR"
    fi

    # Backup existing file
    if [ -f "$OUTPUT_FILE" ]; then
        print_status "Backing up existing KEYBINDS.md..."
        cp "$OUTPUT_FILE" "${OUTPUT_FILE}.backup"
        print_success "Backup created: ${OUTPUT_FILE}.backup"
    fi

    # Create header
    print_status "Generating markdown header..."
    create_header

    # Parse and create sections
    print_status "Parsing keybindings..."
    create_simple_list

    # Add footer
    print_status "Adding footer..."
    add_footer

    # Move temp file to output
    mv "$TEMP_FILE" "$OUTPUT_FILE"

    print_success "Keybind cheat sheet generated: $OUTPUT_FILE"

    # Count keybinds
    local bind_count=$(grep -c "^bind" "$HYPR_CONFIG")
    print_status "Total keybindings found: $bind_count"

    echo ""
    echo -e "${GREEN}╔═══════════════════════════════════════════════════════════╗${NC}"
    echo -e "${GREEN}║              Generation Complete!                         ║${NC}"
    echo -e "${GREEN}╚═══════════════════════════════════════════════════════════╝${NC}"
    echo ""
    echo -e "View your keybindings: ${CYAN}cat $OUTPUT_FILE${NC}"
    echo -e "Edit keybindings:      ${CYAN}nvim $HYPR_CONFIG${NC}"
    echo ""
}

# Run main function
main "$@"
