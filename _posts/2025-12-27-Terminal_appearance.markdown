---
layout: post
category: linux
title: "Terminal appearance"
---

# ターミナルごとのフォント設定のエクスポート

エクスポート：

```sh
dconf dump /org/gnome/terminal/ > gnome-terminal.conf
```

インポート：

```sh
dconf load /org/gnome/terminal/ < gnome-terminal.conf
```

