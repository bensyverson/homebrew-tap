class Job < Formula
  desc "Command-line planner and task tracker built for coding agents"
  homepage "https://github.com/bensyverson/jobs"
  url "https://github.com/bensyverson/jobs/archive/refs/tags/v0.3.1.tar.gz"
  sha256 "063f57f3c2af217343b4a77ca596bef2a37827889ba82997f9dd16aea821d83b"
  license "MIT"
  head "https://github.com/bensyverson/jobs.git", branch: "main"

  depends_on "go" => :build
  depends_on macos: :sequoia

  def install
    system "go", "build", *std_go_args, "./cmd/job"
  end

  test do
    assert_match "job #{version}", shell_output("#{bin}/job version")
    system bin/"job", "init", "--as", "brew"
    system bin/"job", "add", "Pour the bottle"
    assert_match "Pour the bottle", shell_output("#{bin}/job ls")
  end
end
