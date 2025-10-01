#!/bin/bash

# WehttamSnaps Audio Routing Setup (Voicemeeter Alternative)

echo "Setting up PipeWire audio routing..."

# Create virtual sinks for audio separation
pactl load-module module-null-sink sink_name=game_sink sink_properties=device.description="Game-Audio"
pactl load-module module-null-sink sink_name=music_sink sink_properties=device.description="Music-Audio" 
pactl load-module module-null-sink sink_name=voice_sink sink_properties=device.description="Voice-Audio"
pactl load-module module-null-sink sink_name=stream_sink sink_properties=device.description="Stream-Mix"

# Create virtual sources
pactl load-module module-null-sink sink_name=stream_mic sink_properties=device.description="Stream-Mic"

echo "Audio routing setup complete!"
echo "Use 'qpwgraph' to visually route your audio streams:"
echo "- Route game audio to game_sink"
echo "- Route music to music_sink" 
echo "- Route voice chat to voice_sink"
echo "- Combine all into stream_sink for OBS"
