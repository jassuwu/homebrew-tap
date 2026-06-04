class Mojify < Formula
  desc "Terminal-first video player that renders media as colored character frames"
  homepage "https://github.com/jassuwu/mojify"
  url "https://github.com/jassuwu/mojify/archive/refs/tags/v2026.06.04.8.tar.gz"
  sha256 "c31636b5e0c75b377bab2327957ee34929a613d9310984b90aaa2e65b3c60945"
  license "MIT"

  head "https://github.com/jassuwu/mojify.git", branch: "main"

  bottle do
    root_url "https://github.com/jassuwu/homebrew-tap/releases/download/mojify-2026.06.04.8"
    rebuild 1
    sha256 cellar: :any_skip_relocation, arm64_tahoe:  "12e37aa808f3796c8010f6b2bbad4c84d6af03e0bfac4acfe44d5959dae356cc"
    sha256 cellar: :any_skip_relocation, sequoia:      "170733f16e3e4fb9575adf46dfeec47a47e1fee6e907a0daf74e7eaa07c3528a"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "4d382461f154441a15da0eb50b8576bfc0035282a43de899d00823c2a02ae9bd"
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
