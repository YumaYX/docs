---
layout: post
category: github
title: "delete github action history"
---

```sh
brew install gh

gh auth login
```

repoの指定は、cloneしたディレクトリでやればいいらしい。

```sh
wname="Deploy Docs to GitHub Pages"

for id in $(gh run list --workflow "${wname}" --json databaseId --jq '.[].databaseId' --limit 100); do
  echo $id
  gh run delete $id
  sleep 3
done
```

