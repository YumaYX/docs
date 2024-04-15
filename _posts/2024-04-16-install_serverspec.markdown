---
layout: post
category: ruby
---

install serverspec gem

# for Ruby 2.5.5

```sh
cat <<GEMLIST255 > gemlist
net-telnet 0.2.0
multi_json 1.15.0
diff-lcs 1.5.1
net-ssh 6.1.0
rspec-support 3.13.1
sfl 2.3
rspec-mocks 3.13.0
rspec-expectations 3.13.0
rspec-core 3.13.0
net-scp 4.0.0
specinfra 2.89.0
rspec 3.13.0
rspec-its 1.3.0
serverspec 2.42.3
GEMLIST255
```

# Command

## curl

```sh
cat gemlist | while read name ver
do
echo curl -O https://rubygems.org/downloads/${name}-${ver}.gem
done
```

## gem install

```sh
cat gemlist | while read name ver
do
echo gem install ${name}-${ver}.gem --local
echo "echo \$?"
done
```
