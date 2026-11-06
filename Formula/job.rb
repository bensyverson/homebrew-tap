class Job < Formula
  desc "Command-line planner and task tracker built for coding agents"
  homepage "https://github.com/bensyverson/jobs"
  url "https://github.com/bensyverson/jobs/archive/refs/tags/v0.2.0.tar.gz"
  sha256 "cc188b839246c5576010263dfc2b90579a8fb173c8839fc09da685f5e3d15cb7"
  license "MIT"
  head "https://github.com/bensyverson/jobs.git", branch: "main"

  bottle do
    root_url "https://github.com/bensyverson/jobs/releases/download/v0.2.0"
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "e4175ddeb94dfe8f442cd1996fbdd1a0a36b068a698252098f8b09220dbaf47e"
  end

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
