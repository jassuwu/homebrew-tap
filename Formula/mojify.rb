class Mojify < Formula
  desc "Terminal-first video player that renders media as colored character frames"
  homepage "https://github.com/jassuwu/mojify"
  url "https://github.com/jassuwu/mojify/archive/refs/tags/v2026.06.05.0.tar.gz"
  sha256 "785d9aec0e8edcdcf437fc45ad95114618cca8387eaf9370f6cc0dd22a32fc46"
  license "MIT"

  head "https://github.com/jassuwu/mojify.git", branch: "main"

  bottle do
    root_url "https://github.com/jassuwu/homebrew-tap/releases/download/mojify-2026.06.05.0"
    rebuild 1
    sha256 cellar: :any_skip_relocation, arm64_tahoe:  "e77c4c7842aba8097b983b92bef2e858db385478af9a385f2c61c90a258aee59"
    sha256 cellar: :any_skip_relocation, sequoia:      "67f619edac262c69a5a174f7b6dbd03b017a2f6b472ce611e378fa78baf4b134"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "d074879ef652ba1313727265ed82c2c116481b37787b31259c8803dd417338a4"
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
