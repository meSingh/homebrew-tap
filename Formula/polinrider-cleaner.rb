class PolinriderCleaner < Formula
  desc "Detect and clean up after the PolinRider supply-chain campaign"
  homepage "https://github.com/meSingh/polinrider-cleaner"
  version "2.1.0"
  license "MIT"

  # One prebuilt binary per platform, from the signed release. Each archive
  # carries the binary with its indicator set (ioc/) beside it.
  on_macos do
    on_arm do
      url "https://github.com/meSingh/polinrider-cleaner/releases/download/v2.1.0/polinrider-v2.1.0-macos-arm64.tar.gz"
      sha256 "b7f0eb3b950b7b48f41b63312a7f78105794ad4e297cc7fbf598c126d6c33c9e"
    end
    on_intel do
      url "https://github.com/meSingh/polinrider-cleaner/releases/download/v2.1.0/polinrider-v2.1.0-macos-x86_64.tar.gz"
      sha256 "a93fb8b6b56598faf1e2f33b53d30d94e6cc53ea54a0112b2f5d1c569f8f58bd"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/meSingh/polinrider-cleaner/releases/download/v2.1.0/polinrider-v2.1.0-linux-arm64.tar.gz"
      sha256 "278a534f6e0e803349c8becc906712bec9023ef6e7bb93bd5e356c59fa1bf6f9"
    end
    on_intel do
      url "https://github.com/meSingh/polinrider-cleaner/releases/download/v2.1.0/polinrider-v2.1.0-linux-x86_64.tar.gz"
      sha256 "4f9bb170760f1b3daa062db8bbd9fa42c7eed786b26bef97ea687e34b65c1f87"
    end
  end

  def install
    # The binary resolves its own real path and looks for share/polinrider/ioc
    # above it, so the indicators go there and bin gets the binary itself.
    bin.install "polinrider"
    (share/"polinrider").install "ioc"
    doc.install "DISCLAIMER.md"
  end

  def caveats
    <<~EOS
      Read-only unless you pass --apply. Start with:
        polinrider
      It asks what you want to check and walks you through it.
    EOS
  end

  test do
    output = shell_output("#{bin}/polinrider --version")
    assert_match version.to_s, output
    refute_match "NOT USABLE", output
  end
end
