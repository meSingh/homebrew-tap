class PolinriderScanner < Formula
  desc "Detect and clean up after the PolinRider supply-chain campaign"
  homepage "https://github.com/meSingh/polinrider-scanner"
  version "3.1.0"
  license "MIT"

  # One prebuilt binary per platform, from the signed release. Each archive
  # carries the binary with its indicator set (ioc/) beside it.
  on_macos do
    on_arm do
      url "https://github.com/meSingh/polinrider-scanner/releases/download/v3.1.0/polinrider-v3.1.0-macos-arm64.tar.gz"
      sha256 "6e50c8d620125e5f6248e95ae950049883c4f25153249ebf773f270e8b69a726"
    end
    on_intel do
      url "https://github.com/meSingh/polinrider-scanner/releases/download/v3.1.0/polinrider-v3.1.0-macos-x86_64.tar.gz"
      sha256 "ffc66b5b58320f91478edabb2b18117787f188dc3142a10095e5309dafb10fee"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/meSingh/polinrider-scanner/releases/download/v3.1.0/polinrider-v3.1.0-linux-arm64.tar.gz"
      sha256 "ba00f0395fb6274b9087b5736b9dd2c1f88cbdf38ec35b32f021ba05f4a15be8"
    end
    on_intel do
      url "https://github.com/meSingh/polinrider-scanner/releases/download/v3.1.0/polinrider-v3.1.0-linux-x86_64.tar.gz"
      sha256 "e87f05fa75ef03c919766d8316639f8118f3ce3cf227e4451c17061172680420"
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
