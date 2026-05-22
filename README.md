## dotfiles

Config files and settings used on my macOS powered machines

### Background soft

Most of the soft described below you can find in my stars list: https://github.com/stars/MarshalX/lists/soft-tools

- Magnet (paid from App Store. Open Source alternative: Rectangle) – windows manager
- Hidden Bar – menu bar cleaner
  - auto-hide after 1 min
- iStat Menus (paid from App Store) – machine resources in the menu bar
- 1Password – password manager
- TextSniper (paid from App Store) – like default screenshot tool but capture text from anywhere on the screen
  - capture text shortcut: ⌥ + \`
- The Unarchiver – unarchiver that supports more extensions
- Raycast – replacement of spotlight (clipboard manager, snippets, etc. built-in)
- uBlock Origin Lite – adblock for Safari
- Tailscale – VPN
- MonitorControl – better support of external monitors
- Mac Mouse Fix – sane mouse acceleration / button customization
- DaisyDisk (paid from App Store) – disk usage visualizer
- OrbStack – Docker Desktop replacement
- Logitech G HUB – Logitech mouse/keyboard configuration

Full list is available [here](Brewfile).

### Configs

Backup stored in the private cloud using [mackup](https://github.com/lra/mackup).

Saving configs (when leaving a machine):
```shell
mackup backup --force
```

Loading configs (on new machine):
```shell
mackup restore
```

### zsh plugins

```shell
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
git clone https://github.com/zsh-users/zsh-history-substring-search ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-history-substring-search
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
git clone https://github.com/MichaelAquilina/zsh-you-should-use.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/you-should-use
```

### System preferences

System, Finder, Dock, keyboard shortcut, and power-management settings are
applied by [`.macos`](.macos). Re-run it any time; it's idempotent.

Things it cannot script (do these manually after running it):

- Link Apple ID / iCloud
- Internet Accounts → add Google account
- Wallpaper → pick from iCloud dir, "Fill Screen"
- Screen Saver → Photos (style: Classic, source: Colors, shuffle slides off)
- Displays → Night Shift → Custom 23:00 → 5:00
- Touch ID → disable Apple Watch unlock (if enabled)
- Default browser → Firefox (set inside Firefox or System Settings)
- Finder sidebar: hide Recent / AirDrop / Shared / Recent tags; show Home, Pictures, `~/projects`, `~/trash`
- App-specific shortcuts:
  - 1Password: Autofill `CMD + \`, Appearance → Density Compact, hide Tags from sidebar
  - TextSniper: Capture Text `option + \``, QR/Bar Code `option + shift + \``

### Step-by-step guide

- Link Apple ID
- Install soft from sec team and so on
- Install Homebrew and clone this repo:
  - `xcode-select --install`
  - `export HOMEBREW_NO_INSTALL_FROM_API=1`
  - `/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"`
  - add brew to `.zprofile`, then `eval "$(/opt/homebrew/bin/brew shellenv)"`
  - `mkdir -p ~/projects && cd ~/projects`
  - `git clone https://github.com/MarshalX/dotfiles.git && cd dotfiles`
- Run [`./bootstrap.sh`](bootstrap.sh) — installs the Brewfile, oh-my-zsh + plugins,
  restores mackup configs, and applies [`.macos`](.macos). Interactive (sudo, prompts).
- Add [`IsoKeyboardRemap.workflow`](IsoKeyboardRemap.workflow) to Login Items
  (System Settings → General → Login Items → "+" → pick the `.workflow` from this repo).
  Runs on each login to apply ISO-keyboard key remaps.
- Open VS Code and sign in with GitHub to sync settings
- Open installed apps and login/configure
- Walk the manual macOS checklist above (iCloud, wallpaper, screen saver, etc.)
