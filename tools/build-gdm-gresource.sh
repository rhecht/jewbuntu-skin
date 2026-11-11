#!/bin/bash
# Build a GDM (login screen) theme bundle from a built Jewbuntu shell theme, without
# touching any system file. Ubuntu selects the login theme through the
# "gdm-theme.gresource" alternative; the package registers this bundle there.
# usage: build-gdm-gresource.sh THEME_DIR/gnome-shell OUTPUT.gresource WALLPAPER
set -euo pipefail
SRC="$1"; OUT="$2"; WALL="$3"
IM="$(command -v magick || command -v convert || true)"
[ -n "$IM" ] || { echo 'ImageMagick is required (the login background would otherwise be a blank placeholder)' >&2; exit 1; }
work=$(mktemp -d --tmpdir jewbuntu-gdm.XXXXXX)
cp -a "$SRC"/. "$work"/
# Login background like GNOME's lock screen: the Jewbuntu wallpaper, softly blurred and dimmed.
# (The theme's own assets/background.png is a 1x1 placeholder unless upstream's GDM tweak runs.)
"$IM" "$WALL" -scale 1920x -blur 0x18 -fill black -colorize 25% -quality 88 "$work/assets/login-background.jpg"
# GDM loads gdm.css (or gdm-dark/-light) from the bundle; asset URLs become resource URLs.
sed 's#url("assets/background.png")#url("assets/login-background.jpg")#g; s#url("assets/#url("resource:///org/gnome/shell/theme/assets/#g; s#url(assets/#url(resource:///org/gnome/shell/theme/assets/#g' \
  "$SRC/gnome-shell.css" > "$work/gdm.css"
for name in gdm-dark.css gdm-light.css gdm-high-contrast.css gnome-shell.css gnome-shell-dark.css gnome-shell-high-contrast.css; do cp "$work/gdm.css" "$work/$name"; done
{
  echo '<?xml version="1.0" encoding="UTF-8"?>'
  echo '<gresources><gresource prefix="/org/gnome/shell/theme">'
  (cd "$work" && find . -type f ! -name '*.xml' | sed 's#^\./##' | LC_ALL=C sort | sed 's#.*#  <file>&</file>#')
  echo '</gresource></gresources>'
} > "$work/jewbuntu-gdm.gresource.xml"
glib-compile-resources --sourcedir="$work" --target="$OUT" "$work/jewbuntu-gdm.gresource.xml"
echo "built $OUT ($(wc -c < "$OUT") bytes, $(grep -c '<file>' "$work/jewbuntu-gdm.gresource.xml") files)"
