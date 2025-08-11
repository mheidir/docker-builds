#!/bin/bash

/etc/init.d/mmupdater start
/etc/init.d/mmremote start
/usr/sbin/named -g -c /etc/bind/named.conf -u bind
