---
layout: post
category: ruby
---

ソケット(`ポート5000`)経由で`python`から、`ruby`のメソッドを使用する方法。

## server.rb

```ruby
# server.rb
require 'socket'
require 'json'
require 'set'

METHODS_FILE = ARGV[0] || './methods.rb'
last_mtime = File.exist?(METHODS_FILE) ? File.mtime(METHODS_FILE) : Time.at(0)

# --- 初期ロード ---
load METHODS_FILE

# --- ホワイトリスト（Setで高速化） ---
ALLOWED_TOPLEVEL_METHODS = Set.new(%w[add greet])

# --- 安全な呼び出し関数（トップレベル＋モジュール両対応） ---
def safe_invoke(mod_path, method_name, args)
  if mod_path
    mod = Object.const_get(mod_path)
    raise "Method not allowed: #{method_name}" unless mod.respond_to?(method_name)
    mod.public_send(method_name, *args)
  elsif ALLOWED_TOPLEVEL_METHODS.include?(method_name)
    method(method_name).call(*args)
  else
    raise "Not allowed: #{mod_path}##{method_name}"
  end
end

# --- サーバ起動 ---
server = TCPServer.new(5002)
puts "✅ Ruby RPC server started (modules + top-level, auto-reload enabled)"

loop do
  # 🔄 methods.rbが更新されていたらリロード
  current_mtime = File.mtime(METHODS_FILE)
  if current_mtime > last_mtime
    begin
      puts "♻️ Reloading #{METHODS_FILE}..."
      load METHODS_FILE
      last_mtime = current_mtime
    rescue => e
      warn "⚠️ Reload failed: #{e.message}"
    end
  end

  client = server.accept
  begin
    data = JSON.parse(client.gets)
    mod_path = data["module"]   # e.g. "MathOps::Advanced" or nil
    method_name = data["method"]
    args = data["args"]

    result = safe_invoke(mod_path, method_name, args)
    client.puts({ result: result }.to_json)
  rescue => e
    client.puts({ error: e.message }.to_json)
  ensure
    client.close
  end
end
```

## methods.rb

```ruby
# methods.rb
# --- トップレベル関数 ---
def add(a, b)
  a + b
end

def greet(name)
  "Hello, #{name}! (updated at #{Time.now.strftime('%H:%M:%S')})"
end

# --- モジュール定義 ---
module MathOps
  module Advanced
    def self.pow(a, b)
      a ** b
    end
  end
end

module StringOps
  def self.concat(a, b)
    "#{a}#{b}"
  end
end
```

## client.py

```python
import socket, json

def call_ruby(module_path, method, *args):
    data = {"module": module_path, "method": method, "args": args}
    with socket.create_connection(("localhost", 5002)) as s:
        s.sendall((json.dumps(data) + "\n").encode())
        return json.loads(s.recv(4096).decode())["result"]

# --- テスト ---
print(call_ruby(None, "add", 2, 3))                # => 5
print(call_ruby(None, "greet", "Alice"))           # => "Hello, Alice! (updated at ...)"
print(call_ruby("MathOps::Advanced", "pow", 2, 5)) # => 32
print(call_ruby("StringOps", "concat", "ab", "cd"))# => "abcd"
```

# kill processes

```sh
lsof -i :5000
kill <n>
```
