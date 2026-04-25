---
layout: post
category: virtualmachine
---

run virtual machine on apple Silicon mac

- macOS(Apple Silicon)
  - rosetta
- vmware fusion
- vagrant

```sh
/usr/sbin/softwareupdate --install-rosetta --agree-to-license
brew install --cask vmware-fusion
brew install --cask vagrant-vmware-utility
brew install vagrant
vagrant plugin install vagrant-vmware-desktop
```

# ref.

[Vagrant and VMWare Fusion 13 on Apple M1 Pro · GitHub](https://gist.github.com/sbailliez/2305d831ebcf56094fd432a8717bed93)