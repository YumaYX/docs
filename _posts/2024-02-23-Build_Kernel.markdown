---
layout: post
category: linux
---

カーネルのビルド、インストールをしてみる。

# Ref.

- <https://qiita.com/furandon_pig/items/b197571ee91a6dd573e5>
- <https://cdn.kernel.org/>


# 必要なパッケージインストール

```sh
dnf install -y ncurses-devel dracut grub2 bc
LANG=C dnf -y group install "Development Tools"
```

# カーネルソースの準備

```sh
cd
curl -sLO https://cdn.kernel.org/pub/linux/kernel/v6.x/linux-6.7.6.tar.xz
tar Jvxf linux-6.7.6.tar.xz -C /usr/src
cd /usr/src/linux-6.7.6
#make defconfig

cp -v /boot/config... .config

sed -i 's@^CONFIG_SYSTEM_TRUSTED_KEYS="certs/rhel.pem"@CONFIG_SYSTEM_TRUSTED_KEYS=""@g' .config
sed -i 's@^CONFIG_DEBUG_INFO_BTF=y@CONFIG_DEBUG_INFO_BTF=n@g' .config
```

### make menuconfig

```
cd /usr/src/linux-6.7.6
make menuconfig
```

# カーネルビルド

```sh
# build
time make -j $(nproc); echo ${?}
```

```sh
# install
# dracutコマンド実行時のみ、「6.7.6」と指定する点に注意。
cd /usr/src/linux-6.7.6
make modules_install; echo ${?}

cp -f arch/x86_64/boot/bzImage /boot/vmlinuz-6.7.x86_64
dracut --force /boot/initramfs-6.7.x86_64.img 6.7.6
# (第二引数が多分uname -rの出力結果)
```

## dracut

> dracutはカーネルによって使用される初期イメージを生成し、ルートファイルシステムにアクセスするのに必要なブロックデバイスモジュール (IDE、SCSI、RAID など) をプリロードします。

- <https://wiki.archlinux.jp/index.php/Dracut>

# grub.cfgの更新
```sh
# BIOS環境の場合
cp -pv /boot/grub2/grub.cfg ~/grub.cfg.bak
grub2-mkconfig -o /boot/grub2/grub.cfg
# EFI環境の場合
cp -pv /boot/efi/EFI/almalinux/grub.cfg ~/grub.cfg.efi.bak
grub2-mkconfig -o /boot/efi/EFI/almalinux/grub.cfg

# grubへのエントリ追加
grubby --add-kernel=/boot/vmlinuz-6.7.x86_64 --title 'AlmaLinux 9(6.7.6.x86_64)';echo ${?}
# 追加したエントリを起動時に自動選択設定
grub2-set-default 1
# 0:一行目、1:２ぎょうめ、つまり、一個しかない場合は、1を選択

#または、boot時に
grubby --default-kernel
```

# その他設定

```sh
for f in $(ls -1 /boot/loader/entries/*.conf); do echo $f; grep options ${f}; done

sed -i 's/^options/options $kernelopts $tuned_params/g' /boot/loader/entries/5de5d51b138a43fe9a9729b711cc6dc7-6.7.x86_64.conf
```

# 結果

## before

```
[root@localhost ~]# uname -r
5.14.0-362.8.1.el9_3.x86_64
[root@localhost ~]# 
```

## after

```
[root@localhost ~]# uname -r
6.7.6
[root@localhost ~]# 
```

# Env.

```
AlmaLinux release 9.3 (Shamrock Pampas Cat)
```
