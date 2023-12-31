---
layout: post
category: commands
title: timedatectl
---

## 日付・時間・タイムゾーン設定

- `set-local-rtc false`: RTC(ハードウェア時計)をローカル時刻ではなく UTC として扱う設定
- `set-timezone Asia/Tokyo`: タイムゾーンを日本時間に設定

```sh
timedatectl set-local-rtc false
timedatectl set-timezone Asia/Tokyo
```
