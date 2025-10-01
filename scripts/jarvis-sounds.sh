#!/bin/bash

# J.A.R.V.I.S. Sound System for WehttamSnaps

JARVIS_SOUNDS_DIR="$HOME/.local/share/sounds/jarvis"

# Create sound directory
mkdir -p "$JARVIS_SOUNDS_DIR"

# Download J.A.R.V.I.S. sounds (you'll need to add your actual sound files)
echo "Setting up J.A.R.V.I.S. sound system..."

# Create sound triggers
cat > ~/.config/hypr/scripts/jarvis-startup.sh << 'EOF'
#!/bin/bash
paplay "$HOME/.local/share/sounds/jarvis/jarvis-startup.mp3" &
EOF

cat > ~/.config/hypr/scripts/jarvis-shutdown.sh << 'EOF'
#!/bin/bash
paplay "$HOME/.local/share/sounds/jarvis/jarvis-shutdown.mp3" &
EOF

cat > ~/.config/hypr/scripts/jarvis-gaming.sh << 'EOF'
#!/bin/bash
paplay "$HOME/.local/share/sounds/jarvis/jarvis-gaming.mp3" &
gamemoderun &
EOF
