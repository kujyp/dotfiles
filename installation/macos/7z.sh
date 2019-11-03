#!/usr/bin/env bash

# decompress .7z
# extract .7z
# https://apple.stackexchange.com/a/307975
brew install p7zip
7za x myfiles.7z
# 주의: 같은 폴더내에 압축이 풀리니 폴더 만들고 할것.(옵션이 있을테지만 귀찮아서 확인안함)
# 두번째로 압축 풀어보니, 폴더생기면서 압축이 풀렸다.
# 폴더에 넣어서 압축할 필요는없지만 tar.gz 처럼 암묵적으로 모두 폴더에 넣어서 압축을 하지않을까 추측된다.
