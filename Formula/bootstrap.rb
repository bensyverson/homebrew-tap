class Bootstrap < Formula
  desc "Set up a Mac and a project for working with Claude Code or OpenCode"
  homepage "https://github.com/bensyverson/bootstrap"
  url "https://github.com/bensyverson/bootstrap/archive/refs/tags/v0.2.0.tar.gz"
  sha256 "b2e40e616867fddb6ab0a9b438ea4a4ae9dc335537155dddb6a97d64d322c957"
  license "MIT"
  head "https://github.com/bensyverson/bootstrap.git", branch: "main"

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
