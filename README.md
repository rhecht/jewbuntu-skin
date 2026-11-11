# Jewbuntu Skin

The desktop theme of [Jewbuntu](https://github.com/rhecht): a Mac-inspired GTK and
GNOME Shell theme with glass panels, a translucent dock and traffic-light window
buttons, set up for Ubuntu 26.04 LTS (GNOME 50).

This is a fork of **[MacTahoe GTK theme](https://github.com/vinceliuice/MacTahoe-gtk-theme)
by vinceliuice and the WhiteSur developers**, used under the MIT licence (see `COPYING`; the original copyright
notice is kept). Nearly all of the work is upstream's. Fixes that make sense
for everyone are offered back upstream.

## What this fork changes

- Theme name **Jewbuntu** (`Jewbuntu-Light`, `Jewbuntu-Dark`, …).
- Default panel "Activities" icon is an original Jewbuntu mark. The Apple-logo option is removed.
- Wallpapers: original Jewbuntu artwork (`wallpaper/`); upstream's macOS wallpapers are
  not included. The default login-screen background is the Jewbuntu wallpaper.
- Upstream screenshots and prebuilt release tarballs are removed (they showed or contained the above).
- Build fixes for automated/package builds: `SKIN_SHELL_VERSION` lets you target a GNOME version other
  than the build machine's, and the installer no longer fails when `sudo` is absent.

## Install

Normally you get this through the `jewbuntu-skin` package. To install by hand on Ubuntu 26.04:

```bash
sudo apt install sassc libglib2.0-dev-bin libxml2-utils gnome-shell-extension-user-theme
./install.sh -b --shell -i jewbuntu          # themes into ~/.themes (blur variant)
./install.sh -l                               # optional: libadwaita (GTK4) apps, per user
./wallpaper/install-gnome-backgrounds.sh      # wallpapers in Settings → Appearance
```

For the glass effect, also install the **Blur my Shell** extension.
In a non-interactive build, set `TERM` (for example `TERM=xterm`).

All options: `./install.sh --help`. Upstream's full documentation also applies:
https://github.com/vinceliuice/MacTahoe-gtk-theme#readme

## Licences

- Theme code and assets: MIT (upstream; see `COPYING`).
- Jewbuntu wallpapers `Jewbuntu-day/night`: CC BY-SA 4.0. Star of David wallpapers: see `wallpaper/README.md`.
