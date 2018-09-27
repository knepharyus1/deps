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
  REPO=`git config remote.origin.url`
  SSH_REPO=${REPO/git@github.com/${GITHUB_TOKEN}@github.com}
  git config user.name "Travis CI"
  git config user.email "$COMMIT_AUTHOR_EMAIL"
  git push $SSH_REPO $TARGET_BRANCH
}


fetch_urls
git_push
