#!/bin/bash

# Exit on error
set -e

DIR=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )/..

if test "$TRAVIS_SECURE_ENV_VARS" = "true" -a "$TRAVIS_BRANCH" = "master";
then
  echo "##########################";
  echo " ... Creating pull request";
  echo "##########################";

  git clone git@github.com:QGEP/QGEP.git
  pushd QGEP
  git submodule update --init
  git checkout -b pullRequest-${TRAVIS_COMMIT}
  pushd datamodel
  git checkout ${TRAVIS_COMMIT}
  popd
  git add datamodel
  git commit -m "Automatic update from https://github.com/qgep/QGEP/commit/${TRAVIS_COMMIT}"
  git push origin pullRequest-${TRAVIS_COMMIT}
  popd
fi
