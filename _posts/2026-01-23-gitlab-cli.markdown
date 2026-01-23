---
layout: post
category: gitlab
---

なぜかGitLab。

# GitLab CLI (glab)

```sh
sudo dnf install epel-release -y
sudo dnf install snapd -y

sudo systemctl restart snapd
snap install glab

# 最後いらないなら削除
#sudo systemctl stop snapd
#sudo dnf remove snapd -y
```

- localhost:8080

```sh
# 事前にgitlabでtokenを作っておく。

glab auth login --hostname localhost:8080
# GUIがあるといい? ssh,httpを選択。
```

---

GitHubからクローンした自分のプロジェクトをGitLabにpushしたら面白いんじゃないか。
- podmanのgitlabはポートが開いていない箇所がある。
- gitlabはoauthアプリが最初にない。→tokenで処理する。事前に作っておく。

### GitHub cli

```sh
@ Mac
brew install gh

gh auth login
```

#### @ rhel系(未検証)

```sh
sudo dnf config-manager --add-repo https://cli.github.com/packages/rpm/gh-cli.repo
sudo dnf install -y gh --repo gh-cli

gh auth login
```

## get repo list

```sh
mkdir -p github-reops; cd $_

gh repo list > mylist
# ここでは、privateを含むのレポジトリ名を取っておきたい。
```

## clone repos from github

```sh
cat mylist | awk '{print $1}' | awk -F/ '{print $2}' | while read line
do
  echo ${line}
  git clone git@github.com:YumaYX/${line}.git
  sleep 2
done
```

## make repos in my gitlab

- ssh://git@localhost:2222/`user`/`reponame`.git

```sh
cat mylist | awk '{print $1}' | awk -F/ '{print $2}' | GITLAB_HOST=localhost:8080 xargs -I@ glab repo create @ -s
#なぜかrootでしかできなかった。snapdの問題？一般ユーザーでGITLAB_HOSTを指定してもダメだった。
```

## push to my gitlab

```sh
cat mylist | awk '{print $1}' | awk -F/ '{print $2}' | while read line
do
  echo ${line}
  cd ${line}; pwd; sleep 2
  git remote remove origin
  git remote -v; sleep 2
  git remote add origin ssh://git@localhost:2222/user/${line}.git
  git push -u origin main #もちろんmainブランチじゃないとエラー。
  git push --all origin
  git push --tags origin
  sleep 2
  cd -
done
```

