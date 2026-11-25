class Timetattle < Formula
  desc "Reconstructs when work happened, and for whom, from the traces it leaves"
  homepage "https://github.com/bensyverson/timetattle"
  url "https://github.com/bensyverson/timetattle/archive/refs/tags/v0.2.0.tar.gz"
  sha256 "cb03e285f640a4837e50c50762649d3d3310ca1c83944ce25a00c2bf5f5a92b5"
  license "MIT"
  head "https://github.com/bensyverson/timetattle.git", branch: "main"

  depends_on "go" => :build
  depends_on macos: :sequoia

  def install
    system "go", "build", *std_go_args(ldflags: "-s -w"), "./cmd/timetattle"
  end

  def caveats
    <<~EOS
      Timetattle needs Full Disk Access to read macOS presence data. Add
      #{opt_bin}/timetattle under System Settings > Privacy & Security >
      Full Disk Access, and check it again after an upgrade.

      Some of that data is pruned within weeks, so schedule the hourly harvest:
        brew services start timetattle
      Then confirm that it is arriving:
        timetattle status
    EOS
  end

  # The label is the one `timetattle status` reads the schedule from.
  service do
    name macos: "com.bensyverson.timetattle.harvest"
    run [opt_bin/"timetattle", "harvest"]
    run_type :cron
    cron "0 * * * *"
    run_at_load true
    process_type :background
    log_path var/"log/timetattle.log"
    error_log_path var/"log/timetattle.err.log"
  end

  test do
    assert_match "timetattle #{version}", shell_output("#{bin}/timetattle version")
  end
end
