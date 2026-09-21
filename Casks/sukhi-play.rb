cask "sukhi-play" do
  arch arm: "AppleSilicon", intel: "Intel"

  version "1.0.15"
  sha256 arm:   "62915639c416117ba11e28e5c1eb029459a1f849113e36c819ba89947d0bc725",
         intel: "e9dfe7bd56d65cf1eee5b4898ab104e8a9e3f7e8fefda318d198ff00965f948e"

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
