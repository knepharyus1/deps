#!/bin/sh

urlfile="./urls"
datadir="./data"

TARGET_BRANCH=${TARGET_BRANCH:-build}
REPO=https://taemon1337:${GITHUB_TOKEN}@github.com/clustellar/deps.git
NEWORIGIN=origin-build

echo "[GIT] $REPO (branch=$TARGET_BRANCH)"

git_setup() {
  git config user.name "Travis CI"
  git config user.email "$COMMIT_AUTHOR_EMAIL"
  git remote add $NEWORIGIN $REPO
  git checkout -b $TARGET_BRANCH
}

fetch_urls() {
  for url in $(cat $urlfile); do
    ofile=$(echo $url | md5sum | cut -d' ' -f1)
    curl -k $url -o $datadir/$ofile
  done
}

git_push() {
  git add $datadir
  git commit -m "Travis build: $TRAVIS_BUILD_NUMBER"
  git push -u $NEWORIGIN $TARGET_BRANCH
}


git_setup
fetch_urls
git_push
