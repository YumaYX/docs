---
layout: post
category: windows
---

追記：この方法は、おかしい。OSをインストールするとブートローダーが筐体ディスクにインストールされない。ブートメディアなしでは、起動しなくなる。ブートローダーを手動でインストールすれば、問題なくなる。面倒な場合は、メディアを作るときに、Linux(woeusb)を使えば解決する。

## MacでWin ISOブータブルメディアを作る手順

```sh
brew install wimlib
```

* 対象ディスクが **disk4** の場合
* 実行環境：macOS

```sh
diskutil eraseDisk MS-DOS "WIN11" GPT /dev/disk4

# ISOをマウント（例：Finderでダブルクリック）
# hdiutil mount ~/Downloads/Win1*.iso

rsync -avh --progress --exclude=sources/install.wim /Volumes/CCCOMA_X64FRE_JA-JP_DV9/ /Volumes/NO\ NAME/
wimlib-imagex split /Volumes/CCCOMA_X64FRE_JA-JP_DV9/sources/install.wim /Volumes/NO\ NAME/sources/install.swm 3800

# /dev/disk4 のマウント解除
#hdiutil mount ~/Downloads/Win1*.iso
diskutil unmountDisk /dev/disk4
```

* `diskutil` で指定したラベル名に関わらず、マウント名は `"NO NAME"` になります。
* 書き込み権限が不足している場合は、各コマンドの前に `sudo` を付けて実行してください。

```sh
brew uninstall wimlib
```
