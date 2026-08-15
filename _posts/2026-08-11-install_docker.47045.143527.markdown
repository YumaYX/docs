---
layout: post
category: mac
title: "install_docker"
---


## Mac で brew を使って docker をインストール

```sh
brew install docker-desktop
```

## AlmaLinux 9 を起動

```sh
docker run -ti --platform linux/arm64/v8 -v ./work:/work almalinux:9 /bin/bash
```

AlmaLinux 10 は dnf update でエラーが出て、使えない。

