#!/bin/sh

urlfile="./urls"
datadir="./data"

fetch_urls() {
  for url in $(cat $urlfile); do
    ofile=$(echo $url | md5sum | cut -d' ' -f1)
    curl -k $url -o $datadir/$ofile
  done
}

git_push() {
  TARGET_BRANCH=${TARGET_BRANCH:-build}
  REPO=https://git:${GITHUB_TOKEN}@github.com/clustellar/deps.git
  git config user.name "Travis CI"
  git config user.email "$COMMIT_AUTHOR_EMAIL"
  echo "[GIT] push $REPO $TARGET_BRANCH"
  git push $REPO $TARGET_BRANCH
}


fetch_urls
git_push
