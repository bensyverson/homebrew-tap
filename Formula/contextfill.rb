class Contextfill < Formula
  desc "Report how full a Claude Code or OpenCode session's context window is"
  homepage "https://github.com/bensyverson/contextfill"
  url "https://github.com/bensyverson/contextfill/archive/refs/tags/v0.1.3.tar.gz"
  sha256 "c4760f68c2404417dea2f8b087ff148ebb1d59a157dc32466174c573b54d5b4d"
  license "MIT"
  head "https://github.com/bensyverson/contextfill.git", branch: "main"

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
