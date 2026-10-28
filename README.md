# Audio Clipper

A small browser app for trimming MP3s: load a file, scrub to a spot, cut it with the razor, delete the parts you don't want, and export a new MP3. Your original file is never changed.

Everything is in one file, `index.html`. There's nothing to install and no build step, and it works offline.

## Use it

1. Download `index.html` (or clone this repo).
2. Open it in a browser (Chromium, Firefox, etc.).
3. Drag an MP3 onto the page, or click **Open file**.

## Shortcuts

| Key | Action |
| --- | --- |
| Space | Play / pause |
| Left / Right | Skip 1 second (hold Shift for 5) |
| Home / End | Jump to start / end |
| Up / Down | Playback volume |
| + / - | Zoom in / out (or Ctrl + mouse wheel) |
| S | Razor: cut at the playhead |
| I / O | Mark the start / end of a section |
| Click a piece | Select the piece between two cuts |
| Enter | Go back to the start of the selection |
| L | Loop the selection while playing |
| Delete | Delete the selection |
| Esc | Clear the selection |
| Ctrl+Z / Ctrl+Y | Undo / redo |

**Return on stop** (on by default) sends the playhead back to where you pressed play.

## Export

**Export MP3** saves `<name>-edited.mp3` at 128, 192, or 320 kbps. A 5 ms fade is applied on each side of every deleted gap so joins don't click. **Normalize** raises the volume so the loudest point sits at -1 dB.

Limits: only the first two channels are kept, and tags (artist, cover art) aren't copied.

## How it works

- The MP3 is decoded with the Web Audio API. Edits never touch the audio: the app keeps a list of "play from here to here" pieces of the original, which makes undo instant.
- Export copies the kept pieces into new audio and encodes it in a background Web Worker, so the page stays responsive.

## Third-party code

`index.html` includes [lamejs](https://github.com/zhuker/lamejs) 1.2.1, an MP3 encoder licensed under the LGPL. See `third_party/lamejs-LICENSE`.
