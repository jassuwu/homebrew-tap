class Mojify < Formula
  desc "Terminal-first video player that renders media as colored character frames"
  homepage "https://github.com/jassuwu/mojify"
  url "https://github.com/jassuwu/mojify/archive/refs/tags/v2026.06.04.7.tar.gz"
  sha256 "703669fcde4a748bdf04cd597b1800cb102564421324adc78e4a75852ffb4616"
  license "MIT"

  head "https://github.com/jassuwu/mojify.git", branch: "main"

  bottle do
    root_url "https://github.com/jassuwu/homebrew-tap/releases/download/mojify-2026.06.04.7"
    rebuild 1
    sha256 cellar: :any_skip_relocation, arm64_tahoe:  "0d0e0a5a3fee4d0c1a253e054920b6cf6b786f44de28129441f1f50cc93ec462"
    sha256 cellar: :any_skip_relocation, sequoia:      "ba63b0395f367b955157b7449aec5d61ee68bf0395b63b1e782f53f57356cfb9"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "9735ce01f6f1c76a8cd08b29bb75f353e704200e62136b4d378698d292579c82"
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
