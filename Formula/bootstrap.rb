class Bootstrap < Formula
  desc "Set up a Mac and a project for working with Claude Code or OpenCode"
  homepage "https://github.com/bensyverson/bootstrap"
  url "https://github.com/bensyverson/bootstrap/archive/refs/tags/v0.3.2.tar.gz"
  sha256 "b7a2f07f801320920385cb2ef3457e05bfec1bed1192512e5a9d40e7b941749a"
  license "MIT"
  head "https://github.com/bensyverson/bootstrap.git", branch: "main"

  bottle do
    root_url "https://github.com/bensyverson/bootstrap/releases/download/v0.3.2"
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "449c583acccfdbab91b32c439aad00da0e6212215c8d48bde81cb62272ad7076"
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
