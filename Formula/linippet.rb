# typed: false
# frozen_string_literal: true

# This file was generated by GoReleaser. DO NOT EDIT.
class Linippet < Formula
  desc "One-liner snippet generator for shell."
  homepage "https://github.com/muleyuck/linippet"
  version "0.2.0"
  license "MIT"

  on_macos do
    if Hardware::CPU.intel?
      url "https://github.com/muleyuck/linippet/releases/download/v0.2.0/linippet_Darwin_x86_64.tar.gz"
      sha256 "9088fbf18b153381700424710056f88c89958e7259ec02f86eedb2b637a2f152"

      def install
        bin.install "linippet"
      end
    end
    if Hardware::CPU.arm?
      url "https://github.com/muleyuck/linippet/releases/download/v0.2.0/linippet_Darwin_arm64.tar.gz"
      sha256 "11fe14bb5ae6f8dee6d2abf20ad6487ea5df088a7520cb15b2de923658271df5"

      def install
        bin.install "linippet"
      end
    end
  end

  on_linux do
    if Hardware::CPU.intel?
      if Hardware::CPU.is_64_bit?
        url "https://github.com/muleyuck/linippet/releases/download/v0.2.0/linippet_Linux_x86_64.tar.gz"
        sha256 "439e068491d7c15d2ec0d7f344da66246f3128cd155e101b4b4b2f1663cbf987"

        def install
          bin.install "linippet"
        end
      end
    end
    if Hardware::CPU.arm?
      if Hardware::CPU.is_64_bit?
        url "https://github.com/muleyuck/linippet/releases/download/v0.2.0/linippet_Linux_arm64.tar.gz"
        sha256 "dbce834787f74df8e23d1ad8442b78f0b2b3f6e7ffb1c99105aeb7cddb00e52b"

        def install
          bin.install "linippet"
        end
      end
    end
  end
end
