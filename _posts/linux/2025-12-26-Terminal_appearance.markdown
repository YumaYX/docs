---
layout: post
category: linux
title: "Terminal appearance"
---

# ターミナルごとのフォント設定のエクスポート

GNOME ターミナルの設定を `dconf` でファイルに書き出し(エクスポート)、別環境で読み込む(インポート)手順。`>` はリダイレクト、`<` はファイルからの入力。

エクスポート：

```sh
dconf dump /org/gnome/terminal/ > gnome-terminal.conf
```

インポート：

```sh
dconf load /org/gnome/terminal/ < gnome-terminal.conf
```

