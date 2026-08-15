---
layout: post
category: rust
title: "bin sample"
---

rubygems の bin と同じようなことをやりたい。
- libを持ちつつ、
- binを作りたい。

## ディレクトリ構成

```
$ ls -R
.:
Cargo.lock  Cargo.toml	src

./src:
bin  lib.rs

./src/bin:
hello.rs
$
$ cat src/lib.rs
pub fn greet(name: &str) {
    println!("Hello, {}!", name);
}
$
$ cat src/bin/hello.rs
use hello_cli::greet;

fn main() {
    greet("Rust");
}
$
```

## 実行結果

```
$ cargo run --bin hello -q
Hello, Rust!
$
```
