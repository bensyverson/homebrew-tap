class Sleepy < Formula
  desc "Headless WebKit browser for agents"
  homepage "https://github.com/bensyverson/sleepyhollow"
  url "https://github.com/bensyverson/sleepyhollow/archive/refs/tags/v0.2.0.tar.gz"
  sha256 "870d197f521fa657250d2c216dc9dfdb3fb60bd9d9022827e4e5c6845a07de14"
  license "MIT"
  head "https://github.com/bensyverson/sleepyhollow.git", branch: "main"

  bottle do
    root_url "https://github.com/bensyverson/sleepyhollow/releases/download/v0.2.0"
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "277ba9cd20ec8a023779429dd39fc2b1983a453fc1af36c860b1acc7888c13da"
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
