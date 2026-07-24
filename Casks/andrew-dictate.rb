cask "andrew-dictate" do
  version "0.1.0"
  sha256 "ed51141569adf98b76b5a60fe4867cae2a33e7a61dfbb5bc4f18cfec832524e3"

  url "https://github.com/jassuwu/andrew-dictate/releases/download/v#{version}/AndrewDictate-#{version}.dmg"
  name "Andrew Dictate"
  desc "Fast, fully local dictation and voice command mode"
  homepage "https://github.com/jassuwu/andrew-dictate"

  depends_on macos: ">= :sonoma"
  depends_on arch: :arm64

  app "Andrew Dictate.app"

  caveats <<~EOS
    andrew dictate is currently unsigned. if you installed without
    --no-quarantine, right-click the app in Finder and choose Open
    on first launch.

    on first run it downloads the ~450 MB parakeet v2 speech model.
  EOS

  zap trash: [
    "~/Library/Application Support/Andrew Dictate",
  ]
end
