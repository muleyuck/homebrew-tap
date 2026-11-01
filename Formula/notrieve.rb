class Notrieve < Formula
  desc "Local hybrid search over Markdown notes for AI agents via MCP"
  homepage "https://github.com/muleyuck/notrieve"
  version "0.1.1"
  license "MIT"

  on_macos do
    depends_on arch: :arm64
    depends_on macos: :ventura

    on_arm do
      url "https://github.com/muleyuck/notrieve/releases/download/v#{version}/notrieve-aarch64-apple-darwin.tar.xz"
      sha256 "1b5b479a3de8aaa1f874e95d4a0fc5c9108bb67a35afb4c68bc3fe899d2c5ee1"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/muleyuck/notrieve/releases/download/v#{version}/notrieve-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "1a5f1b4e033be98c38d6e0140acb414dd3fc2918cfc9a60cab90a14f23abe2db"
    end
    on_intel do
      url "https://github.com/muleyuck/notrieve/releases/download/v#{version}/notrieve-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "ed0440a9fce1684b708d946e23847de8105938b218b8e8e13d513d7fa0b2c62f"
    end
  end

  def install
    bin.install "notrieve"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/notrieve --version")
  end
end
