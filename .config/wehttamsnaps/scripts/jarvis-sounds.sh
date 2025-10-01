JARVIS_SOUNDS="$HOME/.local/share/sounds/jarvis"

play_jarvis_sound() {
    local sound=$1
    paplay "$JARVIS_SOUNDS/$sound" &
}

case $1 in
    "startup") play_jarvis_sound "jarvis-startup.mp3" ;;
    "shutdown") play_jarvis_sound "jarvis-shutdown.mp3" ;;
    "notification") play_jarvis_sound "jarvis-notification.mp3" ;;
    "gaming") play_jarvis_sound "jarvis-gaming.mp3" ;;
    "streaming") play_jarvis_sound "jarvis-streaming.mp3" ;;
    "warning") play_jarvis_sound "jarvis-warning.mp3" ;;
esac
