---
layout: post
category: commands
title: fallocate
---

1Gのダミーファイルを作る。

`fallocate` は実際にデータを書き込まず、領域を割り当てるだけのため高速。
`dd` と違い I/O を発生させないので、ダミーファイル作成用途に適する。

```sh
fallocate -l 1G /mnt/dummy
```
