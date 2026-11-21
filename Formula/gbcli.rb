class Gbcli < Formula
  desc "Agent-friendly Game Boy development tool: headless emulator and build loop"
  homepage "https://github.com/bensyverson/gbcli"
  url "https://github.com/bensyverson/gbcli/archive/refs/tags/v0.0.0.tar.gz"
  sha256 "0000000000000000000000000000000000000000000000000000000000000000"
  license "MIT"
  head "https://github.com/bensyverson/gbcli.git", branch: "main"

  depends_on "rust" => :build
  depends_on "rgbds"

  on_macos do
    depends_on macos: :sequoia
  end

  def install
    # The bottle is tagged for the oldest macOS above, so SameBoy's C and the
    # Rust code must target it rather than the build machine's release.
    ENV["MACOSX_DEPLOYMENT_TARGET"] = "15.0" if OS.mac?
    system "cargo", "install", *std_cargo_args(path: "crates/gbcli")
  end

  test do
    assert_match "gbcli #{version}", shell_output("#{bin}/gbcli --version")
    system bin/"gbcli", "new", "game"
    cd "game" do
      assert_match "errors=0", shell_output("#{bin}/gbcli build")
      output = shell_output("#{bin}/gbcli run build/game.gb --session brew --frames 60 --shot first.png")
      assert_match "stop budget_exhausted", output
      assert_path_exists "first.png"
    end
  end
end
