#!/bin/bash

/etc/init.d/mmws start
/etc/init.d/mmupdater start
/etc/init.d/mmcentral start
apache2ctl -DFOREGROUND
