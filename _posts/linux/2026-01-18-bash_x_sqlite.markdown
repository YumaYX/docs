---
layout: post
category: linux
title: "bash x sqlite"
---

bashからsqliteを操作する。

```sh
dnf -y install sqlite
```

## CSV

```sh
cat <<'EOF'> a.csv
h1,h2,h3
"c1,x",c2,c3
EOF

cat a.csv | sqlite3 b.db -cmd ".mode csv" -cmd ".import /dev/stdin mytable"

sqlite3 -header b.db "SELECT * FROM mytable"
sqlite3         b.db "SELECT * FROM mytable"
```

## テーブル - myid

```sh
cat <<'EOF'> a.csv
id
a
b
c
EOF

cat a.csv | sqlite3 data.db -cmd ".mode csv" -cmd ".import /dev/stdin myid"
```

```sh
sqlite3 data.db <<'SQL'
CREATE TABLE myid (
  id TEXT PRIMARY KEY
);

CREATE TABLE mydata (
  key TEXT PRIMARY KEY,
  value INTEGER
);
SQL
```

## テーブル - mydata

```sh
cat <<'EOF'> a.csv
key,value
a,1
b,2
c,3
EOF

cat a.csv | sqlite3 data.db -cmd ".mode csv" -cmd ".import /dev/stdin mydata"
```

### 外部結合

`myid` テーブルの `id` をキーに、`mydata` テーブルの `key` に照らし合わせる。
合致する `mydata` の `value` を出力する。

```sh
sqlite3 -header data.db "
SELECT
  myid.id,
  mydata.value
FROM myid
LEFT OUTER JOIN mydata
  ON myid.id = mydata.key;
"
```

```sh
sqlite3 data.db "DROP TABLE myid;"

sqlite3 data.db "DROP TABLE mydata;"
```

## 参考リンク

[bash で sqlite3 をいじるためのメモ #Bash - Qiita](https://qiita.com/arc279/items/bba7f6be362e376f06ab)

### TSV

```sh
{ seq -f 'header%g' 3; seq -f 'content%g' 9; } | paste - - - | tee sample.tsv

TABLE_NAME=sample
cat sample.tsv | sqlite3 -separator $'\t' -header -cmd  ".import /dev/stdin ${TABLE_NAME}" a.db

sqlite3 -header a.db "SELECT * FROM ${TABLE_NAME}"
```

