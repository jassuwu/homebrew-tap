cask "andrew-dictate" do
  version "0.6.0"
  sha256 "acb8bb386b8256dc9db23e77dac4bd1b498d4cccb5b143e7ccbc383b280f5de5"

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
