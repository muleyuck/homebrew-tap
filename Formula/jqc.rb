class Jqc < Formula
  desc "Query and edit JSON with comments (JSONC) using jq"
  homepage "https://github.com/muleyuck/jqc"
  version "0.4.0"
  license "MIT"

  depends_on "jq"

  on_macos do
    on_arm do
      url "https://github.com/muleyuck/jqc/releases/download/v#{version}/jqc-aarch64-apple-darwin.tar.xz"
      sha256 "cf90583fdbf8c1e2c098a1fb0a952ac28fd07ac0ff1009ba8156a569ceca6a1c"
    end
    on_intel do
      url "https://github.com/muleyuck/jqc/releases/download/v#{version}/jqc-x86_64-apple-darwin.tar.xz"
      sha256 "b35f4d251692cf5bcd6d85d35e1fcc4b4d387bc04f6782b8587826151da98a57"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/muleyuck/jqc/releases/download/v#{version}/jqc-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "fcd0e0b47026b851b8ef0835e9d6d9cf9a3aff5211b06f152f90f8eda6165faa"
    end
    on_intel do
      url "https://github.com/muleyuck/jqc/releases/download/v#{version}/jqc-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "d4433b60b70649b9e3665b2e2915c086249e1b349e930867ac806dca4aa4b48d"
    end
  end

  def install
    bin.install "jqc"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/jqc --version")
  end
end
