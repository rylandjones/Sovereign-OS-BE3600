#!/bin/sh
EN="$1"
if [ "$EN" = "1" ] || [ "$EN" = "true" ]; then
  logger -t sovereign "Wellness ON"; /usr/sbin/plc-toggle.sh on || true; echo "boost" >/tmp/scalar_state
  if [ "$(uci -q get sovereign.system.sound_enabled)" != "0" ]; then (aplay -q /usr/share/sovereign/sounds/wellness-528.wav >/dev/null 2>&1 &) || true; fi
  echo "dim" >/tmp/lighting_state
else
  logger -t sovereign "Wellness OFF"; /usr/sbin/plc-toggle.sh off || true; echo "idle" >/tmp/scalar_state; echo "normal" >/tmp/lighting_state
fi
