#!/bin/bash
# Reset PulseAudio
pulseaudio -k
sleep 2
pulseaudio --start

# Create virtual sinks
pactl load-module module-null-sink sink_name=game_sink sink_properties=device.description="Game-Sink"
pactl load-module module-null-sink sink_name=music_sink sink_properties=device.description="Music-Sink" 
pactl load-module module-null-sink sink_name=chat_sink sink_properties=device.description="Chat-Sink"
pactl load-module module-combine-sink sink_name=stream_sink slaves=game_sink,music_sink,chat_sink

echo "Audio sinks created. Use qpwgraph to configure routing."
