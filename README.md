# Ping-Status-by-A-pEx

A minimalist ICMP-based network connectivity monitor for Rainmeter.

## Canonical naming

- Display / project name: `Ping Status by A-pEx`
- GitHub repository: `Agent-pEx/Ping-Status-by-A-pEx`
- Local folder under the collector: `Ping Status by A-pEx/`
- Default working branch: `dev`
- Release / stable branch: `main`
- Rainmeter config name: `Ping Status by A-pEx`
- Main `.ini` file: `PingStatusByA-pEx.ini`

## Download

- **GitHub Releases (`.rmskin`):** [Latest release](https://github.com/Agent-pEx/Ping-Status-by-A-pEx/releases/latest)
- **Tracked builds:** the `dist/` folder holds the canonical `.rmskin` filename for each tagged version

## Install

Install the `.rmskin` with Rainmeter, or copy the skin folder into your Skins directory. Load **`PingStatusByA-pEx.ini`**.

## Development workflow

- Development happens on `dev` when that branch exists.
- `main` is reserved for stable release state and published release flow.

## Maintainer: new version

1. Build `.rmskin` in Rainmeter.
2. Put the file in the repo root temporarily, then run `.\scripts\prepare-dist-rmskin.ps1 -Version X.Y`, or copy it manually to `dist/Ping-Status-by-A-pEx-vX.Y.rmskin`.
3. Commit `dist/`, push, tag `vX.Y`, then push tags.
4. Create the GitHub Release from the tag and upload the same `.rmskin`.
