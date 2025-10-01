  #!/bin/bash
  ~/.scripts/jarvis-sounds.sh streaming
  qpwgraph --load ~/audio-routes.wehttam  # Routes
  obs --startstreaming --minimize-to-tray  # Auto-start
  notify-send "Streaming Online - Twitch: WehttamSnaps"
