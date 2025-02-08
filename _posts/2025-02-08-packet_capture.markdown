---
layout: post
category: linux
---

`tcpdump` および `wireshark` をインストールするコマンド

```sh
dnf -y install tcpdump
dnf -y install wireshark
```

指定したネットワークインターフェースでパケットをキャプチャして、dump.pcap というファイルに保存するコマンド

```sh
tcpdump -i wlp2s0 -w dump.pcap
```

パケットキャプチャが dump.pcap に保存され、ファイルサイズが 1MB に達するごとに新しいファイルにローテーション

```sh
tcpdump -i wlp2s0 -w dump.pcap -Z root -C 1
# => rotate by 1MB

#chown user. dump.pcap
```

# ファイルサイズ指定分割

指定したサイズ(KB)でファイルを分割

```sh
tshark \
-r dump.pcap \
-w output.pcap \
-b filesize:10
```

# パケット数指定分割

```sh
editcap dump.pcap output -c 100
```

- ファイル分割します
- 分割単位は1ファイル100パケット

# 時間指定抽出

```sh
tshark \
-r dump.pcap \
-Y "frame.time >= \"2025-02-08 12:30:00\" && frame.time <=\"2025-02-08 12:30:59\"" \
-w filtered.pcap
```

```sh
editcap dump.pcap extract.pcap \
-A "2025-02-08 12:52:00" \
-B "2025-02-08 12:52:59"
```

---

# pcap to csv

```sh
tshark -r dump.pcap \
-n \
-T fields -E quote=d -E separator=, -E header=y -e frame.number -e frame.time_relative -e ip.src -e ip.dst -e _ws.col.Protocol -e frame.len  -e _ws.col.Info \
-e ipv6.dst \
> dump.csv
```

```sh
tshark -r dump.pcap -T fields -E header=y -E separator=, -E quote=d \
-e frame.time -e eth.src -e eth.dst -e ip.src -e ip.dst -e ipv6.src -e ipv6.dst \
-e tcp.srcport -e tcp.dstport -e udp.srcport -e udp.dstport > output.csv
```

- `_ws.col.Source`,`_ws.col.Destination`は、カラムを表示させたい場合のフィルタ

```sh
tshark -h
```