class Woodcase < Formula
  desc "Read, edit, render and generate code from Pen .pen design files"
  homepage "https://github.com/bensyverson/woodcase"
  url "https://github.com/bensyverson/woodcase/archive/refs/tags/v0.1.4.tar.gz"
  sha256 "8c3cbc1d0d2bef9b6b9c740efd46c6743699b347719ab6b8fac9193da0d4a048"
  license "MIT"
  head "https://github.com/bensyverson/woodcase.git", branch: "main"

  bottle do
    root_url "https://github.com/bensyverson/woodcase/releases/download/v0.1.4"
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "b6d49abd1e28a564fa2371ac80c9a00e03fe4635f516120d5e90fa9382102967"
  end

  depends_on xcode: ["26.0", :build]
  depends_on macos: :sequoia

  def install
    system "swift", "build", "--disable-sandbox", "-c", "release", "--product", "woodcase"
    products = Utils.safe_popen_read("swift", "build", "--disable-sandbox", "-c", "release", "--show-bin-path").chomp
    # woodcase reads its icon fonts and code-generation templates from the bundle
    # beside the real binary, so both go into libexec and bin gets a symlink.
    libexec.install "#{products}/woodcase", "#{products}/Woodcase_Woodcase.bundle"
    bin.install_symlink libexec/"woodcase"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/woodcase --version")
    (testpath/"t.pen").write <<~JSON
      {"version": "2.17", "children": [{"type": "frame", "id": "a1b2c", "name": "Home", "width": 10, "height": 10}]}
    JSON
    system bin/"woodcase", "generate", "swiftui", "t.pen", "--output", "ui"
    assert_path_exists testpath/"ui/Sources/PenUI/Support/PenSupport.swift"
  end
end
