---
layout: post
category: linux
---

Relax-and-Recoverを用いて、サーババックアップ・リストアをする。

# 何ができるか？

- 構築したLinux環境のバックアップ、リストア
    - ディザスタリカバリ
- 削除したファイルの復元
- リラックス

# 想定環境

- バックアップ・リストア対象サーバ(192.168.100.1)
    - Relax-and-Recoverをインストール
- バックアップ保管用NFSサーバ(192.168.100.2)
    - 公開ディレクトリは/nfs
    - 192.168.100.0/24からのアクセスを許可

# Install NFS Server :2

NFSサーバを構築する。

```sh
dnf -y update
dnf -y install nfs-utils firewalld

nfs_dir=/nfs
mkdir -p ${nfs_dir}
echo "${nfs_dir} 192.168.100.0/24(rw,no_root_squash)" > /etc/exports
#echo "${nfs_dir} *(rw,no_root_squash)" > /etc/exports
exportfs -ra
systemctl enable --now rpcbind nfs-server firewalld
firewall-cmd --add-service=nfs --permanent
firewall-cmd --reload
```

# Install Relax-and-Recover :1

```sh
dnf -y update
dnf -y install rear grub2-efi-x64-modules

# EFIの場合追加でインストール(for grub2-mkstandalone command)
dnf -y install grub2-tools-extra
```

## Relax-and-Recover Config File

```sh
cp /etc/rear/local.conf /etc/rear/local.conf.bak
cat <<'EOF' > /etc/rear/local.conf
OUTPUT=ISO
BACKUP=NETFS
BACKUP_URL="nfs://192.168.100.2/nfs/"

BACKUP_PROG_EXCLUDE=("${BACKUP_PROG_EXCLUDE[@]}" '/media' '/vat/tmp' '/var/crash' '/kdump')
LOGFILE="$LOG_DIR/rear-$HOSTNAME.log"
GRUB_RESCUE=1
EOF

# EFIの場合以下追加
echo 'USING_UEFI_BOOTLOADER=1' >> /etc/rear/local.conf
```

<dl>
  <dt>OUTPUT</dt>
  <dd>レスキューシステムの出力形式</dd>
  <dt>BACKUP</dt>
  <dd>tarアーカイブの作成に使用できるバックアップ方式</dd>
  <dt>BACKUP_URL</dt>
  <dd>tar.gzのバックアップファイルの出力先</dd>
</dl>

/media、/vat/tmp、/var/crash、/kdumpは、バックアップ対象から外す。

# Backup :1

```sh
rear -v mkbackup
```

# Restore

1. レスキューシステムを取り出す(ISOファイル、DVD、USBとして書き出す) 。
1. レスキューシステムより、ブートする。
1. "Recover _hostname_"を選択する。
1. ログインプロンプトが出たら、rootと入力する。

```sh
# DHCPがあるネットワークであれば不要(IPアドレスが取得できていれば不要)
ip a
ip addr add 192.168.100.100/24 dev <network interface>
```

```sh
# リストアを進める。
rear recover
# rootのプロンプトにて
reboot
```

リストア時、BACKUP_URLのバックアップファイルの場所を自動で探すため、NFSサーバに到達できる場所でリストアを行う。自動でNFSマウントして、情報をダウンロード、展開してくれる。

本稿の例の場所にバックアップファイルを出力していない場合は、BACKUP_URLと同じ場所にマウントして、からrear recoverコマンドを打鍵する必要がある。file:///backupの場合は、/backupにマウントする。推奨しないため、詳細の例は省略する。

### その他

レスキューシステムのISOファイルが4GBを超える場合、ISOファイルは出力されるものの、リストア時のブートができない。そのため、レスキューシステムとバックアップファイルは別々のファイルで出力するのが現実的である(BACKUP_URLにiso://を指定しない)。

rear mkbackupは、rear mkrescue + rear mkbackuponlyの打鍵を意味する。レスキューシステムか、バックアップファイルを出力する場合は個別に打鍵する。

##### rear mkrescue

バックアップをRear-and-Recover以外で行う場合は、rear mkresuceを使用するシーンが考えられる。Relax-and-Recoveryの使用する意義が薄れるため、mkrescue単独の使用は、考えにくい。

ストレージレイアウトが変更された場合は、rear mkrescueにて、レスキューシステムの再作成が必要となる。

##### rear checklayout

不要なレスキューシステムを再作成しないためのコマンド。最後にレスキューシステムが作成されてからストレージレイアウトに変更がないことのみを保証するが、全てのリターンコードを鵜呑みにはできない。

##### rear mkbackuponly

backup.tar.gzの出力を行う。backup.tar.gzには、/boot、/etc、/usr..などのファイルのバックアップが含まれる。

#### 定期バックアップ

```sh
echo '0 4 * * * root rear mkbackup' >> /etc/crontab
```

#### NFSを使わないローカルバックアップ

注意として、リストア時`/backup`などのデバイスがリストアされないようにする必要がある。詳細（マウント関連が、バックアップ、リストア対象になるかどうか）は未検証。

```sh
cat <<'EOF' > /etc/rear/local.conf
OUTPUT=ISO
OUTPUT_URL=file:///backup
BACKUP=NETFS
BACKUP_URL=file:///backup

BACKUP_PROG_EXCLUDE=("${BACKUP_PROG_EXCLUDE[@]}" '/media' '/vat/tmp' '/var/crash' '/kdump' '/backup')
LOGFILE="$LOG_DIR/rear-$HOSTNAME.log"
GRUB_RESCUE=1
EOF
```

レスキューシステムにバックアップファイルを含める場合：出力ISOファイルが、4GBを超えるとブートできない可能性があるため、以下の方法は、使用しない。

```sh
cat <<'EOF' > /etc/rear/local.conf
OUTPUT=ISO
OUTPUT_URL=file:///backup
BACKUP=NETFS
BACKUP_URL=iso:///backup

BACKUP_PROG_EXCLUDE=("${BACKUP_PROG_EXCLUDE[@]}" '/media' '/vat/tmp' '/var/crash' '/kdump')
LOGFILE="$LOG_DIR/rear-$HOSTNAME.log"
GRUB_RESCUE=1
EOF
```

#### バックアップ時の一時領域変更方法

実行時に以下のようにTMPDIRを指定する。/etc/rear/local.confに記載しても可能。

```sh
TMPDIR="/tmp/myrear/dir" rear -v mkbackup
```

### エラー出力

```
ERROR: Cannot setup GRUB_RESCUE: Not enough disk space in /boot for Relax-and-Recover rescue system. Required:
```

対処：/etc/rear/local.confのGRUB_RESCUEに値を入れない（が、あったほうがいいと思う。デフォルト構成では、エラーは出ない）。

```
GRUB_RESCUE=
```

# Environment

```
[root@localhost ~]# cat /etc/redhat-release
Rocky Linux release 9.2 (Blue Onyx)
[root@localhost ~]# 
```

```
[root@localhost ~]# rear --version
Relax-and-Recover 2.6 / 2020-06-17
[root@localhost ~]# 
```

# Reference

- [Relax-and-Recover](https://relax-and-recover.org/)
