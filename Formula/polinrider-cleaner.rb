class PolinriderCleaner < Formula
  desc "Detect and clean up after the PolinRider supply-chain campaign"
  homepage "https://github.com/meSingh/polinrider-cleaner"
  version "2.3.0"
  license "MIT"

  # One prebuilt binary per platform, from the signed release. Each archive
  # carries the binary with its indicator set (ioc/) beside it.
  on_macos do
    on_arm do
      url "https://github.com/meSingh/polinrider-cleaner/releases/download/v2.3.0/polinrider-v2.3.0-macos-arm64.tar.gz"
      sha256 "013233742197f8098cd33d80bf007d6a16a6af9413cf5b851d83dd5085bf1285"
    end
    on_intel do
      url "https://github.com/meSingh/polinrider-cleaner/releases/download/v2.3.0/polinrider-v2.3.0-macos-x86_64.tar.gz"
      sha256 "24f0d5bf1359c85eaccc88aec92f4d777780f5b14e6b92071444b286049f8b67"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/meSingh/polinrider-cleaner/releases/download/v2.3.0/polinrider-v2.3.0-linux-arm64.tar.gz"
      sha256 "d618728120ea5719476bf8058806d6889457f1ba48f4e140e4bb926366a3796c"
    end
    on_intel do
      url "https://github.com/meSingh/polinrider-cleaner/releases/download/v2.3.0/polinrider-v2.3.0-linux-x86_64.tar.gz"
      sha256 "dc4080af6b085060029a675fcdcd850aa4f50232663e0194ca112b9efbf58bf9"
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
