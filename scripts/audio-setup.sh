   #!/bin/bash
   # WehttamSnaps Audio Routes
   pw-cli create-node adapter "{ factory.name=support.null-audio-sink media.class=Audio/Sink sink.name=GameSink }"
   pw-cli create-node adapter "{ factory.name=support.null-audio-sink media.class=Audio/Sink sink.name=DiscordSink }"
   # Add more sinks...
   # Load qpwgraph graph: qpwgraph --load ~/audio-routes.wehttam
   # J.A.R.V.I.S. trigger example (below)
   paplay $SOUNDS_DIR/jarvis-notification.mp3  # Test sound
