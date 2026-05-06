class Jqc < Formula
  desc "jq for JSONC — query, view, and edit JSON-with-Comments files without losing your comments."
  homepage "https://github.com/muleyuck/jqc"
  version "0.1.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/muleyuck/jqc/releases/download/v0.1.0/jqc-aarch64-apple-darwin.tar.xz"
      sha256 "7ed5312f3bfcc0fec72b0befc4db05443f6be9482dbc743f280021f32b0fba14"
    end
    if Hardware::CPU.intel?
      url "https://github.com/muleyuck/jqc/releases/download/v0.1.0/jqc-x86_64-apple-darwin.tar.xz"
      sha256 "41b2507a0bc0c7f2370a904af0de91172cdc7f2eab720f9ee583c2e93a66046a"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/muleyuck/jqc/releases/download/v0.1.0/jqc-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "c91bd8b7f9b9c0224d7827b2b545ba62263e9c12af85d0c3f0208eeea3497159"
    end
    if Hardware::CPU.intel?
      url "https://github.com/muleyuck/jqc/releases/download/v0.1.0/jqc-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "6e9848a00a4a9b31eb9cb307d5b77516a5bb02728df489578de2be11e3a450d3"
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
