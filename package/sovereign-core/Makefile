include $(TOPDIR)/rules.mk
PKG_NAME:=sovereign-core
PKG_RELEASE:=6
PKG_VERSION:=0.2.2
include $(INCLUDE_DIR)/package.mk
define Package/sovereign-core
  SECTION:=utils
  CATEGORY:=Utilities
  TITLE:=Sovereign OS core services & UI
  DEPENDS:=+ubus +ubusd +uhttpd +luci-lib-jsonc +lua +curl +iwinfo +iw +ip-full +coreutils +alsa-utils
endef
define Package/sovereign-core/install
	$(INSTALL_DIR) $(1)/etc/init.d
	$(INSTALL_BIN) ./files/etc/init.d/sovereignd $(1)/etc/init.d/sovereignd
	$(INSTALL_DIR) $(1)/usr/sbin
	$(INSTALL_BIN) ./files/usr/sbin/sovereignd $(1)/usr/sbin/sovereignd
	$(INSTALL_BIN) ./files/usr/sbin/wellness-night-mode.sh $(1)/usr/sbin/wellness-night-mode.sh
	$(INSTALL_BIN) ./files/usr/sbin/txpower-auto.sh $(1)/usr/sbin/txpower-auto.sh
	$(INSTALL_BIN) ./files/usr/sbin/plc-toggle.sh $(1)/usr/sbin/plc-toggle.sh
	$(INSTALL_BIN) ./files/usr/sbin/sovereign-sound.sh $(1)/usr/sbin/sovereign-sound.sh
	$(INSTALL_DIR) $(1)/etc/config
	$(INSTALL_CONF) ./files/etc/config/sovereign $(1)/etc/config/sovereign
	$(INSTALL_DIR) $(1)/etc/uci-defaults
	$(INSTALL_BIN) ../../files/etc/uci-defaults/98-sovereign-ssid $(1)/etc/uci-defaults/98-sovereign-ssid
	$(INSTALL_BIN) ../../files/etc/uci-defaults/99-sovereign-enable-services $(1)/etc/uci-defaults/99-sovereign-enable-services
	$(INSTALL_DIR) $(1)/usr/share/sovereign/sounds
	$(INSTALL_DATA) ../../files/sounds/*.wav $(1)/usr/share/sovereign/sounds/
	$(INSTALL_DIR) $(1)/etc/sovereign
	$(INSTALL_DATA) ./files/etc/sovereign/branding.json $(1)/etc/sovereign/branding.json
	$(INSTALL_DIR) $(1)/www/sovereign-ui
	$(CP) ../../files/www/sovereign-ui/* $(1)/www/sovereign-ui/
	$(INSTALL_DIR) $(1)/www/branding
	$(INSTALL_DATA) ../../files/www/branding/* $(1)/www/branding/
endef
$(eval $(call BuildPackage,sovereign-core))
