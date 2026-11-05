class Sleepy < Formula
  desc "Headless WebKit browser for agents"
  homepage "https://github.com/bensyverson/sleepyhollow"
  url "https://github.com/bensyverson/sleepyhollow/archive/refs/tags/v0.0.0.tar.gz"
  sha256 "0000000000000000000000000000000000000000000000000000000000000000"
  license "MIT"
  head "https://github.com/bensyverson/sleepyhollow.git", branch: "main"

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
