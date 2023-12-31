---
layout: post
category: shell
title: CPU,Memory
---

## CPU とメモリ

`grep MemTotal /proc/meminfo` で物理メモリ総量を、`lscpu | grep -i "model n"` で CPU のモデル名を表示する。

```sh
grep MemTotal /proc/meminfo
lscpu | grep -i "model n"
```

