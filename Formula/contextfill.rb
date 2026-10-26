class Contextfill < Formula
  desc "Report how full a Claude Code or OpenCode session's context window is"
  homepage "https://github.com/bensyverson/contextfill"
  url "https://github.com/bensyverson/contextfill/archive/refs/tags/v0.1.1.tar.gz"
  sha256 "bd78e63395bb1f8e5140a7a3df126d35ba2b3f6d4cacac017719378d22bf8907"
  license "MIT"
  head "https://github.com/bensyverson/contextfill.git", branch: "main"

  depends_on "go" => :build

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
