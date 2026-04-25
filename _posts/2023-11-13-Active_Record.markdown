---
layout: post
title: "Active Record"
date: 2023-11-13 11:40:12 JST
tags: 
category: ruby
---

# Active Recordで、データ処理をする。

Active Recordを使ったサンプル。Railsは使わない。

## Gemfile

```ruby
source "https://rubygems.org"

gem 'activerecord'
gem 'sqlite3'
```

activerecordとsqlite3が必要

## Manufacturer（データ例）

| id | name |
| --- | --- |
| 1 | Honda |
| 2 | Nissan |
| 3 | BMW |

```ruby
require 'active_record'

# テーブルを作成
class Manufacturer <  ActiveRecord::Base ; end

# データベースに接続
Manufacturer.establish_connection(
  adapter: 'sqlite3',
  database: 'database.db'
)

# テーブル作成
unless Manufacturer.table_exists?
  Manufacturer.connection.create_table :manufacturers do |t|
    t.string :name
    end
end

# データを挿入
Manufacturer.transaction do
  Manufacturer.create(name: 'Honda')
  Manufacturer.create(name: 'Nissan')
  Manufacturer.create(name: 'BMW')
end
# データベースの切断
Manufacturer.connection.close
```

## Car（データ例）

| id | car_name | manufacturer_id | maker(duplication)|
| --- | --- | --- | --- |
| 1 | NSX | 1 | Honda |
| 2 | GT-R | 2 | Nissan |

```ruby
require 'active_record'

class Car < ActiveRecord::Base ; end
Car.establish_connection(
  adapter: 'sqlite3',
  database: 'database.db'
)
unless Car.table_exists?
  Car.connection.create_table :cars do |t|
    t.string :car_name
    t.integer :manufacturer_id
    t.string :maker
    t.timestamps
  end
end

Car.create(car_name: 'NSX',  manufacturer_id: 1, maker: "Honda")
Car.create(car_name: 'GT-R', manufacturer_id: 2, maker: "Nissan")
Car.connection.close
```

---

## データ抽出

**基本ひだり（←）が基準**

#### left outer join：1対多

```ruby
require 'active_record'
class Manufacturer < ActiveRecord::Base
  has_many :cars
end
Manufacturer.establish_connection(adapter: 'sqlite3', database: 'database.db')

Manufacturer.left_outer_joins(:cars).select("manufacturers.*, cars.*").each do |row|
  p row
  p "#{row.name}, #{row.car_name}"
  p row.car_name.nil? # 右にデータが無い場合、nilが返る
end
=begin
#<Manufacturer id: 1, name: "Honda">
"Honda, NSX"
false
#<Manufacturer id: 2, name: "Nissan">
"Nissan, GT-R"
false
#<Manufacturer id: nil, name: "BMW">
"BMW, "
true
=> 
[#<Manufacturer:0x000000010f976188 id: 1, name: "Honda">,
 #<Manufacturer:0x000000010f976048 id: 2, name: "Nissan">,
 #<Manufacturer:0x000000010f975f08 id: nil, name: "BMW">]
=end
Manufacturer.connection.close
```

### 1対1

- 右にキーの重複がある場合：.distinct(=.uniq)をクエリに繋げる。
  - テーブル定義時に、「, index: { unique: true }」ユニーク制約してあげれば、事前に気付く（が、まず、重複してる状況がありえない）。
  - ちなみに「, unique: true」の設定の仕方は間違い

[create_tableでカラムを定義するのと同時にユニークインデックスを貼るやつ - しふみんのブログ](https://shifumin.hatenablog.com/entry/2019/02/02/000000)


```ruby
require 'active_record'
class Manufacturer <  ActiveRecord::Base
  has_one :car
  # 単数
end
Manufacturer.establish_connection(adapter: 'sqlite3', database: 'database.db')

p Manufacturer.find(1).car
# has_oneにより、carが使える
Manufacturer.all.each do |row|
  if row.car
    p "#{row.name},#{row.car.car_name}"
  else
    p "#{row.name}"
  end
end
=begin
#<Car id: 1, car_name: "NSX", manufacturer_id: 1, maker: "Honda", created_at: "2023-05-30 09:20:15.975747000 +0000", updated_at: "2023-05-30 09:20:15.975747000 +0000">
"Honda,NSX"
"Nissan,GT-R"
"BMW"
=> 
[#<Manufacturer:0x000000010f996f50 id: 1, name: "Honda">,
 #<Manufacturer:0x000000010f996cd0 id: 2, name: "Nissan">,
 #<Manufacturer:0x000000010f996a50 id: 3, name: "BMW">]
=end
Manufacturer.connection.close
```

### 1対1：キー指定

- キーはあるものの、activerecordに則った(MODEL_id)キーが無い場合
- joinsで、キー指定したい場合
  - もちろんキーを書いて、テーブルを結合することもできるが、事前にクラス定義するときにモデルの関係を定義する

```ruby
require 'active_record'
class Manufacturer <  ActiveRecord::Base
  has_one :car, primary_key: :name, foreign_key: :maker
  # manufacturers.name == cars.maker
end
Manufacturer.establish_connection(adapter: 'sqlite3', database: 'database.db')

Manufacturer.left_outer_joins(:car).all.each do |row|
  if row.car
    p "#{row.name},#{row.car.car_name}"
  else
    p "#{row.name}"
  end
end
=begin
"Honda,NSX"
"Nissan,GT-R"
"BMW"
=> 
[#<Manufacturer:0x000000010f972808 id: 1, name: "Honda">,
 #<Manufacturer:0x000000010f9726c8 id: 2, name: "Nissan">,
 #<Manufacturer:0x000000010f972588 id: 3, name: "BMW">]
=end
Manufacturer.connection.close
```

- .to_sqlでSQL表示できる
- デフォルトは、idがプライマリー。idを除くこともできる
- トランザクションを使う場合はブロック内で処理を実施する
- joinsをそのまま使うと、モデル_idが使用される
- テーブル名は複数形

## Environment

```sh
~  gem list | grep  -E 'activerecord|sqlite'
activerecord (7.0.5)
sqlite3 (1.6.3 x86_64-darwin)
~  
```

# Active Recordで、出力順を指定する。

## Order

- asc: 1 -> 99
- desc: 99 -> 1

```ruby
irb(main):001:0> puts User.order(:id).to_sql
  TRANSACTION (0.1ms)  begin transaction
SELECT "users".* FROM "users" ORDER BY "users"."id" ASC
=> nil
irb(main):002:0> 
irb(main):003:0> puts User.order(id: :asc).to_sql
SELECT "users".* FROM "users" ORDER BY "users"."id" ASC
=> nil
irb(main):004:0> 
irb(main):005:0> puts User.order(id: :desc).to_sql
SELECT "users".* FROM "users" ORDER BY "users"."id" DESC
=> nil
irb(main):006:0> 
```

### multi

```ruby
irb(main):008:0> puts User.order(:id, :name).to_sql
SELECT "users".* FROM "users" ORDER BY "users"."id" ASC, "users"."name" ASC
=> nil
irb(main):009:0> puts User.order(:id).order(:name).to_sql
SELECT "users".* FROM "users" ORDER BY "users"."id" ASC, "users"."name" ASC
=> nil
irb(main):010:0>
```

[order \| Railsドキュメント](https://railsdoc.com/page/model_order)

## env

```sh
[root@adae98cb22b2 /]# rails -v
Rails 7.0.5
[root@adae98cb22b2 /]# 
```

```sh
gem install rails
rails new app
cd app
rails generate model User name:string email:string
cat <<USERDATA > db/seeds.rb
User.create([
  { name: "John Doe", email: "john@example.com" },
  { name: "Jane Smith", email: "jane@example.com" },
  { name: "Bob Johnson", email: "bob@example.com" }
])
USERDATA
rails db:migrate
rails db:seed
rails c --sandbox
```
