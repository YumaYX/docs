---
layout: post
category: linux
title: Install_Homebrew
---

# RHEL への Homebrew インストール

## root ユーザで実行

```sh
dnf -y groupinstall 'Development Tools'
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

. ~/.bash_profile
brew update

## Rubyを使用するユーザの作成
user=ruby
useradd -m $user
chown -R $user /home/linuxbrew/.linuxbrew

sudo su - $user
```

## 一般ユーザで実行

```sh
. ~/.bash_profile
## echo 'eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"' >> /root/.bash_profile
eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
brew doctor
```

# Apple Silicon Mac への Homebrew インストール

```sh
xcode-select --install

/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

## echo 'eval $(/opt/homebrew/bin/brew shellenv)' >> ${HOME}/.zshrc
eval $(/opt/homebrew/bin/brew shellenv)

brew doctor
```
