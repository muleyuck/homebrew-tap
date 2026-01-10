class Edio < Formula
  desc "JSON navigator and interactive filter leveraging jq"
  homepage "https://github.com/muleyuck/edio"
  version "0.1.1"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/muleyuck/edio/releases/download/v0.1.1/edio-aarch64-apple-darwin.tar.xz"
      sha256 "986f3e67703f196397bce977f8490720e54f3caccec48908c6ee8c95c6cd05cc"
    end
    if Hardware::CPU.intel?
      url "https://github.com/muleyuck/edio/releases/download/v0.1.1/edio-x86_64-apple-darwin.tar.xz"
      sha256 "cf4d70e8706d25cf60de75fcb823936fb2066abedde2e06eab4f02661ac683cf"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/muleyuck/edio/releases/download/v0.1.1/edio-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "ff6bc3ba5b140ae7dd58abcedf921e4181d48710b79f2eac00170a7524df6a4a"
    end
    if Hardware::CPU.intel?
      url "https://github.com/muleyuck/edio/releases/download/v0.1.1/edio-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "681abdddb65520c1b41bd0dea73f9714c5b099055002bd549f1a30cc2af80592"
    end
  end
  license "MIT"

  BINARY_ALIASES = {
    "aarch64-apple-darwin":      {},
    "aarch64-unknown-linux-gnu": {},
    "x86_64-apple-darwin":       {},
    "x86_64-unknown-linux-gnu":  {},
  }.freeze

  def target_triple
    cpu = Hardware::CPU.arm? ? "aarch64" : "x86_64"
    os = OS.mac? ? "apple-darwin" : "unknown-linux-gnu"

    "#{cpu}-#{os}"
  end

  def install_binary_aliases!
    BINARY_ALIASES[target_triple.to_sym].each do |source, dests|
      dests.each do |dest|
        bin.install_symlink bin/source.to_s => dest
      end
    end
  end

  def install
    bin.install "edio" if OS.mac? && Hardware::CPU.arm?
    bin.install "edio" if OS.mac? && Hardware::CPU.intel?
    bin.install "edio" if OS.linux? && Hardware::CPU.arm?
    bin.install "edio" if OS.linux? && Hardware::CPU.intel?

    install_binary_aliases!

    # Homebrew will automatically install these, so we don't need to do that
    doc_files = Dir["README.*", "readme.*", "LICENSE", "LICENSE.*", "CHANGELOG.*"]
    leftover_contents = Dir["*"] - doc_files

    # Install any leftover files in pkgshare; these are probably config or
    # sample files.
    pkgshare.install(*leftover_contents) unless leftover_contents.empty?
  end
end
