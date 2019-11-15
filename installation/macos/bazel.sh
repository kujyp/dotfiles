#!/usr/bin/env bash

## 1. using homebrew
# Ref: https://github.com/bazelbuild/bazel/blob/master/site/docs/install-os-x.md#install-on-mac-os-x-homebrew
brew tap bazelbuild/tap
# brew untap bazelbuild/tap
brew install bazelbuild/tap/bazel
bazel --version

# Ref: https://github.com/bazelbuild/homebrew-tap/commits/master/Formula/bazel.rb
# Ref2: https://github.com/bazelbuild/homebrew-tap/commit/f1839aa3db682bcfd9a24666d8b11b1fb6aecd4e#diff-7e630002d926fdc86c611259fed9b444
# 0.18.0 버전 부터 지원함. 내가 원하는버전은 0.8.0 이므로 직접 설치해야함

## 2. using binary installer
sudo xcodebuild -license accept
(
# Ref: https://github.com/bazelbuild/bazel/releases/tag/0.8.0
cd /tmp
#wget -O bazel-installer-darwin-x86_64.sh https://github.com/bazelbuild/bazel/releases/download/0.8.0/bazel-0.8.0-without-jdk-installer-darwin-x86_64.sh
wget -O bazel-installer-darwin-x86_64.sh https://github.com/bazelbuild/bazel/releases/download/0.8.0/bazel-0.8.0-installer-darwin-x86_64.sh

chmod +x bazel-installer-darwin-x86_64.sh
./bazel-installer-darwin-x86_64.sh --user
)
