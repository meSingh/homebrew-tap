class PolinriderScanner < Formula
  desc "Detect and clean up after the PolinRider supply-chain campaign"
  homepage "https://github.com/meSingh/polinrider-scanner"
  version "3.3.2"
  license "MIT"

  # One prebuilt binary per platform, from the signed release. Each archive
  # carries the binary with its indicator set (ioc/) beside it.
  on_macos do
    on_arm do
      url "https://github.com/meSingh/polinrider-scanner/releases/download/v3.3.2/polinrider-v3.3.2-macos-arm64.tar.gz"
      sha256 "3be7510032c2008c6f2e6d7263314d2ccddb78b306eb2820b742b7d96d68c791"
    end
    on_intel do
      url "https://github.com/meSingh/polinrider-scanner/releases/download/v3.3.2/polinrider-v3.3.2-macos-x86_64.tar.gz"
      sha256 "5e7d0d0371841a02e1bb826890e8c379e81301ff71a2495b2f55298ef102dacd"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/meSingh/polinrider-scanner/releases/download/v3.3.2/polinrider-v3.3.2-linux-arm64.tar.gz"
      sha256 "b905955e9ef5747e8197e930b1644b508cef329a3d66d2df4b1ace4b9e4bd745"
    end
    on_intel do
      url "https://github.com/meSingh/polinrider-scanner/releases/download/v3.3.2/polinrider-v3.3.2-linux-x86_64.tar.gz"
      sha256 "32c79792be65f84a497be7fab9fbd256345b4e9666a434efbaa821b307895727"
    end
  end

  def install
    # The binary resolves its own real path and looks for share/polinrider/ioc
    # above it, so the indicators go there and bin gets the binary itself.
    bin.install "polinrider"
    (share/"polinrider").install "ioc"
    doc.install "DISCLAIMER.md"
    man1.install "polinrider.1"
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
