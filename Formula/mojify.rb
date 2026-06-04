class Mojify < Formula
  desc "Terminal-first video player that renders media as colored character frames"
  homepage "https://github.com/jassuwu/mojify"
  url "https://github.com/jassuwu/mojify/archive/refs/tags/v2026.06.04.6.tar.gz"
  sha256 "071e8681fb12dd85014e8b309517adb970efc43c36b2cc3ebf9d781f56499a31"
  license "MIT"

  head "https://github.com/jassuwu/mojify.git", branch: "main"

  bottle do
    root_url "https://github.com/jassuwu/homebrew-tap/releases/download/mojify-2026.06.04.6"
    rebuild 1
    sha256 cellar: :any_skip_relocation, arm64_tahoe:  "adf503aa05e4f0e3aea014d7e22935f6e4eac1b7db2d3b54865c9d46bab08a40"
    sha256 cellar: :any_skip_relocation, sequoia:      "7b0e9db1ca83bc014b6be93b079f882c6c75f5f5e5bc592b0a512d240200b535"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "ce3e0e4c48b53b7671bf9cd313a6402f2ebfde66bf045f80b51157f9dec27d0f"
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
