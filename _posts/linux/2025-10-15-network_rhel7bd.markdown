---
layout: post
category: linux
title: network_rhel7bd
---

### RHELベース7系のコマンド記録

参考として。

RHEL 系 7 で固定 IP を設定する手順。`ifcfg-eth2` に IP アドレス等を記載し、`ifdown`/`ifup` や `network` 再起動で反映する。`echo ${?}` で各コマンドの終了ステータスを確認している。

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

