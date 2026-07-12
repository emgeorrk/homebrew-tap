# homebrew-tap

Homebrew tap for [Pulse](https://github.com/emgeorrk/pulse) — a native macOS
menu bar system monitor.

## Install

```sh
brew install emgeorrk/tap/pulse
```

This builds Pulse from source (Homebrew pulls in Go as a build dependency). A
locally built app is **not quarantined**, so it launches with **no Gatekeeper
prompt and no extra flags** — unlike a downloaded, un-notarized `.app`.

After install, `brew` prints how to launch it and, optionally, symlink it into
`/Applications`. Update later with:

```sh
brew upgrade pulse
```

Uninstall:

```sh
brew uninstall pulse
```

## Why a formula and not a cask?

A cask would download the pre-built `.app` from GitHub Releases, but that build
is ad-hoc signed and not notarized. Homebrew always quarantines cask downloads,
removed the `--no-quarantine` flag, and is dropping support for casks that fail
Gatekeeper. Building from source sidesteps all of that: the app is compiled on
your machine, so macOS never quarantines it.
