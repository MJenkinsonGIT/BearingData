# BearingData

A Garmin Connect IQ data field for the Venu 3 that displays your current compass heading in degrees, with a direction label (N, NE, E, etc.) shown below.

---

## About This Project

This app was built through **vibecoding** — a development approach where the human provides direction, intent, and testing, and an AI writes all of the code. I have no formal programming background; this is an experiment in what's possible when curiosity and AI assistance meet.

The core app was written by **Claude (Anthropic)**. The direction label feature was added by **ticlazau/Qwen2.5-Coder-7B-Instruct** — a fine-tune of Alibaba Cloud's Qwen2.5-Coder-7B-Instruct, run locally via Ollama/Cline — as part of an experiment in generating training data for fine-tuning smaller local models for Garmin Connect IQ development. My role throughout was to describe what I wanted, test each iteration on a real Garmin Venu 3, report back what worked and what didn't, and keep pushing until the result was something I was happy with.

As part of this process, I've been building a knowledge base — a growing collection of Markdown documents that capture the real-world lessons Claude and I have uncovered together: non-obvious API behaviours, compiler quirks, layout constraints specific to the Venu 3's circular display, and fixes for bugs that aren't covered anywhere in the official SDK documentation. These files are fed back into Claude at the start of each new session so the knowledge carries forward rather than being rediscovered from scratch every time.

The knowledge base is open source. If you're building Connect IQ apps for the Venu 3 and want to skip some of the trial and error, you're welcome to use it:

**[Venu 3 Claude Coding Knowledge Base](https://github.com/MJenkinsonGIT/Venu3ClaudeCodingKnowledge)**

---

## What It Shows

The field displays two pieces of information:

- **Heading in degrees** — your true-north referenced compass heading, updated continuously during an activity
- **Cardinal direction** — the corresponding direction label (North, North-East, East, South-East, South, South-West, West, North-West)

The heading is sourced from `Activity.Info.currentHeading`, which reads the device's compass during an activity. If the compass is unavailable, the field shows `--`.

---

## Installation

### Which file should I download?

Each release includes three files. All three contain the same app — the difference is how they were compiled:

| File | Size | Best for |
|------|------|----------|
| `BearingData-release.prg` | Smallest | Most users — just install and run |
| `BearingData-debug.prg` | ~4× larger | Troubleshooting crashes — includes debug symbols |
| `BearingData.iq` | Small (7-zip archive) | Developers / advanced users |

**Release `.prg`** is a fully optimised build with debug symbols and logging stripped out. This is what you want if you just want to use the app.

**Debug `.prg` + `.prg.debug.xml`** — these two files must be kept together. The `.prg` is the app binary; the `.prg.debug.xml` is the symbol map that translates raw crash addresses into source file names and line numbers. If the app crashes, the watch writes a log to `GARMIN\APPS\LOGS\CIQ_LOG.YAML` — cross-referencing that log against the `.prg.debug.xml` tells you exactly which line of code caused the crash. Without the `.prg.debug.xml`, the crash addresses in the log are unreadable hex. The app behaves identically to the release build; there is no difference in features or behaviour.

**`.iq` file** is a 7-zip archive containing the release `.prg` plus metadata (manifest, settings schema, signature). It is the format used for Connect IQ Store submissions. You can extract the `.prg` from it by renaming it to `.7z` and extracting — Windows 11 (22H2 and later) supports 7-zip natively via File Explorer's right-click menu. On older Windows versions you will need [7-Zip](https://www.7-zip.org/) (free).

---

**Option A — direct `.prg` download (simplest)**
1. Download the `.prg` file from the [Releases](#) section
2. Connect your Venu 3 via USB
3. Copy the `.prg` to `GARMIN\APPS\` on the watch
4. Press the **Back button** on the watch — it will show "Verifying Apps"
5. Unplug once the watch finishes

**Option B — extracting from the `.iq` file**

1. Install 7-Zip if you don't have it
2. Right-click the `.iq` file → **7-Zip → Extract Here**
3. Inside the extracted folder, find the `.prg` file inside the device ID subfolder
4. Copy the `.prg` to `GARMIN\APPS\` on the watch
5. Press the **Back button** on the watch — it will show "Verifying Apps"
6. Unplug once the watch finishes

To add the field to an activity data screen: start an activity, long-press the lower button, navigate to **Data Screens**, and add the field to a slot.

> **To uninstall:** Use Garmin Express. Sideloaded apps cannot be removed directly from the watch or the Garmin Connect phone app.

---

## Device Compatibility

Built and tested on: **Garmin Venu 3**
SDK Version: **8.4.1 / API Level 5.2**

Compatibility with other devices has not been tested.

---

## Notes

- The compass heading requires an active activity — the field will show `--` outside of an activity or if the compass is unavailable.
- Heading is true-north referenced, not magnetic north.
- The direction label uses 8 cardinal/intercardinal points (N, NE, E, SE, S, SW, W, NW) with boundaries at every 45°.
