cask "andrew-dictate" do
  version "0.11.1"
  sha256 "3b8849217b7163baa2178641f0467b6b9b6bbc6b1888e40dcc30f0b5787b1eb9"

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
