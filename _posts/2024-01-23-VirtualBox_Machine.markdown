---
layout: post
title: "VirtualBox Machine"
category: vmachine
---

VirtualBoxを使用して新しい仮想マシン（VM）を作成し、AlmaLinux 9.2をインストールするための設定を行うもの。

```sh
vmname="linux"
dvd="${HOME}/Desktop/AlmaLinux-9.2-x86_64-dvd.iso"
dir="${HOME}/VirtualBox VMs/${vmname}"

cpu=4
mem=2048
disk=$(( 1024 * 15 ))


VBoxManage createvm --name ${vmname} --ostype RedHat_64 --register
VBoxManage modifyvm ${vmname} --cpus ${cpu}
cpuexecutioncap=100
VBoxManage modifyvm ${vmname} --cpuexecutioncap ${cpuexecutioncap}
VBoxManage modifyvm ${vmname} --memory ${mem}
VBoxManage modifyvm ${vmname} --vram 64
VBoxManage modifyvm ${vmname} --graphicscontroller vmsvga

# network
VBoxManage modifyvm ${vmname} --nic1 nat 
VBoxManage modifyvm ${vmname} --nic2 hostonly --hostonlyadapter2 "VirtualBox Host-Only Ethernet Adapter"

# storage
# controller
VBoxManage storagectl ${vmname} --name SATA --add sata --controller IntelAHCI

# disk
VBoxManage closemedium disk "${dir}/${vmname}.vdi" --delete
VBoxManage createmedium disk --filename "${dir}/${vmname}.vdi" --size ${disk} --format VDI
# attach
VBoxManage storageattach ${vmname} --storagectl SATA --port 0 --type hdd --medium "${dir}/${vmname}.vdi"

# controller
VBoxManage storagectl ${vmname} --name IDE --add ide --controller PIIX4 --hostiocache on
# mount
VBoxManage storageattach ${vmname} --storagectl IDE --port 0 --device 0 --type dvddrive --medium "${dvd}"

# run
VBoxManage startvm ${vmname}
```

1. **変数の設定:**
   - `vmname`: 仮想マシンの名前（linux）。
   - `dvd`: AlmaLinux 9.2のISOイメージのパス。
   - `dir`: 仮想マシンの設定やディスクの保存先のディレクトリ。

2. **VMの基本設定:**
   - `VBoxManage createvm`: 仮想マシンを作成し、RedHat_64として登録。
   - `VBoxManage modifyvm`: 仮想マシンのCPU数、メモリ、VRAM、グラフィックスコントローラなどの設定。

3. **ネットワーク設定:**
   - 1つ目のNIC（Network Interface Controller）はNATモード。
   - 2つ目のNICはHost-Onlyモードで、"VirtualBox Host-Only Ethernet Adapter"を使用。

4. **ストレージ設定:**
   - `VBoxManage storagectl`: SATAコントローラを作成。
   - `VBoxManage closemedium`: 既存のVDIファイルを削除。
   - `VBoxManage createmedium`: VDI形式の仮想ディスクを作成。
   - `VBoxManage storageattach`: 作成した仮想ディスクを仮想マシンにアタッチ。
   - `VBoxManage storagectl`: IDEコントローラを作成。
   - `VBoxManage storageattach`: DVDドライブにAlmaLinuxのISOイメージをアタッチ。

5. **仮想マシンの起動:**
   - `VBoxManage startvm`: 仮想マシンを起動。
