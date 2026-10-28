#!/usr/bin/env bash
# Removes what install.sh added. Your audio files and exports are not touched.
set -euo pipefail
DATA="${XDG_DATA_HOME:-$HOME/.local/share}"
rm -rf "$DATA/audio-clipper"
rm -f "$DATA/applications/audio-clipper.desktop"
command -v update-desktop-database >/dev/null 2>&1 && update-desktop-database "$DATA/applications" >/dev/null 2>&1 || true
echo "Removed Audio Clipper."
