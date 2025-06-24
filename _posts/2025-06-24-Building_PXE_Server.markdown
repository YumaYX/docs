---
layout: post
category: linux
---

## **PXE Boot Server Setup**

This configuration automates the setup of a **PXE boot server** on a Linux system using shell scripting. The setup includes installing and configuring **TFTP**, **DHCP**, **HTTP**, and **firewalld** services, and prepares bootable installation media for automated OS deployment.

After running this configuration, client machines on the same network can boot via PXE and automatically install AlmaLinux using the provided Kickstart file—ideal for bulk deployments or automated lab setups.

---

## Environment

- Network
  - 172.17.64.0/24
- DHCP Range
  - 172.17.64.200-250
- PXE Server
  - 172.17.64.2
- Distribution
  - AlmaLinux/9.6

---

## Commands (Shell)

```sh
#!/bin/bash
set -e

PXE_NETWORK="172.17.64."
PXE_HOST="2"
PXE_IP="${PXE_NETWORK}${PXE_HOST}"

echo "[*] Installing packages..."
dnf install -y tftp-server firewalld dhcp-server httpd

echo "[*] Enabling and starting services..."
systemctl enable --now tftp
systemctl enable --now firewalld
systemctl enable --now httpd

echo "[*] Configuring firewalld..."
firewall-cmd --add-service=tftp --permanent
firewall-cmd --add-service=dhcp --permanent
firewall-cmd --add-service=http --permanent
firewall-cmd --reload

echo "[*] Setting up TFTP boot files..."
mkdir -p /tmp/rpm
dnf -y reinstall --downloadonly --downloaddir=/tmp/rpm shim grub2-efi-x64

cd /tmp/rpm
rpm2cpio shim-x64-*.rpm | cpio -dimv
rpm2cpio grub2-efi-x64-*.rpm | cpio -dimv

cp -f /tmp/rpm/boot/efi/EFI/BOOT/BOOTX64.EFI /var/lib/tftpboot/BOOTX64.EFI
chmod 644 /var/lib/tftpboot/BOOTX64.EFI

cp -f /tmp/rpm/boot/efi/EFI/almalinux/grubx64.efi /var/lib/tftpboot/grubx64.efi
chmod 644 /var/lib/tftpboot/grubx64.efi

echo "[*] Downloading AlmaLinux ISO..."
curl -L -o /tmp/linux9.iso https://ftp.riken.jp/Linux/almalinux/9.6/isos/x86_64/AlmaLinux-9-latest-x86_64-minimal.iso

mkdir -p /var/pxe/linux9
mount -o loop,ro /tmp/linux9.iso /var/pxe/linux9

mkdir -p /var/lib/tftpboot/linux9
cp -f /var/pxe/linux9/images/pxeboot/vmlinuz /var/lib/tftpboot/linux9/
cp -f /var/pxe/linux9/images/pxeboot/initrd.img /var/lib/tftpboot/linux9/

echo "[*] Writing DHCP config..."
cat <<EOF > /etc/dhcp/dhcpd.conf
default-lease-time 600;
max-lease-time 7200;
authoritative;

option space pxelinux;
option pxelinux.magic code 208 = string;
option pxelinux.configfile code 209 = text;
option pxelinux.pathprefix code 210 = text;
option pxelinux.reboottime code 211 = unsigned integer 32;
option architecture-type code 93 = unsigned integer 16;

subnet ${PXE_NETWORK}0 netmask 255.255.255.0 {
  range dynamic-bootp ${PXE_NETWORK}200 ${PXE_NETWORK}250;
  option broadcast-address ${PXE_NETWORK}255;
  option routers ${PXE_IP};
  class "pxeclients" {
    match if substring (option vendor-class-identifier, 0, 9) = "PXEClient";
    next-server ${PXE_IP};
    if option architecture-type = 00:07 {
      filename "BOOTX64.EFI";
    }
  }
}
EOF

echo "[*] Writing grub.cfg..."
cat <<EOF > /var/lib/tftpboot/grub.cfg
set timeout=1
menuentry "Install linux9" {
  linuxefi linux9/vmlinuz ip=dhcp inst.ks=http://${PXE_IP}/ks/ks.cfg
  initrdefi linux9/initrd.img
}
EOF

echo "[*] Configuring HTTP access..."
cat <<EOF > /etc/httpd/conf.d/pxeboot.conf
Alias /linux9 /var/pxe/linux9
<Directory /var/pxe/linux9>
  Options Indexes FollowSymLinks
  Require all granted
</Directory>
EOF

mkdir -p /var/www/html/ks

echo "[*] Writing ks.cfg..."
cat <<EOF > /var/www/html/ks/ks.cfg
text
reboot
url --url=http://${PXE_IP}/linux9/

keyboard --vckeymap=jp106 --xlayouts='jp','us'
lang en_US.UTF-8

network --bootproto=dhcp --ipv6=auto --activate --hostname=localhost
zerombr

%packages
@core
%end

ignoredisk --only-use=sda
autopart
clearpart --all --initlabel

timezone Asia/Tokyo --utc
rootpw --iscrypted --allow-ssh \$6\$fy2QCRgOe4DdZvKA\$Hu/L0AthQHy822kMTlUzs1FXSrvhWkcy/SMrbrh35EPoM.r.JG9C8aL0Tqdr0Az/sFsC4a6WC2Mfv1W1NDMpD1
EOF

echo "[*] Reloading services..."
firewall-cmd --reload
systemctl enable --now dhcpd
systemctl daemon-reexec
systemctl restart httpd dhcpd tftp firewalld

echo "[✓] PXE boot server setup completed successfully!"
```

## How to Run the Script

1. Save the script as build_pxe.sh.

2. Make it executable:
  ```sh
  chmod +x build_pxe.sh
  ```

3. Run the script with root privileges:
  ```sh
  sudo ./build_pxe.sh
  ```

