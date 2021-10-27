#!/usr/bin/env bash


# enable extension local (probably via config file):
mopidy --config /opt/mopidy/configs/mopidy.conf local scan
/opt/mopidy/bin/mopidy --config /opt/mopidy/configs/mopidy.conf
