class PolinriderScanner < Formula
  desc "Detect and clean up after the PolinRider supply-chain campaign"
  homepage "https://github.com/meSingh/polinrider-scanner"
  version "3.3.1"
  license "MIT"

  # One prebuilt binary per platform, from the signed release. Each archive
  # carries the binary with its indicator set (ioc/) beside it.
  on_macos do
    on_arm do
      url "https://github.com/meSingh/polinrider-scanner/releases/download/v3.3.1/polinrider-v3.3.1-macos-arm64.tar.gz"
      sha256 "ec6ee8ef00f469098abc72c1f4b31f4ee005a79852f10b8fb702d2ab9825833e"
    end
    on_intel do
      url "https://github.com/meSingh/polinrider-scanner/releases/download/v3.3.1/polinrider-v3.3.1-macos-x86_64.tar.gz"
      sha256 "25ce66561b2a689188ee13eaca0f9f04741028fcbec71f5741dd7ab8314f115b"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/meSingh/polinrider-scanner/releases/download/v3.3.1/polinrider-v3.3.1-linux-arm64.tar.gz"
      sha256 "078c527b6597a4382eb5430b1c9340b3082114ce5eb5de645e50c0d1f0a26c1f"
    end
    on_intel do
      url "https://github.com/meSingh/polinrider-scanner/releases/download/v3.3.1/polinrider-v3.3.1-linux-x86_64.tar.gz"
      sha256 "879c00826cc93b7110853538b313fba1bc4279fb6a8fbd41582dec818223e888"
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
