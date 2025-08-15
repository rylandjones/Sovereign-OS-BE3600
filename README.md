# Sovereign-OS-BE3600
OpenWrt 23.05.x firmware build system for **GL.iNet GL-BE3600**.

**Defaults**
- SSID: `Sovereign Space`
- Password: `ownyourspace`
- Dark UI + branding; Home/Pro/EMF dashboards
- Wellness Mode; Adaptive TX + per-device overrides
- 802.11s mesh pairing; real-time security
- 1-year EMF timeline
- **Sovereign Sound** event cues (toggle + volume)

## Build with GitHub Actions
1. Push this repo to a private GitHub repository.
2. Actions → **Build Sovereign OS (GL-BE3600)** → **Run workflow**.
3. Artifact: `openwrt-ipq807x-generic-glinet_gl-be3600-squashfs-sysupgrade.bin`

## Flash
Upload the `sysupgrade.bin` in the GL UI, or SSH then `sysupgrade -n`.
