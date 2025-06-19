---
layout: post
category: shell
---

my bash coding standards

## シバン

```sh
#!/usr/bin/env bash
```

## インデント

2つ

## 変数名 & 関数名

- snake_caseを使用（例: `user_name`）
- グローバル変数は 全大文字＋アンダースコア
  - `readonly `を付ける
- 変数展開に`${}`を使う
- 関数内変数には`local `を付ける

### 引用符

文字列や変数展開には 常にダブルクォート を使用

## 条件分岐

`[[ ... ]]`を使う

```sh
if [[ "${name}" == "Alice" ]]; then
    echo "Hello, Alice"
elif [[ "${name}" == "Bob" ]]; then
    echo "Hey, Bob"
else
    echo "Who are you?"
fi
```

## ループ

```sh
for file in *.txt
do
    echo "$file"
done
```

## コマンド置換

```sh
files=$(ls *.txt)
```

## その他

- ファイル末尾は改行で終える
- .sh 拡張子を付ける
