---
layout: post
category: linux
title: "easy backup restore"
---

## 概要

簡単なバックアップ・リストアの手順。`tar` の J(圧縮)・v(詳細表示)・c(作成)・x(展開)・f(ファイル指定)オプションを利用する。

## backup

```sh
#!/usr/bin/env bash

dest='/samba/share/backup.xz'
sudo tar Jvcf "${dest}" /work /root/.ssh /home/*/.ssh /var/spool/cron
```

## restore

```sh
#!/usr/bin/env bash

exit
# exit は誤実行防止用。確認後、この行をコメントアウトしてから実行する。
# sudo tar xJvf ... -C / は全ファイルを展開するため注意。
target='/samba/share/backup.xz'
ls "${target}" && sudo tar xJvf "${target}" -C /
```

