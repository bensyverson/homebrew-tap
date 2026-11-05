class Peep < Formula
  desc "Compare images and sample their pixels"
  homepage "https://github.com/bensyverson/PixelPeeper"
  url "https://github.com/bensyverson/PixelPeeper/archive/refs/tags/v0.0.0.tar.gz"
  sha256 "0000000000000000000000000000000000000000000000000000000000000000"
  license "MIT"
  head "https://github.com/bensyverson/PixelPeeper.git", branch: "main"

  depends_on xcode: ["26.4", :build]
  depends_on macos: :sequoia

  def install
    system "swift", "build", "--disable-sandbox", "-c", "release", "--product", "peep"
    bin.install ".build/release/peep"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/peep --version")
    png = "iVBORw0KGgoAAAANSUhEUgAAAAEAAAABCAYAAAAfFcSJAAAADUlEQVR42mP8z8DwHwAFBQIAX8jx0gAAAABJRU5ErkJggg=="
    (testpath/"a.png").binwrite png.unpack1("m")
    assert_match "MAE", shell_output("#{bin}/peep compare a.png a.png")
  end
end
