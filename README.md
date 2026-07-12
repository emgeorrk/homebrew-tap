# homebrew-tap

Homebrew tap for [Pulse](https://github.com/emgeorrk/pulse) — a native macOS
menu bar system monitor (Apple Silicon).

## Install

```sh
brew install --cask --no-quarantine emgeorrk/tap/pulse
```

The `--no-quarantine` flag is required: Pulse is ad-hoc signed but not notarized
(no paid Apple Developer account), so without the flag macOS Gatekeeper blocks
it. The flag tells Homebrew not to attach the quarantine attribute, which is the
same thing `xattr -dr com.apple.quarantine` does for a manual download.

Update later with:

```sh
brew upgrade --cask pulse
```

Uninstall (with `--zap` to also remove settings and the login LaunchAgent):

```sh
brew uninstall --zap pulse
```
