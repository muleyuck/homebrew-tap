class Notrieve < Formula
  desc "Local hybrid search over Markdown notes for AI agents via MCP"
  homepage "https://github.com/muleyuck/notrieve"
  version "0.1.0"
  license "MIT"

  on_macos do
    depends_on arch: :arm64
    depends_on macos: :ventura

    on_arm do
      url "https://github.com/muleyuck/notrieve/releases/download/v#{version}/notrieve-aarch64-apple-darwin.tar.xz"
      sha256 "9ea8af8a9990c0f6c36763f756ff1d810d4a1836d1628f040401a6c8b995eecd"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/muleyuck/notrieve/releases/download/v#{version}/notrieve-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "0f258dbbdea2b39e532513d65cf5759b0adfb0510f3ff5ebfc485306c6ac1663"
    end
    on_intel do
      url "https://github.com/muleyuck/notrieve/releases/download/v#{version}/notrieve-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "1f5e36ba4659a577b80adb1e020afc98ffeafaebb6bc98f655662151cc6d9cdc"
    end
  end

  def install
    bin.install "notrieve"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/notrieve --version")
  end
end
