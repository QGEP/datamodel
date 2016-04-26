#!/bin/bash

# Exit on error
set -e

DIR=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )/..

if test "$TRAVIS_SECURE_ENV_VARS" = "true" -a "$TRAVIS_BRANCH" = "master";
then
  echo "##########################";
  echo " ... Creating pull request";
  echo "##########################";

  git clone git@github.com:qgep-bot/QGEP.git
  master=`git -C QGEP submodule status | grep datamodel | cut -d' ' -f1 | cut -d'-' -f2`
  printf "Datamodel update from https://github.com/QGEP/QGEP/commit/${TRAVIS_COMMIT}\n\n" > /tmp/commitmessage
  git log --pretty --no-merges ${master}..HEAD >> /tmp/commitmessage

  pushd QGEP
  git submodule update --init
  git checkout -b pullRequest-${TRAVIS_COMMIT}
  pushd datamodel
  git checkout ${TRAVIS_COMMIT}
  popd
  git add datamodel
  git commit -F /tmp/commitmessage
  git push origin pullRequest-${TRAVIS_COMMIT}
  curl --request POST -H "Authorization: token ${OAUTH_TOKEN}" --data '{ "title": "Datamodel update", "body": "'"`awk 1 ORS='\\\\n' /tmp/commitmessage`"'", "head": "qgep-bot:pullRequest-'"${TRAVIS_COMMIT}"'", "base": "master" }' https://api.github.com/repos/QGEP/QGEP/pulls
  popd
fi
