---
layout: post
category: ruby
---

Json to YAML with ruby

```sh
ruby -ryaml -rjson -e 'puts YAML.dump(JSON.parse(STDIN.read))' < sample.json > sample.yaml
```

[[Ruby][小ネタ] ワンライナーで JSON を YAML に変換する | DevelopersIO](https://dev.classmethod.jp/articles/ruby-json-to-yaml/)
