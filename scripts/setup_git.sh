#!/bin/bash

if test "$TRAVIS_SECURE_ENV_VARS" = "true" -a "$TRAVIS_BRANCH" = "master";
then
  echo "Setting up git for qgep-bot"
  openssl aes-256-cbc -K $encrypted_a9c41dbba15f_key -iv $encrypted_a9c41dbba15f_iv -in qgep_rsa.enc -out ~/.ssh/id_rsa -d
  chmod 600 ~/.ssh/id_rsa;
  git config --global user.email "qgep@opengis.ch";
  git config --global user.name "QGEP";
  git config --global push.default simple;
else
  echo "Setting up readonly access via https"
  sed -i 's|git@github.com:|https://github.com/|' .gitmodules
fi
