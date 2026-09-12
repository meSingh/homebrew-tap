class PolinriderCleaner < Formula
  desc "Detect and clean up after the PolinRider supply-chain campaign"
  homepage "https://github.com/meSingh/polinrider-cleaner"
  url "https://github.com/meSingh/polinrider-cleaner/releases/download/v1.0.9/polinrider-cleaner-v1.0.9.tar.gz"
  sha256 "f4e17926665e32585a5b41738be302e8dd4ad043a2cdae52f31e46c1d6315795"
  license "MIT"
  head "https://github.com/meSingh/polinrider-cleaner.git", branch: "main"

  depends_on "gh"
  depends_on "jq"

  def install
    # The scripts locate lib/, ui/ and ioc/ relative to their own real path,
    # so the whole tree lives in libexec and bin gets an exec wrapper rather
    # than a symlink. A symlink leaves $0 pointing into bin/ and the script
    # cannot find its own libraries.
    libexec.install Dir["*"]
    (bin/"polinrider").write <<~SH
      #!/bin/bash
      exec "#{libexec}/polinrider.sh" "$@"
    SH
  end

  def caveats
    <<~EOS
      Read-only by default. Start with:
        polinrider
      It asks what you want to check and picks the right scanner.
    EOS
  end

  test do
    assert_match "polinrider.sh", shell_output("#{bin}/polinrider --help")
  end
end
