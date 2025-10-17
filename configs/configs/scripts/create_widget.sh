#!/usr/bin/env bash
# create_widget.sh — scaffolds a new Quickshell/Noctalia widget
# Usage: ./create_widget.sh widget-name "Short description"
set -euo pipefail

WIDGETS_DIR="${1:-./configs/noctalia/widgets}"
NAME="${2:-}"
DESC="${3:-A custom widget}"

if [[ -z "$NAME" ]]; then
  echo "Usage: $0 <widget-slug> [widget-folder] [description]"
  echo "Example: $0 battery"
  exit 1
fi

TARGET_DIR="${WIDGETS_DIR}/${NAME}"
if [[ -d "$TARGET_DIR" ]]; then
  echo "Widget already exists: $TARGET_DIR"
  exit 1
fi

mkdir -p "$TARGET_DIR"

cat > "${TARGET_DIR}/manifest.json" <<EOF
{
  "name": "${NAME}",
  "display_name": "${NAME^}",
  "description": "${DESC}",
  "author": "WehttamSnaps",
  "version": "0.1.0",
  "entry": "widget.sh",
  "style": "style.css",
  "hotkeys": []
}
EOF

cat > "${TARGET_DIR}/widget.sh" <<'EOF'
#!/usr/bin/env bash
# Sample widget entrypoint
# Output should be simple text or JSON depending on Noctalia's requirements.
while true; do
  echo "$(date +'%H:%M')"
  sleep 1
done
EOF
chmod +x "${TARGET_DIR}/widget.sh"

cat > "${TARGET_DIR}/style.css" <<'EOF'
/* Sample widget CSS - customize colors to WehttamSnaps theme */
.widget {
  background: linear-gradient(90deg, #8A2BE2, #00FFFF);
  color: #ffffff;
  padding: 6px 10px;
  border-radius: 6px;
  font-family: "Paper Mono", monospace;
}
EOF

echo "Created widget scaffold at ${TARGET_DIR}"
