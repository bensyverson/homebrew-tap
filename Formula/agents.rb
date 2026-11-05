class Agents < Formula
  desc "Keep the instructions you give coding agents the same across all your repos"
  homepage "https://github.com/bensyverson/agents"
  url "https://github.com/bensyverson/agents/archive/refs/tags/v0.2.0.tar.gz"
  sha256 "7ffb7e31d3ddb62842b05574e3cd74572c1a2c49402dcedcd32c27bd98c31af8"
  license "MIT"
  head "https://github.com/bensyverson/agents.git", branch: "main"

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
