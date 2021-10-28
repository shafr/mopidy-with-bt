#!/usr/bin/env bash


# enable extension local (probably via config file):
mopidy --config=/opt/mopidy/configs/mopidy.conf local scan
/opt/mopidy/bin/mopidy --config /opt/mopidy/configs/mopidy.conf &

echo "power off" | bluetoothctl
echo "power on" | bluetoothctl
export USB_DONGLE_MAC_ADDRESS="2C:10:3C:04:B0:40"