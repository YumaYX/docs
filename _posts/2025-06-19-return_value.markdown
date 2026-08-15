---
layout: post
category: shell
title: return_value
---

## 概要

関数内で `echo` が返す値を出力し、`return ${?}` で直前コマンドの終了ステータスを関数の戻り値として返す。`$( )` で標準出力の内容を変数に格納している。

```sh
get_username() {
    echo "alice"
    return ${?}
}

user=$(get_username)
echo "User: $user"
```

```
$ sh sample.sh 
User: alice
$  
```
