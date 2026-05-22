## dotfiles

Config files and settings used on my macOS powered machines

### Background soft

Most of the soft described below you can find in my stars list: https://github.com/stars/MarshalX/lists/soft-tools

- Magnet (paid from App Store. Open Source alternative: Rectangle) – windows manager
- Hidden Bar – menu bar cleaner
  - auto-hide after 1 min
- Maccy – clipboard manager
- Grammarly – fix my freaking english
- iStat Menus (paid from App Store) – machine resources in the menu bar
- 1Password – password manager
- TextSnipper (paid from App Store) – like default screenshot tool but capture text from anywhere on the screen
  - capture text shortcut: ⌥ + \` 
- The Unarchiver – unarchiver that supports more extensions 
- Recess (paid from App Store) – helps take a breaks
- Raycast – replacement of spotlight
- uBlock Origin Late – adblock for Safari
- Tailscale – VPN
- MonitorControl – Better support of external monitors

Full list is available [here](Brewfile).

### Configs

Backup stored in the private cloud using [mackup](https://github.com/lra/mackup).

Because of new macOS and how it handles symlinks we need to use this workaround:

Saving configs (when leaving a machine):
```shell
mackup backup && mackup uninstall
```

Loading configs (on new machine): 
```
mackup restore && mackup uninstall
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
- Screen Saver → Hello (theme: minimal, "all languages" off, "match system appearance" off, "show with clock" on)
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
- Install Brew and bundle:
  - `xcode-select --install`
  - `export HOMEBREW_NO_INSTALL_FROM_API=1`
  - `/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"`
  - add brew to .zprofile
  - call eval to run brew shell
  - `cd ~ && mkdir projects && cd projects`
  - `git clone https://github.com/MarshalX/dotfiles.git && cd dotfiles`
  - `brew bundle --file=Brewfile`
- Install ohmyzsh `sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"`
- Restore configs: `cp ~/projects/dotfiles/.mackup.cfg ~ && mackup restore && mackup uninstall`
- Apply system preferences: `./.macos` (then follow the manual checklist above)
- Add [`IsoKeyboardRemap.workflow`](IsoKeyboardRemap.workflow) to Login Items
  (System Settings → General → Login Items → "+" → pick the `.workflow` from this repo).
  Runs on each login to apply ISO-keyboard key remaps.
- Open JetBrains Toolbox and install IntelliJ IDEA, CLion, Android Studio (sync cloud settings or export + import)
- Open installed apps and login/configure
