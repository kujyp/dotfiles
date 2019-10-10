#!/usr/bin/env bash

# decompress .7z
# extract .7z
# https://apple.stackexchange.com/a/307975
brew install p7zip
7za x myfiles.7z
# 주의: 같은 폴더내에 압축이 풀리니 폴더 만들고 할것.(옵션이 있을테지만 귀찮아서 확인안함)
