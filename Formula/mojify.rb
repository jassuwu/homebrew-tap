class Mojify < Formula
  desc "Terminal-first video player that renders media as colored character frames"
  homepage "https://github.com/jassuwu/mojify"
  url "https://github.com/jassuwu/mojify/archive/refs/tags/v2026.06.05.1.tar.gz"
  sha256 "f84afc2bfc78c5bd5415bd6c8051979de4db31bec9c10666d68c362f90842d98"
  license "MIT"

  head "https://github.com/jassuwu/mojify.git", branch: "main"

  bottle do
    root_url "https://github.com/jassuwu/homebrew-tap/releases/download/mojify-2026.06.05.1"
    rebuild 1
    sha256 cellar: :any_skip_relocation, arm64_tahoe:  "722332ea31ebb8f85dab9a94e2bc5caacd38bbba49b2ac0978a6796705fa5f2a"
    sha256 cellar: :any_skip_relocation, sequoia:      "506465fa958ee7ffa4f0bd233c981b91ba11ff981de6ad6d9b7fd9c742e06e78"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "643c013f6a039bf2d6135ce7225829bc8ac4a3bdd1824a98f02d47a4f76964d1"
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
