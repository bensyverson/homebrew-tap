class Woodcase < Formula
  desc "Read, edit, render and generate code from Pen .pen design files"
  homepage "https://github.com/bensyverson/woodcase"
  url "https://github.com/bensyverson/woodcase/archive/refs/tags/v0.1.2.tar.gz"
  sha256 "d13ae78d6e962049bcc9b510f1e44a92851370549d472983af3ebb1935350690"
  license "MIT"
  head "https://github.com/bensyverson/woodcase.git", branch: "main"

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
