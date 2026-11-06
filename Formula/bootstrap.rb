class Bootstrap < Formula
  desc "Set up a Mac and a project for working with Claude Code or OpenCode"
  homepage "https://github.com/bensyverson/bootstrap"
  url "https://github.com/bensyverson/bootstrap/archive/refs/tags/v0.3.0.tar.gz"
  sha256 "4dd9df4cb44cf6c02e22098bd112d52d4174868668c8bdc680eda37f515d49f6"
  license "MIT"
  head "https://github.com/bensyverson/bootstrap.git", branch: "main"

  bottle do
    root_url "https://github.com/bensyverson/bootstrap/releases/download/v0.3.0"
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "458bde0ba4b7ab0fb4dd275bca19def1ceb2eb2f1503ae539bd3f8f165a85273"
  end

  depends_on "go" => :build
  depends_on macos: :sequoia

  def install
    ldflags = "-s -w -X github.com/bensyverson/bootstrap/internal/cli.Version=#{version}"
    system "go", "build", *std_go_args(ldflags:), "./cmd/bootstrap"
  end

  test do
    assert_match "bootstrap #{version}", shell_output("#{bin}/bootstrap --version")
  end
end
