class Jqc < Formula
  desc "Query and edit JSON with comments (JSONC) using jq"
  homepage "https://github.com/muleyuck/jqc"
  version "0.4.1"
  license "MIT"

  depends_on "jq"

  on_macos do
    on_arm do
      url "https://github.com/muleyuck/jqc/releases/download/v#{version}/jqc-aarch64-apple-darwin.tar.xz"
      sha256 "25e4b8e8f5766de01d5c41424190462240cbb8800fc2b2a2aeda614498e9d61c"
    end
    on_intel do
      url "https://github.com/muleyuck/jqc/releases/download/v#{version}/jqc-x86_64-apple-darwin.tar.xz"
      sha256 "e40d35e0f160f406e508034af1a0401e7612589c64020dc8f79c274eda67159a"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/muleyuck/jqc/releases/download/v#{version}/jqc-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "0cda0cc0679ef6f9907191825f9a4b646c2b4c12d59dc1aae7e04d80c7e43d47"
    end
    on_intel do
      url "https://github.com/muleyuck/jqc/releases/download/v#{version}/jqc-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "ef2f83614b53bb403cd7ba68143075e4b5e7273a9b896a26b0a25cc9b4df389a"
    end
  end

  def install
    bin.install "jqc"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/jqc --version")
  end
end
