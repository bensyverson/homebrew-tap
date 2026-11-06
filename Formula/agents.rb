class Agents < Formula
  desc "Keep the instructions you give coding agents the same across all your repos"
  homepage "https://github.com/bensyverson/agents"
  url "https://github.com/bensyverson/agents/archive/refs/tags/v0.3.0.tar.gz"
  sha256 "492b6ed8bdb08a39f36a1a1aa18cc16faaaa1bfc6e1fda08515de01fca930bc4"
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
