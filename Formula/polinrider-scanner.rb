class PolinriderScanner < Formula
  desc "Detect and clean up after the PolinRider supply-chain campaign"
  homepage "https://github.com/meSingh/polinrider-scanner"
  version "3.0.0"
  license "MIT"

  # One prebuilt binary per platform, from the signed release. Each archive
  # carries the binary with its indicator set (ioc/) beside it.
  on_macos do
    on_arm do
      url "https://github.com/meSingh/polinrider-scanner/releases/download/v3.0.0/polinrider-v3.0.0-macos-arm64.tar.gz"
      sha256 "1e22993d0acbf5553de84d21ea4dc1c42b991941d9c1316c412705fce327e26e"
    end
    on_intel do
      url "https://github.com/meSingh/polinrider-scanner/releases/download/v3.0.0/polinrider-v3.0.0-macos-x86_64.tar.gz"
      sha256 "53e0c42df0928dfc012eb20dd61afcbf170fd05391c408dc41c45ddb8e754b31"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/meSingh/polinrider-scanner/releases/download/v3.0.0/polinrider-v3.0.0-linux-arm64.tar.gz"
      sha256 "b0d635d611a6e63ae3b491339a980a555f1efe965f4c70c22f0f8d273b7d9ceb"
    end
    on_intel do
      url "https://github.com/meSingh/polinrider-scanner/releases/download/v3.0.0/polinrider-v3.0.0-linux-x86_64.tar.gz"
      sha256 "6533f5e12e8520faacad334d809aa0284c631a1b93cff31b583cc47372202972"
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
