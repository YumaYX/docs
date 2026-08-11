---
layout: post
category: mac
title: "install_docker"
---


## how to install docker with brew on mac

```sh
brew install docker-desktop
```

## run almalinux 9

```sh
docker run -ti --platform linux/arm64/v8 -v ./work:/work almalinux:9 /bin/bash
```

10はdnf updateでエラーが出て、使えない。

