class PolinriderCleaner < Formula
  desc "Detect and clean up after the PolinRider supply-chain campaign"
  homepage "https://github.com/meSingh/polinrider-cleaner"
  version "2.2.0"
  license "MIT"

  # One prebuilt binary per platform, from the signed release. Each archive
  # carries the binary with its indicator set (ioc/) beside it.
  on_macos do
    on_arm do
      url "https://github.com/meSingh/polinrider-cleaner/releases/download/v2.2.0/polinrider-v2.2.0-macos-arm64.tar.gz"
      sha256 "d3294d557d9411d7c8909f37da8442deae50e3d3b9ab6071182108eda86ebe65"
    end
    on_intel do
      url "https://github.com/meSingh/polinrider-cleaner/releases/download/v2.2.0/polinrider-v2.2.0-macos-x86_64.tar.gz"
      sha256 "11ca3d41884cbefb763a62f78d95d4f62b65d7160f3b68f1481e8ad55cf6c234"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/meSingh/polinrider-cleaner/releases/download/v2.2.0/polinrider-v2.2.0-linux-arm64.tar.gz"
      sha256 "9f9d533b6c34c75ebb7ff03f7b4405dc6a98eea7266aa498cfa650c71cdb6dd1"
    end
    on_intel do
      url "https://github.com/meSingh/polinrider-cleaner/releases/download/v2.2.0/polinrider-v2.2.0-linux-x86_64.tar.gz"
      sha256 "01337b3699c840feadb214d8e3e33543324627d9e0fdcb3adcc0d63e1257dfaf"
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
