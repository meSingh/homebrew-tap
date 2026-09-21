cask "sukhi-play" do
  arch arm: "AppleSilicon", intel: "Intel"

  version "1.0.16"
  sha256 arm:   "748d14b1b5fb80a3be06f9282344bd19f9729a8f4d7f7ab302a07006bf0d938a",
         intel: "06e323720d36a42cda7ff4a5eff8bc83574d727ac906bdf587fd1d97147070f1"

  url "https://github.com/meSingh/sukhi-play/releases/download/v#{version}/Sukhi-Play-macOS-#{arch}.dmg"
  name "Sukhi Play"
  desc "Locked-down browser that opens only the websites a grown-up chose"
  homepage "https://mesingh.github.io/sukhi-play/"

  livecheck do
    url :url
    strategy :github_latest
  end

  depends_on macos: :ventura

  app "Sukhi Play.app"

  # Everything the app writes, all of it under the user's own account.
  zap trash: [
    "~/Library/Application Support/Sukhi Play",
    "~/Library/Preferences/com.msingh.sukhi.play.plist",
    "~/Library/Saved Application State/com.msingh.sukhi.play.savedState",
  ]

  caveats <<~EOS
    Sukhi Play is signed but not notarised, because notarising needs a paid
    Apple developer account and this is a free project. macOS therefore blocks
    the first launch. To allow it once:

      System Settings -> Privacy & Security -> Open Anyway

    or, from a terminal:

      xattr -dr com.apple.quarantine "/Applications/Sukhi Play.app"

    On macOS 10.15 to 12, use the separate build instead:
      https://mesingh.github.io/sukhi-play/macos.html
  EOS
end
