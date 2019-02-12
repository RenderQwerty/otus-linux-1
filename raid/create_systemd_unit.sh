#!/bin/bash

mv /tmp/raid.mount /etc/systemd/system/
systemctl enable raid.mount && systemctl start raid.mount
