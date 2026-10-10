cask "turnray" do
  version "0.2.0"
  sha256 "fdf85e666feb30cd42ff48a2b8d6e76a873bf48aef185a8d60e3d9fd82acad68"

  url "https://github.com/muleyuck/turnray/releases/download/v#{version}/turnray-#{version}.zip"
  name "turnray"
  desc "Menu bar app that shows the status of AI agents running under herdr"
  homepage "https://github.com/muleyuck/turnray"

  depends_on :macos

  app "turnray.app"

  # turnray is ad-hoc signed only, so Gatekeeper would block the quarantined app.
  postflight_steps do
    run "/usr/bin/xattr", args: ["-dr", "com.apple.quarantine", "{{appdir}}/turnray.app"]
  end

  zap trash: "~/Library/Application Support/turnray"

  caveats <<~EOS
    turnray shows agents from herdr, so herdr must be installed and running
    (for example: brew install herdr).

    To start turnray at login, add it in
    System Settings > General > Login Items.
  EOS
end
