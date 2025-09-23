#!/bin/bash
# WehttamSnaps Audio Routing Setup (Voicemeter Alternative)

setup_virtual_sinks() {
    echo "Creating virtual audio sinks..."
    
    # Create virtual sinks for different applications
    pactl load-module module-null-sink sink_name=games sink_properties=device.description="Games"
    pactl load-module module-null-sink sink_name=browser sink_properties=device.description="Browser"  
    pactl load-module module-null-sink sink_name=discord sink_properties=device.description="Discord"
    pactl load-module module-null-sink sink_name=spotify sink_properties=device.description="Spotify"
    pactl load-module module-null-sink sink_name=streaming sink_properties=device.description="Streaming_Mix"
    
    echo "Virtual sinks created. Use pavucontrol to route applications."
}

setup_qpwgraph_session() {
    echo "Setting up qpwgraph session..."
    # Launch qpwgraph in background for visual routing
    qpwgraph &
}

case "$1" in
    --setup-voicemeter-alternative)
        setup_virtual_sinks
        setup_qpwgraph_session
        ;;
    *)
        echo "Usage: $0 --setup-voicemeter-alternative"
        ;;
esac
