#!/bin/bash

AUR_LIST="$HOME/.local/share/com.ml4w.packagesinstaller/aur.lst"
FLATPAK_LIST="$HOME/.local/share/com.ml4w.packagesinstaller/flatpak.lst"
INSTALLER="$HOME/.local/share/com.ml4w.packagesinstaller/ml4w-installer" # Update if the installer binary/script name is different

# Check if inotifywait is installed
if ! command -v inotifywait &> /dev/null; then
    echo "inotifywait could not be found. Please install inotify-tools."
    exit 1
fi

echo "Watching for changes in AUR and Flatpak package lists..."

inotifywait -m -e close_write "$AUR_LIST" "$FLATPAK_LIST" |
while read -r directory events filename; do
    echo "Detected change in $filename. Running ML4W installer..."
    # You may need to adjust installer options depending on its CLI
    "$INSTALLER" --aur "$AUR_LIST" --flatpak "$FLATPAK_LIST"
done