class Bootstrap < Formula
  desc "Set up a Mac and a project for working with Claude Code or OpenCode"
  homepage "https://github.com/bensyverson/bootstrap"
  url "https://github.com/bensyverson/bootstrap/archive/refs/tags/v0.3.1.tar.gz"
  sha256 "d7477d7cc084380fdb8cf13167615853bf493f6b5eefe3adc37646dc3756d18a"
  license "MIT"
  head "https://github.com/bensyverson/bootstrap.git", branch: "main"

  bottle do
    root_url "https://github.com/bensyverson/bootstrap/releases/download/v0.3.1"
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "6d77eef5a5771bc3dc5d97b4d3dc5e3440743e37f252a938cce44684fea84222"
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
