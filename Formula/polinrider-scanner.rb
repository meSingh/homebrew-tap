class PolinriderScanner < Formula
  desc "Detect and clean up after the PolinRider supply-chain campaign"
  homepage "https://github.com/meSingh/polinrider-scanner"
  version "3.3.0"
  license "MIT"

  # One prebuilt binary per platform, from the signed release. Each archive
  # carries the binary with its indicator set (ioc/) beside it.
  on_macos do
    on_arm do
      url "https://github.com/meSingh/polinrider-scanner/releases/download/v3.3.0/polinrider-v3.3.0-macos-arm64.tar.gz"
      sha256 "d81b6196e5034a9ee39adfc4e153d51c5e63f0e255c325a87fee005e9f2891dd"
    end
    on_intel do
      url "https://github.com/meSingh/polinrider-scanner/releases/download/v3.3.0/polinrider-v3.3.0-macos-x86_64.tar.gz"
      sha256 "255e1b2d06f5a68f90c13d51678d2242cdef00e97b01cd9e40dc06ff64059a37"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/meSingh/polinrider-scanner/releases/download/v3.3.0/polinrider-v3.3.0-linux-arm64.tar.gz"
      sha256 "75428305a0f3db501e7e525c5a81f967feb6dd1829eca1c3c340e4e062370f43"
    end
    on_intel do
      url "https://github.com/meSingh/polinrider-scanner/releases/download/v3.3.0/polinrider-v3.3.0-linux-x86_64.tar.gz"
      sha256 "94ab8a93659a0f48a3e122e9ad2469b705f333b00de6d1c19a88f48d3afa9dd5"
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
