class Pulse < Formula
  desc "Native macOS menu bar system monitor (Vitals-style feature set)"
  homepage "https://github.com/emgeorrk/pulse"
  version "1.0.1"
  url "https://github.com/emgeorrk/pulse/archive/refs/tags/v#{version}.tar.gz"
  sha256 "b61a9594b14b6528c3fa77f1aade4ce0320de9b4d9673d602ca1ecc8d7969c1e"
  license "MIT"
  head "https://github.com/emgeorrk/pulse.git", branch: "main"

  depends_on "go" => :build
  depends_on :macos

  def install
    ENV["CGO_ENABLED"] = "1"
    ENV["GOTOOLCHAIN"] = "local"

    system "go", "build", "-trimpath", "-o", "pulse", "./cmd/pulse"

    # Assemble the .app bundle (mirrors the repo Makefile `bundle` target),
    # stamp the release version into Info.plist, and ad-hoc sign it. A locally
    # built app is not quarantined, so it launches without a Gatekeeper prompt.
    app = prefix/"Pulse.app"
    (app/"Contents/MacOS").mkpath
    cp "pulse", app/"Contents/MacOS/pulse"
    cp "build/darwin/Info.plist", app/"Contents/Info.plist"

    plist = app/"Contents/Info.plist"
    system "/usr/libexec/PlistBuddy", "-c", "Set :CFBundleShortVersionString #{version}", plist
    system "/usr/libexec/PlistBuddy", "-c", "Set :CFBundleVersion #{version}", plist
    system "/usr/bin/codesign", "--sign", "-", "--force", app.to_s

    # Expose the binary for the terminal sensor dump: `pulse -once`.
    bin.install_symlink app/"Contents/MacOS/pulse" => "pulse"
  end

  def caveats
    <<~EOS
      Pulse is a menu bar app (no Dock icon). Launch it with:
        open #{opt_prefix}/Pulse.app

      To keep it in /Applications (so "Launch at Login" is tidy):
        ln -sfn #{opt_prefix}/Pulse.app /Applications/Pulse.app
        open /Applications/Pulse.app

      Built locally by Homebrew, so it is not quarantined — no Gatekeeper prompt.
      Quit from the dropdown ("Quit Pulse").

      Terminal sensor check without the UI:
        pulse -once

      Note: the Apple Silicon sensor paths are the tested ones. Intel sensor
      paths are compiled but unverified on real Intel hardware.
    EOS
  end

  test do
    assert_predicate bin/"pulse", :executable?
    # -once samples the sensors once, prints a metrics frame, and exits 0.
    assert_match(/.+/, shell_output("#{bin}/pulse -once 2>&1"))
  end
end
