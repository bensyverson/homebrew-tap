class Job < Formula
  desc "Plan and track work from the command line, built for coding agents"
  homepage "https://github.com/bensyverson/jobs"
  url "https://github.com/bensyverson/jobs/archive/refs/tags/v0.1.0.tar.gz"
  sha256 "006175f4193cf037ed203e0a7738e966058ad82cac72f2110a44fa2aaa645b3b"
  license "MIT"
  head "https://github.com/bensyverson/jobs.git", branch: "main"

  bottle do
    root_url "https://github.com/bensyverson/jobs/releases/download/v0.1.0"
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "fbb68b1c484a52b363b9ea5b5a3f1a40a8fb2c84ec42b8436a3b5f5b7e84571c"
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
