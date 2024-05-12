---
layout: post
category: ruby
---

Json to YAML with ruby

```sh
ruby -ryaml -rjson -e 'puts YAML.dump(JSON.parse(STDIN.read))' < sample.json > sample.yaml
```

<https://dev.classmethod.jp/articles/ruby-json-to-yaml/>
