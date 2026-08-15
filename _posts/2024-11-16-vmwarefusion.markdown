---
layout: post
category: virtualmachine
title: vmwarefusion
---

Apple Silicon Mac で仮想マシンを実行するための環境構築。

- rosetta: Intel 向けバイナリを Apple Silicon で実行するための変換レイヤ
- vmware fusion: 仮想マシンを実行するためのハイパーバイザー
- vagrant: 仮想マシンをコードで管理するツール

```sh
/usr/sbin/softwareupdate --install-rosetta --agree-to-license
brew install --cask vmware-fusion
brew install --cask vagrant-vmware-utility
brew install vagrant
vagrant plugin install vagrant-vmware-desktop
```

## 参考リンク

[Vagrant and VMWare Fusion 13 on Apple M1 Pro · GitHub](https://gist.github.com/sbailliez/2305d831ebcf56094fd432a8717bed93)