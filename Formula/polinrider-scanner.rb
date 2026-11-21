class PolinriderScanner < Formula
  desc "Detect and clean up after the PolinRider supply-chain campaign"
  homepage "https://github.com/meSingh/polinrider-scanner"
  version "3.2.0"
  license "MIT"

  # One prebuilt binary per platform, from the signed release. Each archive
  # carries the binary with its indicator set (ioc/) beside it.
  on_macos do
    on_arm do
      url "https://github.com/meSingh/polinrider-scanner/releases/download/v3.2.0/polinrider-v3.2.0-macos-arm64.tar.gz"
      sha256 "e6b5691cef5885d27009ac538e1d79e83b372b4a0da6d53f0ec65c7cce4ab366"
    end
    on_intel do
      url "https://github.com/meSingh/polinrider-scanner/releases/download/v3.2.0/polinrider-v3.2.0-macos-x86_64.tar.gz"
      sha256 "a87d3bba505274c3f03981f2d63520f64eaad2cefe117e65d491f18f17b6168a"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/meSingh/polinrider-scanner/releases/download/v3.2.0/polinrider-v3.2.0-linux-arm64.tar.gz"
      sha256 "a0d27905025ba8ccbbf1dfd2b173ec5f21534c3a7c75ec86b9e57f68cffcf06b"
    end
    on_intel do
      url "https://github.com/meSingh/polinrider-scanner/releases/download/v3.2.0/polinrider-v3.2.0-linux-x86_64.tar.gz"
      sha256 "a9538916ab50797d0ae87b1834122fce4139f30aeae1800087aa6e487c6262c9"
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
