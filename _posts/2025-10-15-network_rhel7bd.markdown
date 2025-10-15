---
layout: post
category: linux
---

## RHELベース7系のコマンド記録

参考として。

```sh
sudo su -

/etc/init.d/network restart

ls -l /etc/sysconfig/network-scripts/ifcfg-eth2

cat <<'EOF' > /etc/sysconfig/network-scripts/ifcfg-eth2
TYPE=Ethernet
DEVICE=eth2
NAME=eth2
BOOTPROTO=none
ONBOOT=yes

IPADDR=192.168.123.100
PREFIX=22
GATEWAY=192.168.123.254

EOF

ifdown eth2; echo ${?}
ip a
ifup eth2; echo ${?}
ip a

/etc/init.d/network restart
ip a
ip route
```

