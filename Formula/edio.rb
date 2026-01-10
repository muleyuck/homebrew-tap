class Edio < Formula
  desc "JSON navigator and interactive filter leveraging jq"
  homepage "https://github.com/muleyuck/edio"
  version "0.2.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/muleyuck/edio/releases/download/v0.2.0/edio-aarch64-apple-darwin.tar.xz"
      sha256 "8eded3ba8a2cf7dd2cd9e47cd2282d969c66518fdc238df267d0cdc6de343774"
    end
    if Hardware::CPU.intel?
      url "https://github.com/muleyuck/edio/releases/download/v0.2.0/edio-x86_64-apple-darwin.tar.xz"
      sha256 "2067a6678baae63b3512214d9b123c86109b1682e0b1cf26bf58cb6d954801e6"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/muleyuck/edio/releases/download/v0.2.0/edio-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "e77158b3ed3139b836c900354d8878b610609a577686872732c326231f1fd80e"
    end
    if Hardware::CPU.intel?
      url "https://github.com/muleyuck/edio/releases/download/v0.2.0/edio-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "a46a427ea46472521cc6495914fa33e7e0174ed5ee208fa35eeb99a42007c352"
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
