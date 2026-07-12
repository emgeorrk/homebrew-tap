# homebrew-tap

Homebrew tap for [Pulse](https://github.com/emgeorrk/pulse) — a native macOS
menu bar system monitor.

## Install

```sh
brew install emgeorrk/tap/pulse
ln -sfn "$(brew --prefix)/opt/pulse/Pulse.app" /Applications/Pulse.app
open /Applications/Pulse.app
```

Pulse is compiled from source, so macOS never quarantines it — no Gatekeeper
prompt, no flags. The second line links it into `/Applications`.

Update with `brew upgrade pulse`, uninstall with `brew uninstall pulse`.
