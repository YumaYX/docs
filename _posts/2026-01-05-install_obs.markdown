---
layout: post
category: linux
title: "install obs"
---

```sh
sudo dnf install flatpak -y && \
sudo flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo && \
sudo flatpak install flathub com.obsproject.Studio -y && \
flatpak run com.obsproject.Studio
```
