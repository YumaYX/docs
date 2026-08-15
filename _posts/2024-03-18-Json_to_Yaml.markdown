---
layout: post
category: ruby
title: Json_to_Yaml
---

Json to YAML with ruby

```sh
ruby -ryaml -rjson -e 'puts YAML.dump(JSON.parse(STDIN.read))' < sample.json > sample.yaml
```

- `-ryaml -rjson`: yaml / json ライブラリを require
- `JSON.parse(STDIN.read)`: 標準入力から JSON を読み込んでパース
- `YAML.dump`: Rubyオブジェクトを YAML に変換
- `< sample.json > sample.yaml`: 変換元・出力先を指定

[[Ruby][小ネタ] ワンライナーで JSON を YAML に変換する \| DevelopersIO](https://dev.classmethod.jp/articles/ruby-json-to-yaml/)
