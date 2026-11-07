class Job < Formula
  desc "Command-line planner and task tracker built for coding agents"
  homepage "https://github.com/bensyverson/jobs"
  url "https://github.com/bensyverson/jobs/archive/refs/tags/v0.3.0.tar.gz"
  sha256 "7750a43c5a1df5f4e1a428f20986beb5401a0763ed782fcf7d254c689abc9ab1"
  license "MIT"
  head "https://github.com/bensyverson/jobs.git", branch: "main"

  bottle do
    root_url "https://github.com/bensyverson/jobs/releases/download/v0.3.0"
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "e1d36a87467ed0de8c903d76b07553c02d784368a1b71f6f621d6f02dbdf185c"
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
