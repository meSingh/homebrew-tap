class PolinriderScanner < Formula
  desc "Detect and clean up after the PolinRider supply-chain campaign"
  homepage "https://github.com/meSingh/polinrider-scanner"
  version "3.0.1"
  license "MIT"

  # One prebuilt binary per platform, from the signed release. Each archive
  # carries the binary with its indicator set (ioc/) beside it.
  on_macos do
    on_arm do
      url "https://github.com/meSingh/polinrider-scanner/releases/download/v3.0.1/polinrider-v3.0.1-macos-arm64.tar.gz"
      sha256 "c018c072fd97b8ef096974b1360c377bd4005ae2f3bf7af063f3cec4b58fdda1"
    end
    on_intel do
      url "https://github.com/meSingh/polinrider-scanner/releases/download/v3.0.1/polinrider-v3.0.1-macos-x86_64.tar.gz"
      sha256 "282eb554e756349fe7d4f63d0eabd32c235439082aab41601a81c1538a092963"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/meSingh/polinrider-scanner/releases/download/v3.0.1/polinrider-v3.0.1-linux-arm64.tar.gz"
      sha256 "61b15fa606643bb4f01653b65b24e0bcf5fdfae82c6593b584da9060a3cc2073"
    end
    on_intel do
      url "https://github.com/meSingh/polinrider-scanner/releases/download/v3.0.1/polinrider-v3.0.1-linux-x86_64.tar.gz"
      sha256 "50dbe886002eac08723aa9d9528adb40fc918422bbec79c5c1eab1e0cbcf6653"
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
