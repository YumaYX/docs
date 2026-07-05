---
layout: post
category: linux
title: dnf-disable
---

コマンドでdisabledできる。

```sh
sudo dnf config-manager --set-disabled crb
sudo dnf config-manager --set-disabled extras
```

`--set-enabled`を使えば、enabledもできる。
