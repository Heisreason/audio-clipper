#!/usr/bin/env bash
# Installs Audio Clipper as a local app with an app menu entry.
#
# What it changes (all inside your home folder, nothing system-wide):
#   ~/.local/share/audio-clipper/                 app files (index.html, icon.svg)
#   ~/.local/share/applications/audio-clipper.desktop   the app menu entry
# Running it again updates both. Run ./uninstall.sh to remove them.
set -euo pipefail

SRC="$(cd "$(dirname "$0")" && pwd)"
DATA="${XDG_DATA_HOME:-$HOME/.local/share}"
APP_DIR="$DATA/audio-clipper"
DESKTOP="$DATA/applications/audio-clipper.desktop"

# Pick a Chromium-based browser. Its "app mode" opens the page in a plain
# window with no tabs or address bar, so it feels like a normal app.
BROWSER=""
for b in chromium chromium-browser google-chrome-stable google-chrome brave brave-browser vivaldi-stable microsoft-edge-stable; do
  if command -v "$b" >/dev/null 2>&1; then BROWSER="$b"; break; fi
done

mkdir -p "$APP_DIR" "$DATA/applications"
cp "$SRC/index.html" "$SRC/icon.svg" "$APP_DIR/"

if [ -n "$BROWSER" ]; then
  EXEC="$BROWSER --app=file://$APP_DIR/index.html"
else
  echo "No Chromium-based browser found, so the launcher will open your default browser instead."
  EXEC="xdg-open $APP_DIR/index.html"
fi

cat > "$DESKTOP" <<EOF
[Desktop Entry]
Type=Application
Name=Audio Clipper
Comment=Trim and cut MP3 files
Exec=$EXEC
Icon=$APP_DIR/icon.svg
Terminal=false
Categories=AudioVideo;Audio;AudioVideoEditing;
Keywords=mp3;audio;trim;cut;editor;
EOF

# Refresh the menu cache if the tool exists (most launchers pick it up anyway).
command -v update-desktop-database >/dev/null 2>&1 && update-desktop-database "$DATA/applications" >/dev/null 2>&1 || true

echo "Installed Audio Clipper."
echo "  App files:  $APP_DIR"
echo "  Menu entry: $DESKTOP"
echo "  Opens with: $EXEC"
