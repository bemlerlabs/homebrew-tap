# Homebrew Cask for Ephe (R20 — distribution parity).
#
# Usage (official tap):
#   brew tap bemlerlabs/tap
#   brew install --cask bemlerlabs/tap/ephe
#
# The tap copy is written by scripts/render_packaging.py at release time, which fills the
# version and the sha256 from the published release. This file is the template it reads, so
# keep its shape; the numbers are checked against the release by scripts/packaging_freshness.py.
cask "ephe" do
  version "0.2.0"
  license "BUSL-1.1"
  sha256 "1ab181a66ab06b01731f2b1af69f9d06f489ffe9b952f65d570d87031ab14266" # 0.1.0 candidate DMG; render_packaging replaces it at release

  url "https://github.com/bemlerlabs/ephe/releases/download/v#{version}/Ephe_#{version}_aarch64.dmg"
  name "Ephe"
  desc "Local-first AI assistant — private, offline, yours"
  homepage "https://github.com/bemlerlabs/ephe"

  app "Ephe.app"

  # The DMG is not notarized, so Gatekeeper would block the first launch of a copy that
  # carries the quarantine attribute Homebrew sets on downloads. Removing it here is the
  # install step's job: the hash above is what ties this install to the published DMG.
  postflight do
    system_command "/usr/bin/xattr",
                   args: ["-dr", "com.apple.quarantine", "#{appdir}/Ephe.app"],
                   sudo: false
  end

  zap trash: [
    "~/.ephe",
    "~/Library/Application Support/com.ephe.ephe",
  ]
end
