# The Homebrew cask, as it is published to the noloman/homebrew-keysi tap.
#
# GENERATED FROM, NOT BY HAND: scripts/cask.sh renders this file — filling
# in 1.0.11 and 1b7b00d6c326ec7ea8cb86c2167e1f73e01b58400c6b7cdc3aa3642988f359cc from the DMG that release actually serves —
# and commits the result to the tap as Casks/keysi.rb. Edit this template;
# never edit the copy in the tap, because the next release overwrites it.
#
# Why a tap of our own rather than homebrew/cask: Homebrew requires a cask's
# software to be "notable", measured on the repository that hosts it — 75
# stars, 30 forks or 30 watchers for a third-party submission, and 225 / 90 /
# 90 when the author submits their own app. noloman/keysi is a Pages repo
# that serves the site, the appcast and the binaries, so it carries none of
# those. A tap needs no permission from anyone and installs identically; see
# marketing/copy/directories.md for when to revisit the core repo.
cask "keysi" do
  version "1.0.11"
  sha256 "1b7b00d6c326ec7ea8cb86c2167e1f73e01b58400c6b7cdc3aa3642988f359cc"

  # The DMG the GitHub Release serves, which is the same artifact the
  # site's Download button hands out. No `verified:` — Homebrew 7 deprecated
  # it and warns on every install that uses it, having replaced it with
  # verification it does itself.
  url "https://github.com/noloman/keysi/releases/download/v#{version}/Keysi-#{version}.dmg"
  name "Keysi"
  desc "Menu bar cheat sheet for the keyboard shortcuts of the app you are in"
  homepage "https://keysi.io/"

  # Read from the same Sparkle feed every installed copy reads, so `brew
  # livecheck` cannot disagree with the app's own updater about what the
  # current version is.
  livecheck do
    url "https://keysi.io/appcast.xml"
    # The feed carries both a short version (1.0.6) and Sparkle's build
    # number (7), and the default strategy returns them joined: "1.0.6,7".
    # The download URL has no build number in it, so carrying one in the
    # cask's version would be a second identifier for the same file — and
    # every release would need it to be right for no benefit. Take the
    # short version, which is the whole of what the URL needs.
    strategy :sparkle, &:short_version
  end

  # Keysi updates itself through Sparkle. Without this, Homebrew believes
  # it owns the version in /Applications and reports every self-update as
  # an outdated cask it wants to "fix" by reinstalling over the top.
  auto_updates true
  # macOS 26 Tahoe or newer, which is Keysi's deployment target. A bare
  # symbol is Homebrew's spelling of ">=" here; `">= :tahoe"` is the same
  # requirement and `brew style` rewrites it to this.
  depends_on macos: :tahoe

  app "Keysi.app"

  uninstall quit:       "me.manulorenzo.Keysi",
            login_item: "Keysi"

  # Everything Keysi writes outside its own bundle. The Pro licence is
  # deliberately absent: it lives in the Keychain, and a `zap` that threw it
  # away would turn "uninstall and reinstall" — the first thing anybody
  # tries — into "buy it again".
  zap trash: [
    "~/Library/Application Support/Keysi",
    "~/Library/Caches/me.manulorenzo.Keysi",
    "~/Library/HTTPStorages/me.manulorenzo.Keysi",
    "~/Library/Preferences/me.manulorenzo.Keysi.plist",
    "~/Library/Saved Application State/me.manulorenzo.Keysi.savedState",
  ]
end
