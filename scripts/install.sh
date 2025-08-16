#!/bin/sh
set -e

echo "[Sovereign] setting BE3600 feeds (QSDK v12.5)..."
cp /etc/opkg/distfeeds.conf /etc/opkg/distfeeds.conf.bak 2>/dev/null || true
cat > /etc/opkg/distfeeds.conf <<'EOF'
src/gz glinet_core     https://fw.gl-inet.com/releases/qsdk_v12.5/kmod-4.7/be3600-ipq53xx
src/gz glinet_gli_pub  https://fw.gl-inet.com/releases/qsdk_v12.5/packages-4.x/ipq53xx/be9300/glinet
src/gz opnwrt_packages https://fw.gl-inet.com/releases/qsdk_v12.5/packages-4.x/ipq53xx/be9300/packages
EOF

echo "[Sovereign] opkg update (will continue if this fails)..."
opkg update || echo "[Sovereign][warn] opkg update failed; continuing with overlay only."

echo "[Sovereign] installing base packages (best effort)..."
opkg install luci luci-ssl uhttpd rpcd uci iwinfo iw wpad-openssl \
             ca-bundle ca-certificates coreutils uclient-fetch curl jq \
             alsa-utils avahi-daemon || echo "[Sovereign][warn] opkg install step had errors; continuing."

echo "[Sovereign] unpacking overlay to / ..."
tar -xzf /tmp/sovereign-overlay.tar.gz -C /

# Ensure permissions (ignore if missing)
for f in /etc/init.d/sovereignd /etc/uci-defaults/98-sovereign-ssid /etc/uci-defaults/99-sovereign-enable-services; do
  [ -f "$f" ] && chmod +x "$f" || true
done

# Apply defaults + enable services
[ -x /etc/uci-defaults/98-sovereign-ssid ] && /etc/uci-defaults/98-sovereign-ssid || true
[ -x /etc/uci-defaults/99-sovereign-enable-services ] && /etc/uci-defaults/99-sovereign-enable-services || true
/etc/init.d/sovereignd enable 2>/dev/null || true
/etc/init.d/sovereignd restart 2>/dev/null || true
/etc/init.d/uhttpd restart 2>/dev/null || true
wifi reload 2>/dev/null || true

echo "[Sovereign] done. LuCI → Sovereign → Overview → Open Dashboard."
