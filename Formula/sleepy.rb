class Sleepy < Formula
  desc "Headless WebKit browser for agents"
  homepage "https://github.com/bensyverson/sleepyhollow"
  url "https://github.com/bensyverson/sleepyhollow/archive/refs/tags/v0.1.0.tar.gz"
  sha256 "4fc307e119f6006131e447c8179ea85954388d6c5af245f83c19cc35f5190cbe"
  license "MIT"
  head "https://github.com/bensyverson/sleepyhollow.git", branch: "main"

  bottle do
    root_url "https://github.com/bensyverson/sleepyhollow/releases/download/v0.1.0"
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "cde10e5922e30c42960bc5f749e68a17e78264fc53ed9e2da68539da2d61aa16"
  end

  depends_on xcode: ["26.4", :build]
  depends_on macos: :sequoia

  def install
    system "swift", "build", "--disable-sandbox", "-c", "release", "--product", "sleepy"
    bin.install ".build/release/sleepy"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/sleepy --version")
    assert_match "headless WebKit", shell_output("#{bin}/sleepy --help")
  end
end
