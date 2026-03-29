# Ping-Status-by-A-pEx

A minimalist ICMP-based network connectivity monitor for Rainmeter.

## Download

- **GitHub Releases (`.rmskin`):** [Latest release](https://github.com/Agent-pEx/Ping-Status-by-A-pEx/releases/latest) — attach the packaged skin there for each version.
- **Tracked builds:** the `dist/` folder holds the canonical `.rmskin` filename for each tagged version (see `dist/README.md`).

## Install

Install the `.rmskin` with Rainmeter, or copy the skin folder into your Skins directory. Load **`PingStatusByA-pEx.ini`**.

## Maintainer: new version

1. Build `.rmskin` in Rainmeter (Skin Packager).
2. Put the file in the repo **root** temporarily, then run `.\scripts\prepare-dist-rmskin.ps1 -Version X.Y`, **or** copy manually to `dist/Ping-Status-by-A-pEx-vX.Y.rmskin`.
3. Commit `dist/`, push, tag `vX.Y`, push tags.
4. GitHub → **Releases** → draft from tag → upload the same `.rmskin`.

Details (Hungarian): `dist/README.md`.
