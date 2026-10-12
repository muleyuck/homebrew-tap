class Edio < Formula
  desc "Edit stdin in your editor and print the result to stdout"
  homepage "https://github.com/muleyuck/edio"
  version "0.3.0"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/muleyuck/edio/releases/download/v#{version}/edio-aarch64-apple-darwin.tar.xz"
      sha256 "7100a5749be89db042cf016461d0f72fe0d21cf20faa7a0235c8f5227bd8f181"
    end
    on_intel do
      url "https://github.com/muleyuck/edio/releases/download/v#{version}/edio-x86_64-apple-darwin.tar.xz"
      sha256 "6b17f1de68839cc0c8a04615e060a0995f78004686f22af5cb1f097ffde36744"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/muleyuck/edio/releases/download/v#{version}/edio-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "0a57fcd6a6044ef8bfabc1186f6a763a115689d23b985d5ffce9dd4c90e0f04f"
    end
    on_intel do
      url "https://github.com/muleyuck/edio/releases/download/v#{version}/edio-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "c0246a72b552b82e56f84497e250313e7a4a58e48955a5b8b6013bfce7e1b514"
    end
  end

  def install
    bin.install "edio"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/edio --version")
  end
end
