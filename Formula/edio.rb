class Edio < Formula
  desc "A command-line tool that opens stdin in your editor and outputs the result to stdout"
  homepage "https://github.com/muleyuck/edio"
  version "0.2.1"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/muleyuck/edio/releases/download/v0.2.1/edio-aarch64-apple-darwin.tar.xz"
      sha256 "5d47b0307b1ce21204579028a19daf3d114cf06892de37d3ec91b0ea843ff493"
    end
    if Hardware::CPU.intel?
      url "https://github.com/muleyuck/edio/releases/download/v0.2.1/edio-x86_64-apple-darwin.tar.xz"
      sha256 "86306d6ba5c6c5e74965f6b240432a85e61852e6110a20575c09c26b3d0f8b91"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/muleyuck/edio/releases/download/v0.2.1/edio-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "c6f48d97e417e90dc06870dd11721adb9a5fec71b8b8219afcb12033e253e057"
    end
    if Hardware::CPU.intel?
      url "https://github.com/muleyuck/edio/releases/download/v0.2.1/edio-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "327d1aeb3aa7267f4a4eef4028a16c5ba6dc535c506a3f48914c5d66f2ac5cd6"
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
