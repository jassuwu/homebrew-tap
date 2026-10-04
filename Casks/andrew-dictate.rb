cask "andrew-dictate" do
  version "0.13.0"
  sha256 "e0f34003fd0ad4b14b5a007a742ca8a559a6181fc2c4f3004de8bea942b4db9e"

  url "https://github.com/jassuwu/andrew-dictate/releases/download/v#{version}/AndrewDictate-#{version}.dmg"
  name "Andrew Dictate"
  desc "Dictation and meeting transcripts for talking to AI agents"
  homepage "https://github.com/jassuwu/andrew-dictate"

  depends_on macos: :tahoe
  depends_on arch: :arm64

  app "Andrew Dictate.app"

  caveats <<~EOS
    andrew dictate is not signed. clear the quarantine once, then open it:
      xattr -dr com.apple.quarantine "/Applications/Andrew Dictate.app"
      open "/Applications/Andrew Dictate.app"

    setup downloads the speech models for the jobs you tick:
    dictation is ~460 mb, meeting recording is ~2.9 gb.
  EOS

  zap trash: [
    "~/Library/Application Support/Andrew Dictate",
  ]
end
