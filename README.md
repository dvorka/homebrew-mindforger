# Homebrew MindForger

[Homebrew](https://brew.sh) tap for [MindForger](https://www.mindforger.com/) -
thinking notebook and Markdown IDE.

MindForger **is not signed nor notarized** by Apple. Therefore it can no longer be
distributed via the official `homebrew/cask` repository. This tap keeps it
installable with Homebrew.


## Install

```sh
brew install --cask dvorka/mindforger/mindforger
```

or:

```sh
brew tap dvorka/mindforger
brew install --cask mindforger
```

## Upgrade

```sh
brew upgrade --cask mindforger
```

## Uninstall

```sh
brew uninstall --cask mindforger
brew untap dvorka/mindforger
```

## Gatekeeper

The cask removes the `com.apple.quarantine` attribute after install, so that
macOS does not block the first launch of the unsigned application. If macOS
still refuses to open MindForger, run:

```sh
xattr -dr com.apple.quarantine /Applications/mindforger.app
```

or allow it in **System Settings > Privacy & Security > Open Anyway**.

MindForger `.dmg` is built for Intel - Apple Silicon Macs run it using
[Rosetta 2](https://support.apple.com/en-us/102527).

## Release a new version

1. Publish `mindforger-<VERSION>-<TIMESTAMP>-intel.dmg` to
   [MindForger releases](https://github.com/dvorka/mindforger/releases) with
   Git tag `<VERSION>`.
2. Update `version` and `sha256` in `Casks/mindforger.rb`:

   ```sh
   brew bump-cask-pr --version <VERSION>,<TIMESTAMP> dvorka/mindforger/mindforger
   ```

   or manually (`shasum -a 256 mindforger-*.dmg`) and verify:

   ```sh
   brew audit --cask --online dvorka/mindforger/mindforger
   brew style dvorka/mindforger/mindforger
   brew install --cask dvorka/mindforger/mindforger
   ```

## Issues

Report issues to [dvorka/mindforger](https://github.com/dvorka/mindforger/issues).
