#!/bin/sh

setup_git() {
  git config --global user.email "travis@travis-ci.org"
  git config --global user.name "Travis CI"
}

commit() {
  git checkout master
  git add ./data
  git commit -m "Travis build: $TRAVIS_BUILD_NUMBER"
}

upload() {
  git remote add origin https://${GH_TOKEN}@github.com/clustellar/deps.git > /dev/null 2>&1
  git push --quiet --set-upstream origin master
}

setup_git
commit
upload
