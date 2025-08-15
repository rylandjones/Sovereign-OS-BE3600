#!/bin/sh
# Sovereign Sound: use aplay if available; fallback to speaker-test if not
CFG_SOUND=$(uci -q get sovereign.system.sound_enabled)
VOL=$(uci -q get sovereign.system.sound_volume || echo 30)
[ "$CFG_SOUND" = "0" ] && exit 0
file="$1"; [ -f "$file" ] || exit 0
if command -v aplay >/dev/null 2>&1; then aplay -q "$file"; else speaker-test -t sine -f 528 -l 1 >/dev/null 2>&1; fi
