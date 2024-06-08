---
layout: post
category: linux
---

# 何ができるか？

- Logical Volume(マウントポイント)の領域拡張

## 環境条件

- Physical Volume、Volume Group、Logical Volumeが、ひとつのPhysical Deviceに存在すること
- Physical Deviceに未定義領域が存在すること

# 想定環境パラメータ

| items | value |
| --- | --- |
| Device | /dev/sda |
| Partition | 2 |
| Volume Group | almalinux |
| Logical Volume | var |

# Logical Volumeの拡張手順

## 環境把握

ディスクの状態を確認する。

```sh
df -h
lsblk
parted /dev/sda print free
```

未定義領域の大きさ(free  space)をこの時点で確認する。

## Physical Volumeの拡張

1. `parted`で、Physical Deviceを選択する。
1. リサイズするディスクパーティションを指定する。
    * 拡張後の大きさを指定する。
1. `quit` or `q`で、`parted`の対話を終了する。

```sh
parted /dev/sda
resizepart 2
```

パーティションを拡張する。大きさを指定しない場合、デフォルトで物理ボリューム (PV) のサイズをディスク全体のサイズに合わせて自動的に変更される。

```sh
pvs
pvresize /dev/sda2
pvs
```

## Logical Volumeの拡張

`lvresize`で、LVを拡張する。

```sh
lvs
lvresize -r -l+100%FREE /dev/almalinux/var
lvs
```

### lvresize

> `-r`:ファイルシステムのサイズも変更する

> `-l:`
> 論理ボリュームのサイズを論理エクステント（※3）の個数、または割合（「%VG」「%PVS」「%FREE」「%ORIGIN」）で指定する。追加／減少する量を指定する場合はサイズの頭に「+」「-」記号を付ける
> 　%VG　ボリュームグループ全体に対する比率
> 　%FREE　ボリュームグループの空き容量に対する比率
> 　%PVS　物理ボリュームに対する比率
> 　%ORIGIN　元の論理ボリュームの合計サイズ（スナップショット用）に対する比率

- <https://atmarkit.itmedia.co.jp/ait/articles/1910/31/news025.html>

## 拡張結果

拡張後の状態を確認する。

```sh
df -h
```

# Env.

```
AlmaLinux release 9.4 (Seafoam Ocelot)
```

# Ref.

- <https://qiita.com/TsutomuNakamura/items/93c6333c8dd32aeb197a>

---

# 付録

| items | example |
| --- | --- |
| mount point | /, /home, /var|
| Logical Volume | root, home, var |
| Volume Group | almalinux, rl |
| Physical Volume | /dev/sda3 |
| Physical Device | /dev/sda |

![LVM Hierarchy](https://www.redhat.com/sysadmin/sites/default/files/styles/full/public/2020-03/LVM%20Cropped.jpg?itok=wz2G1Aci)["LVM Hierarchy"](https://www.flickr.com/photos/91795203@N02/14127487464) by xmodulo
