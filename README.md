# Ping Status

A minimalist ICMP-based network connectivity monitor for Rainmeter.

## Canonical naming

- Display / project name: `Ping Status`
- GitHub repository: `Agent-pEx/Ping-Status`
- Local folder under the collector: `Ping_Status/`
- Default working branch: `dev`
- Release / stable branch: `main`
- Rainmeter config name: `Ping Status`
- Main `.ini` file: `PingStatus.ini`
- Author (installer / metadata): `Fenyvesi István from Kineneta Studio`

## Download

- **GitHub Releases (`.rmskin`):** [Latest release](https://github.com/Agent-pEx/Ping-Status/releases/latest) — **v2.0**
- **Tracked builds:** `dist/Ping-Status-v2.0.rmskin` (canonical filename per tagged version)

## Install

Install the `.rmskin` with Rainmeter, or copy the skin folder into your Skins directory. Load **`PingStatus.ini`**.

## Current release — v2.0 (Kineneta Studio)

- **Kineneta visual rebrand** — dark surface (`30,30,30`) + teal accent (`79,152,163`)
- Branding: **Kineneta Studio**, `kineneta.com`, Ko-fi `kineneta` (A-pEx branding removed)
- Main config renamed to `PingStatus.ini` (load this file after upgrade)
- Credits / Help impressum in **7 languages** (Kineneta Studio Guide §3.5)
- Help readme files remain **UTF-16 LE** for correct accented characters in Rainmeter

## Product assets

Canonical store for storefront art (not packed into the `.rmskin`):

- `assets/icon.png` — 512×512 product icon (transparent corners)
- Screenshots (v2.0, when added): `assets/main.png`, `assets/settings.png`, `assets/help.png`, `assets/desktop.png`

Copy into `Kineneta_Web/public/assets/ping-status/` at web Released time.

## Development workflow

- Development happens on `dev` when that branch exists.
- `main` is reserved for stable release state and published release flow.
- Subproject log: `Ping_Status_DEV_LOG.md` (collector root, alongside `Ping_Status/`)

## Maintainer: new version

1. Build `.rmskin` in Rainmeter.
2. Put the file in the repo root temporarily, then run `.\scripts\prepare-dist-rmskin.ps1 -Version X.Y`, or copy it manually to `dist/Ping-Status-vX.Y.rmskin`.
3. Commit `dist/`, push, tag `vX.Y`, then push tags.
4. Create the GitHub Release from the tag and upload the same `.rmskin`.
