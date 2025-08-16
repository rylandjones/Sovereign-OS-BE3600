#!/bin/sh
set -e
echo "[Sovereign] installing base packages..."
opkg update
opkg install luci luci-ssl uhttpd rpcd uci iwinfo iw wpad-openssl \
             ca-bundle ca-certificates coreutils uclient-fetch curl jq \
             alsa-utils avahi-daemon

echo "[Sovereign] unpacking overlay to / ..."
tar -xzf /tmp/sovereign-overlay.tar.gz -C /

# permissions (ignore errors if files absent)
chmod +x /etc/init.d/sovereignd 2>/dev/null || true
chmod +x /etc/uci-defaults/98-sovereign-ssid 2>/dev/null || true
chmod +x /etc/uci-defaults/99-sovereign-enable-services 2>/dev/null || true

# apply defaults & enable services
[ -x /etc/uci-defaults/98-sovereign-ssid ] && /etc/uci-defaults/98-sovereign-ssid || true
[ -x /etc/uci-defaults/99-sovereign-enable-services ] && /etc/uci-defaults/99-sovereign-enable-services || true
/etc/init.d/sovereignd enable 2>/dev/null || true
/etc/init.d/sovereignd restart 2>/dev/null || true
/etc/init.d/uhttpd restart 2>/dev/null || true
wifi reload 2>/dev/null || true

echo "[Sovereign] done. Visit LuCI → Sovereign → Overview → Open Dashboard."
