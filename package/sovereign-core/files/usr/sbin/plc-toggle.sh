#!/bin/sh
case "$1" in
  on) uci set wireless.@wifi-device[0].disabled='1'; uci set wireless.@wifi-device[1].disabled='1'; uci commit wireless; wifi down ;;
  off) uci delete wireless.@wifi-device[0].disabled; uci delete wireless.@wifi-device[1].disabled; uci commit wireless; wifi up ;;
  *) echo "Usage: plc-toggle.sh on|off"; exit 1 ;;
esac
