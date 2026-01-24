---
layout: post
category: gitlab
---

なぜかGitLab。

# GitLab CLI (glab)

snapdで`glab`をインストールしたところ、rootでしか正常動作しなかった。`brew`で入れたところ、フリーズせずに、動作した。

```sh
# rootでしか通常動作しなかった。
sudo dnf install epel-release -y
sudo dnf install snapd -y

sudo systemctl restart snapd
snap install glab

# 最後いらないなら削除(snapdの挙動？)
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

#### @ rhel系(未検証:検証する前にbrewを)

未検証:検証する前にbrewを入れたため、dnf経由では達成する意義が無くなった。

```sh
sudo dnf config-manager --add-repo https://cli.github.com/packages/rpm/gh-cli.repo
sudo dnf install -y gh --repo gh-cli

gh auth login
```

## get repo list

```sh
mkdir -p github-reops; cd $_

gh repo list -L 100 > mylist
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
```

- なぜかrootでしかできなかった。
- 一般ユーザーで`GITLAB_HOST`を指定してもダメだった。
- brewでインストールした場合、一般ユーザーで、通常動作したので、snapdが関連していると考得られる。

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

