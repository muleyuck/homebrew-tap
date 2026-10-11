class Jqc < Formula
  desc "jq for JSONC — query, view, and edit JSON-with-Comments files without losing your comments."
  homepage "https://github.com/muleyuck/jqc"
  version "0.3.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/muleyuck/jqc/releases/download/v0.3.0/jqc-aarch64-apple-darwin.tar.xz"
      sha256 "abc74155507384f1401006f0bf56ef8a6299e251d832ceffef79f19f5ce4fe50"
    end
    if Hardware::CPU.intel?
      url "https://github.com/muleyuck/jqc/releases/download/v0.3.0/jqc-x86_64-apple-darwin.tar.xz"
      sha256 "89947a62d40adcf578bda8abebdddb92f2efd6e1217c6d1bcb56b868943800dd"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/muleyuck/jqc/releases/download/v0.3.0/jqc-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "09d35740f1e010337d67a45fd40bf18cac5a83d3647b223ff3bc2e87ada568cc"
    end
    if Hardware::CPU.intel?
      url "https://github.com/muleyuck/jqc/releases/download/v0.3.0/jqc-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "9af69c2140ba4e49df572fe9f355003e0f7edcc7339dec4f6cec47eea537b77b"
    end
  end
  license "MIT"
  depends_on "jq"

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
    if OS.mac? && Hardware::CPU.arm?
      bin.install "jqc"
    end
    if OS.mac? && Hardware::CPU.intel?
      bin.install "jqc"
    end
    if OS.linux? && Hardware::CPU.arm?
      bin.install "jqc"
    end
    if OS.linux? && Hardware::CPU.intel?
      bin.install "jqc"
    end

    install_binary_aliases!

    # Homebrew will automatically install these, so we don't need to do that
    doc_files = Dir["README.*", "readme.*", "LICENSE", "LICENSE.*", "CHANGELOG.*"]
    leftover_contents = Dir["*"] - doc_files

    # Install any leftover files in pkgshare; these are probably config or
    # sample files.
    pkgshare.install(*leftover_contents) unless leftover_contents.empty?
  end
end
