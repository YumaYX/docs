---
layout: post
category: linux
title: "install obs"
---

## 概要

OBS Studio を Flatpak 経由でインストールして起動する手順。Flathub リポジトリを追加し、`com.obsproject.Studio` パッケージを導入する。

```sh
sudo dnf install flatpak -y && \
sudo flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo && \
sudo flatpak install flathub com.obsproject.Studio -y && \
flatpak run com.obsproject.Studio
```
