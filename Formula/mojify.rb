class Mojify < Formula
  desc "Terminal-first video player that renders media as colored character frames"
  homepage "https://github.com/jassuwu/mojify"
  url "https://github.com/jassuwu/mojify/archive/refs/tags/v2026.06.04.5.tar.gz"
  sha256 "2f2115f171a7a3deeda05ee36947bdb9d601fa882f1fb855c0c332d94b0d63a5"
  license "MIT"

  head "https://github.com/jassuwu/mojify.git", branch: "main"

  bottle do
    root_url "https://github.com/jassuwu/homebrew-tap/releases/download/mojify-2026.06.04.5"
    rebuild 1
    sha256 cellar: :any_skip_relocation, arm64_tahoe:  "2904181b63cbcbd6da286417932f517fc6468ea796c6a9045d6e9919b2043b6a"
    sha256 cellar: :any_skip_relocation, sequoia:      "ad6d6e28b2d13b991c8fec12ae84b86f5bbf0f77f492094549e813fa392216df"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "cc8ec385844afc721324cf09f90b0549ed920ef60a2c91be684dba9595ceb7f7"
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
