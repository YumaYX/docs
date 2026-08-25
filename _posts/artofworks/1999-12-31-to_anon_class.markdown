---
layout: artofworks
title: "to_anon_class.rb"
category: artofworks
---

```ruby
# File 'lib/ys1/core_ext/hash.rb', line 22

def to_anon_class
  source = self

  Class.new do
    source.each_key { |key| attr_accessor key.to_sym }

    define_method(:initialize) do
      source.each do |key, value|
        instance_variable_set("@#{key}", value)
      end
    end
  end
end
```
