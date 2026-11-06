class Contextfill < Formula
  desc "Report how full a Claude Code or OpenCode session's context window is"
  homepage "https://github.com/bensyverson/contextfill"
  url "https://github.com/bensyverson/contextfill/archive/refs/tags/v0.2.0.tar.gz"
  sha256 "5c73759c4a5f1e5fe171768298759ea2aed40966e621ac3a3cf0296b516155bc"
  license "MIT"
  head "https://github.com/bensyverson/contextfill.git", branch: "main"

  bottle do
    root_url "https://github.com/bensyverson/contextfill/releases/download/v0.2.0"
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "77effb56e1773cece55c6584483c2cbcc2e163cd7bd88fb9a31b0dc34141824c"
  end

  depends_on "go" => :build
  depends_on macos: :sequoia

  def install
    system "go", "build", *std_go_args, "./cmd/contextfill"
    pkgshare.install "opencode/plugin/contextfill.js"
  end

  def caveats
    <<~EOS
      To report the fill in OpenCode after each commit, link the plugin into its
      global plugins directory:
        ln -s #{opt_pkgshare}/contextfill.js ~/.config/opencode/plugins/contextfill.js
      If contextfill isn't on the PATH OpenCode runs with, set
        CONTEXTFILL=#{opt_bin}/contextfill

      For Claude Code's hook, see:
        https://github.com/bensyverson/contextfill#after-every-commit
    EOS
  end

  test do
    assert_match "contextfill #{version}", shell_output("#{bin}/contextfill --version")
    assert_match "no session to read", shell_output("#{bin}/contextfill 2>&1", 5)
    assert_path_exists pkgshare/"contextfill.js"
  end
end
