#!/bin/bash
set -eu
# Renders the original Jewbuntu wallpapers (needs librsvg2-bin and imagemagick).
# In a container: mount this folder at /out and run it; it writes the .jpeg files there.
mk() { # name sky1 sky2 deep mid light glow
cat > /tmp/$1.svg <<SVG
<svg xmlns="http://www.w3.org/2000/svg" width="5040" height="3360" viewBox="-600 -600 5040 3360">
 <defs>
  <linearGradient id="sky" x1="0" y1="0" x2="0.9" y2="1"><stop offset="0" stop-color="$2"/><stop offset="0.55" stop-color="$3"/><stop offset="1" stop-color="$4"/></linearGradient>
  <filter id="b" filterUnits="userSpaceOnUse" x="-1200" y="-1200" width="6240" height="4560"><feGaussianBlur stdDeviation="110"/></filter>
  <filter id="s" filterUnits="userSpaceOnUse" x="-1200" y="-1200" width="6240" height="4560"><feGaussianBlur stdDeviation="55"/></filter>
 </defs>
 <rect x="-1000" y="-1000" width="5840" height="4160" fill="url(#sky)"/>
 <g filter="url(#b)">
  <path d="M-1000 1150 C 300 700, 1200 1350, 2050 980 S 3300 250, 4900 420 L4900 3200 L-1000 3200 Z" fill="$5"/>
  <path d="M-1000 1550 C 600 1150, 1500 1750, 2450 1250 S 3600 700, 4900 980 L4900 3200 L-1000 3200 Z" fill="$4"/>
  <path d="M900 3200 C 1700 2100, 2700 1450, 4900 1150 L4900 3200 Z" fill="$6"/>
  <ellipse cx="2950" cy="1500" rx="900" ry="260" transform="rotate(-18 2950 1500)" fill="$7" opacity="0.6"/>
  <ellipse cx="900" cy="1900" rx="1100" ry="240" transform="rotate(-8 900 1900)" fill="$6" opacity="0.45"/>
 </g>
 <g filter="url(#s)" opacity="0.5">
  <path d="M-600 1320 C 500 980, 1400 1500, 2250 1150 S 3400 520, 4600 640" fill="none" stroke="$7" stroke-width="90" stroke-linecap="round"/>
 </g>
</svg>
SVG
rsvg-convert -w 5040 -h 3360 /tmp/$1.svg -o /tmp/$1-big.png && convert /tmp/$1-big.png -crop 3840x2160+600+600 +repage /tmp/$1.png
convert /tmp/$1.png -quality 88 -sampling-factor 4:2:0 -strip /out/$1.jpeg
convert /tmp/$1.png -resize 960x540 /out/$1-preview.png
cp /tmp/$1.svg /out/$1.svg
}
mk Jewbuntu-night '#3b22a8' '#2a2a9a' '#0a2a9a' '#5a3fc0' '#5d8fe6' '#8fb4ff'
mk Jewbuntu-day '#f6e6b8' '#a8dbe8' '#0b56cf' '#2f8ed8' '#a9d2f2' '#ffffff'
