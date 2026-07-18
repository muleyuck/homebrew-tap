class Jqc < Formula
  desc "jq for JSONC — query, view, and edit JSON-with-Comments files without losing your comments."
  homepage "https://github.com/muleyuck/jqc"
  version "0.2.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/muleyuck/jqc/releases/download/v0.2.0/jqc-aarch64-apple-darwin.tar.xz"
      sha256 "9620b077e3ab8752689b20e91d4f59fdab47f9fe57923beb2649ee4296dad890"
    end
    if Hardware::CPU.intel?
      url "https://github.com/muleyuck/jqc/releases/download/v0.2.0/jqc-x86_64-apple-darwin.tar.xz"
      sha256 "07e85fe322b6605773c62c88c20abfe97977c50ade6694056754328807f9b554"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/muleyuck/jqc/releases/download/v0.2.0/jqc-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "762356a48e6aba9fef194e924989bed021ad77f5484a2c00f079add554c35aac"
    end
    if Hardware::CPU.intel?
      url "https://github.com/muleyuck/jqc/releases/download/v0.2.0/jqc-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "facd81b903c6b82bbb922bf1b60b50258d6a7f808dca3a795f9265bcae76e81b"
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
    bin.install "jqc" if OS.mac? && Hardware::CPU.arm?
    bin.install "jqc" if OS.mac? && Hardware::CPU.intel?
    bin.install "jqc" if OS.linux? && Hardware::CPU.arm?
    bin.install "jqc" if OS.linux? && Hardware::CPU.intel?

    install_binary_aliases!

    # Homebrew will automatically install these, so we don't need to do that
    doc_files = Dir["README.*", "readme.*", "LICENSE", "LICENSE.*", "CHANGELOG.*"]
    leftover_contents = Dir["*"] - doc_files

    # Install any leftover files in pkgshare; these are probably config or
    # sample files.
    pkgshare.install(*leftover_contents) unless leftover_contents.empty?
  end
end
