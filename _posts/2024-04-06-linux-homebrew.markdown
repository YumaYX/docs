
---
layout: post
category: linux
title: "Install_homebrew2"
---

- 勉強にならないから避けていたHomebrew@Linux
- 前記事の改良版(2026-01-23記載)

## Linux版の操作条件

- 更新やパッケージ操作は必ず linuxbrew ユーザーにて行う。
- 全員が既存パッケージを使えますが、インストールや更新は linuxbrew ユーザーでのみ行うのが安全
  - root書き込みを行うと、新規ファイルの所有者が、rootになる。他ユーザーでも同じ。brewを共有できなくなる。
  - linuxbrewのフォルダを全ユーザーに共有しておくのが、ベスト（らしい）

# インストール手順

rootで実行する。

```sh
# common packages
sudo dnf -y group install 'Development Tools'
sudo dnf -y install procps-ng curl file

sudo su - linuxbrew -c '/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"'

sudo chmod 757    /home/linuxbrew
sudo chmod 757 -R /home/linuxbrew/.linuxbrew


# linuxbrew user profile
cat <<'EOF' >> /home/linuxbrew/.bashrc
test -d ~/.linuxbrew && eval "$(~/.linuxbrew/bin/brew shellenv)"
EOF

chown linuxbrew:linuxbrew /home/linuxbrew/.bashrc
```

### general user profile

一般ユーザーのファイルに何書く？
以下は追加なので、一回だけ打鍵する。

```sh
cat <<'EOF' >> ~/.bashrc
test -d /home/linuxbrew/.linuxbrew && eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
EOF

source .bashrc 
```
