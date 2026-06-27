---
layout: post
category: linux
title: "logrotate"
---

## command

force execution

```sh
logrotate -f /etc/logrotate.conf
```

debug mode

```sh
logrotate -d /etc/logrotate.conf
```


## pattern

- example: `/var/log/messages`


1 シンプルな世代ローテート

```sh
sudo cat > /etc/logrotate2.conf <<'EOF'
/var/log/messages {
    rotate 7
    create 0640 root root
}
EOF

logrotate -f /etc/logrotate2.conf; ls -1 /var/log/messages*
# => /var/log/messages.1から7まで作られる。
```

2 日時をファイルに付ける。

```sh
sudo cat > /etc/logrotate2.conf <<'EOF'
/var/log/messages {
    rotate 7
    create 0640 root root


    dateext
    dateformat -%Y%m%d-%H%M%S
}
EOF

logrotate -f /etc/logrotate2.conf; ls -1 /var/log/messages*
# => /var/log/messages-HHMMSSで作られる。
```

3 別フォルダにアーカイブしたい。

```sh
mkdir -p /var/log/archive

sudo cat > /etc/logrotate2.conf <<'EOF'
/var/log/messages {
    rotate 7
    create 0640 root root


    olddir /var/log/archive
}
EOF

logrotate -f /etc/logrotate2.conf; ls -1 /var/log/archive/messages*
# => /var/log/archive/messages.1-7が作られる。
```

4 回転？

```sh
sudo cat > /etc/logrotate2.conf <<'EOF'
/var/log/a {
    rotate 7
    create 0640 root root
}
EOF

for f in $(seq 7)
do
  echo $f > /var/log/a
  logrotate -f /etc/logrotate2.conf
done
# => ファイル名がリネームされている：回転している。
```

```
[root@localhost ~]# head /var/log/a.?
==> /var/log/a.1 <==
7

==> /var/log/a.2 <==
6

==> /var/log/a.3 <==
5

==> /var/log/a.4 <==
4

==> /var/log/a.5 <==
3

==> /var/log/a.6 <==
2

==> /var/log/a.7 <==
1
[root@localhost ~]#
```

