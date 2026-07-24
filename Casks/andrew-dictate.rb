cask "andrew-dictate" do
  version "0.3.0"
  sha256 "2c4da684a5605a0f3e6f8653101d774e01df963651236eb76cbedca85130cc3d"

  url "https://github.com/jassuwu/andrew-dictate/releases/download/v#{version}/AndrewDictate-#{version}.dmg"
  name "Andrew Dictate"
  desc "Fast, fully local dictation and voice command mode"
  homepage "https://github.com/jassuwu/andrew-dictate"

  depends_on macos: ">= :sonoma"
  depends_on arch: :arm64

  app "Andrew Dictate.app"

  caveats <<~EOS
    andrew dictate is currently unsigned. clear the quarantine:
      xattr -dr com.apple.quarantine "/Applications/Andrew Dictate.app"
    or right-click the app in Finder and choose Open on first launch.

    on first run it downloads the ~450 MB parakeet v2 speech model.
  EOS

  zap trash: [
    "~/Library/Application Support/Andrew Dictate",
  ]
end
