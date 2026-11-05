class Agents < Formula
  desc "Keep the instructions you give coding agents the same across all your repos"
  homepage "https://github.com/bensyverson/agents"
  url "https://github.com/bensyverson/agents/archive/refs/tags/v0.1.0.tar.gz"
  sha256 "3315c571ec42df54d2881b8a75fe57c905327e78ba970990961372b266927531"
  license "MIT"
  head "https://github.com/bensyverson/agents.git", branch: "main"

  bottle do
    root_url "https://github.com/bensyverson/agents/releases/download/v0.1.0"
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "cb8a45681d1e651d9f534d53c41499b7f255169c02fdb33b44b3ad0cf4de1fd2"
  end

  depends_on "go" => :build
  depends_on macos: :sequoia

  def install
    system "go", "build", *std_go_args, "./cmd/agents"
  end

  test do
    assert_match "agents #{version}", shell_output("#{bin}/agents --version")
    ENV["AGENTS_REGISTRY"] = testpath/"registry"
    system "git", "init"
    system bin/"agents", "init"
    assert_path_exists testpath/"AGENTS.md"
    assert_path_exists testpath/".agents.yaml"
  end
end
