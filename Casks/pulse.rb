cask "pulse" do
  version "1.0.1"
  sha256 "32cdf5e907b7d4a35baec3196a2dfa07848f00a952650cc875881003b2f2b0cf"

  url "https://github.com/emgeorrk/pulse/releases/download/v#{version}/Pulse-#{version}-arm64.zip"
  name "Pulse"
  desc "Menu bar system monitor"
  homepage "https://github.com/emgeorrk/pulse"

  livecheck do
    url :url
    strategy :github_latest
  end

  depends_on macos: ">= :monterey"
  depends_on arch: :arm64

  app "Pulse.app"

  zap trash: [
    "~/Library/Application Support/pulse",
    "~/Library/LaunchAgents/com.emgeorrk.pulse.plist",
  ]
end
