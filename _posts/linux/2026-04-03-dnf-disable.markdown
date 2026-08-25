---
layout: post
category: linux
title: dnf-disable
---

## 概要

リポジトリをコマンドで無効化できる。`--set-enabled` を使えば、有効化もできる。

```sh
sudo dnf config-manager --set-disabled crb
sudo dnf config-manager --set-disabled extras
```

`dnf config-manager --set-disabled` でリポジトリを無効化、`--set-enabled` で有効化する。
