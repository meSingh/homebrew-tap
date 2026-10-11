class PolinriderCleaner < Formula
  desc "Detect and clean up after the PolinRider supply-chain campaign"
  homepage "https://github.com/meSingh/polinrider-cleaner"
  version "2.0.0"
  license "MIT"

  # One prebuilt binary per platform, from the signed release. Each archive
  # carries the binary with its indicator set (ioc/) beside it.
  on_macos do
    on_arm do
      url "https://github.com/meSingh/polinrider-cleaner/releases/download/v2.0.0/polinrider-v2.0.0-macos-arm64.tar.gz"
      sha256 "ef21ce0000fe638b531ee25b5d6b2f3665b9603d22924acf960d8856976f61c0"
    end
    on_intel do
      url "https://github.com/meSingh/polinrider-cleaner/releases/download/v2.0.0/polinrider-v2.0.0-macos-x86_64.tar.gz"
      sha256 "358fed69930e6cbb952c20448aee5a4898de0b96e2103a64360c2e79c84bf4ce"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/meSingh/polinrider-cleaner/releases/download/v2.0.0/polinrider-v2.0.0-linux-arm64.tar.gz"
      sha256 "45e873ebdf24958c1cb66cdee0e40dcc07d787ccb0a2e43e53c17a8416dfbcfa"
    end
    on_intel do
      url "https://github.com/meSingh/polinrider-cleaner/releases/download/v2.0.0/polinrider-v2.0.0-linux-x86_64.tar.gz"
      sha256 "b595870544c8ea8f257bb3ff1d2e5030e3028c2284ab62b12e7606939c45db31"
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
