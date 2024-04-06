---
layout: post
category: linux
---

# Install Homebrew on RHEL

# as root

```sh
dnf -y groupinstall 'Development Tools'
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

. ~/.bash_profile
brew update

# Rubyを使用するユーザの作成
user=ruby
useradd -m $user
chown -R $user /home/linuxbrew/.linuxbrew

sudo su - $user
```

## as user

```sh
. ~/.bash_profile
# echo 'eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"' >> /root/.bash_profile
eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
brew doctor
```

# Install Home brew on Apple Silicon Mac

```sh
xcode-select --install

/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

# echo 'eval $(/opt/homebrew/bin/brew shellenv)' >> ${HOME}/.zshrc
eval $(/opt/homebrew/bin/brew shellenv)

brew doctor
```
