---
layout: post
category: linux
---

```
11.6.3. 起動時の root パスワードのリセット

root 以外のユーザーとしてログインできない場合や、wheel 管理グループに所属しない場合は、特別な chroot jail 環境に切り替えることで起動時に root パスワードをリセットできます。

手順

    システムを再起動して、GRUB 2 ブート画面で e キーを押して、起動プロセスを中断します。

    カーネルブートパラメーターが表示されます。

    load_video
    set gfx_payload=keep
    insmod gzio
    linux ($root)/vmlinuz-4.18.0-80.e18.x86_64 root=/dev/mapper/rhel-root ro crash\
    kernel=auto resume=/dev/mapper/rhel-swap rd.lvm.lv/swap rhgb quiet
    initrd ($root)/initramfs-4.18.0-80.e18.x86_64.img $tuned_initrd

    linux で始まる行の最後に移動します。

    linux ($root)/vmlinuz-4.18.0-80.e18.x86_64 root=/dev/mapper/rhel-root ro crash\
    kernel=auto resume=/dev/mapper/rhel-swap rd.lvm.lv/swap rhgb quiet

    Ctrl+e を押して、行の最後に移動します。

    rd.break を linux で始まる行の最後に追加します。

    linux ($root)/vmlinuz-4.18.0-80.e18.x86_64 root=/dev/mapper/rhel-root ro crash\
    kernel=auto resume=/dev/mapper/rhel-swap rd.lvm.lv/swap rhgb quiet rd.break

    Ctrl+x を押して、変更したパラメーターでシステムを起動します。

    switch_root プロンプトが表示されます。

    ファイルシステムを書き込み可能で再マウントします。

    mount -o remount,rw /sysroot

    ファイルシステムは、/sysroot ディレクトリーに読み取り専用としてマウントされます。書き込み可能なファイルシステムとして再マウントすると、パスワードを変更できます。

    chroot 環境に入ります。

    chroot /sysroot

    sh-4.4# プロンプトが表示されます。

    root パスワードをリセットします。

    passwd

    コマンドラインに表示される指示に従って、root パスワードの変更を完了します。

    次回のシステム起動時に SELinux の再ラベルプロセスを有効にします。

    touch /.autorelabel

    chroot 環境を終了します。

    exit

    switch_root プロンプトを終了します。

    exit

    SELinux の再ラベルプロセスが終了するまで待機します。大規模なディスクの再ラベルには時間がかかる可能性があることに注意してください。プロセスが完了すると、システムが自動的に再起動します。 
```

# ref.

<https://access.redhat.com/documentation/ja-jp/red_hat_enterprise_linux/8/html/configuring_basic_system_settings/changing-and-resetting-the-root-password-from-the-command-line_managing-users-and-groups>
