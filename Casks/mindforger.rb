cask "mindforger" do
  version "2.4.0,20260922.184101"
  sha256 "14ab631790ee3343eaf497a70158ec135fa0b0b4ef23b1c228584be3535c699a"

  url "https://github.com/dvorka/mindforger/releases/download/#{version.csv.first}/mindforger-#{version.csv.first}-#{version.csv.second}-intel.dmg",
      verified: "github.com/dvorka/mindforger/"
  name "MindForger"
  desc "Thinking notebook and Markdown IDE"
  homepage "https://www.mindforger.com/"

  livecheck do
    url :url
    regex(/^mindforger[._-]v?(\d+(?:\.\d+)+)[._-](\d+\.\d+)[._-]intel\.dmg$/i)
    strategy :github_latest do |json, regex|
      json["assets"]&.map do |asset|
        match = asset["name"]&.match(regex)
        next if match.blank?

        "#{match[1]},#{match[2]}"
      end
    end
  end

  depends_on macos: ">= :high_sierra"

  app "mindforger.app"

  # MindForger is neither signed nor notarized - remove the quarantine
  # attribute so that Gatekeeper does not block the first launch
  postflight do
    system_command "/usr/bin/xattr",
                   args:         ["-dr", "com.apple.quarantine", "#{appdir}/mindforger.app"],
                   must_succeed: false
  end

  zap trash: [
    "~/.local/share/MindForger",
    "~/.mindforger.md",
    "~/Library/Application Support/MindForger",
    "~/Library/Saved Application State/com.yourcompany.mindforger.savedState",
  ]

  caveats do
    requires_rosetta

    <<~EOS
      MindForger is neither signed nor notarized by Apple. The quarantine
      attribute is removed on install; if macOS still refuses to open the app,
      run:

        xattr -dr com.apple.quarantine #{appdir}/mindforger.app

      or allow it in System Settings > Privacy & Security > Open Anyway.
    EOS
  end
end
