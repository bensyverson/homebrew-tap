class Peep < Formula
  desc "Compare images and sample their pixels"
  homepage "https://github.com/bensyverson/PixelPeeper"
  url "https://github.com/bensyverson/PixelPeeper/archive/refs/tags/v0.1.0.tar.gz"
  sha256 "6ffa1267b1ef5c2a1c859ea6e5b309acf9296b16345895b1cd145a5a7e0073d6"
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
