#!/bin/bash
# Build a GDM (login screen) theme bundle from a built Jewbuntu shell theme, without
# touching any system file. Ubuntu selects the login theme through the
# "gdm-theme.gresource" alternative; the package registers this bundle there.
# usage: build-gdm-gresource.sh THEME_DIR/gnome-shell OUTPUT.gresource
set -euo pipefail
SRC="$1"; OUT="$2"
work=$(mktemp -d --tmpdir jewbuntu-gdm.XXXXXX)
cp -a "$SRC"/. "$work"/
# GDM loads gdm.css from the bundle; relative asset URLs must become resource URLs.
sed 's#url("assets/#url("resource:///org/gnome/shell/theme/assets/#g; s#url(assets/#url(resource:///org/gnome/shell/theme/assets/#g' \
  "$SRC/gnome-shell.css" > "$work/gdm.css"
for name in gnome-shell.css gnome-shell-dark.css gnome-shell-high-contrast.css; do cp "$work/gdm.css" "$work/$name"; done
{
  echo '<?xml version="1.0" encoding="UTF-8"?>'
  echo '<gresources><gresource prefix="/org/gnome/shell/theme">'
  (cd "$work" && find . -type f ! -name '*.xml' | sed 's#^\./##' | LC_ALL=C sort | sed 's#.*#  <file>&</file>#')
  echo '</gresource></gresources>'
} > "$work/jewbuntu-gdm.gresource.xml"
glib-compile-resources --sourcedir="$work" --target="$OUT" "$work/jewbuntu-gdm.gresource.xml"
echo "built $OUT ($(wc -c < "$OUT") bytes, $(grep -c '<file>' "$work/jewbuntu-gdm.gresource.xml") files)"
