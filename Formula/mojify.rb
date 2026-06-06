class Mojify < Formula
  desc "Terminal-first video player that renders media as colored character frames"
  homepage "https://github.com/jassuwu/mojify"
  url "https://github.com/jassuwu/mojify/archive/refs/tags/v2026.06.06.0.tar.gz"
  sha256 "665f7e917450d00d1556913d944a290be3a5586ef6b1376ef3024116d92ac16b"
  license "MIT"

  head "https://github.com/jassuwu/mojify.git", branch: "main"

  bottle do
    root_url "https://github.com/jassuwu/homebrew-tap/releases/download/mojify-2026.06.06.0"
    rebuild 1
    sha256 cellar: :any_skip_relocation, arm64_tahoe:  "d41e5ded79a53d568ac5fcb18a6d88be6e83b2711d78684cf51524ccd2440ac8"
    sha256 cellar: :any_skip_relocation, sequoia:      "8f7ac69b883f0a71bf9d76366243a16f59207a508659f3fd670663c12eadd268"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "96a5172eeb49d5140ac4b7e092f231b4e522908614af16b1e3eb177d1571a173"
  end

  depends_on "go" => :build
  depends_on "ffmpeg"
  depends_on "yt-dlp"

  def install
    version_text = build.head? ? "0.0.0-dev" : version.to_s
    ldflags = "-s -w -X github.com/jass/mojify/packages/core/internal/cli.version=#{version_text}"
    system "go", "build", *std_go_args(output: bin/"mojify", ldflags: ldflags), "./packages/core/cmd/mojify"
  end

  test do
    expected = build.head? ? "mojify 0.0.0-dev" : "mojify #{version}"
    assert_match expected, shell_output("#{bin}/mojify --version")
  end
end
