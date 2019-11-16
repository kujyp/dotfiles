### octotree 구버전설치
- 아래 스크립트 실행
  - chrome 옵션 - 도구더보기 - 확장프로그램 - 개발자모드 활성화 > 폴더 드래그
  - github.com 사이트에서 > 좌측 환경설정 버튼(톱니바퀴)
    - token 추가 https://github.com/kujyp/private_documents/blob/master/docs/octotree.md
    - GitHub Enterprise URLs - https://oss.navercorp.com 추가
```bash
(
cd /Applications
if [[ -d octotree ]]; then
    echo "Remove existing octotree directory..."
    rm -rf octotree
fi

git clone https://github.com/ovity/octotree octotree-2.5.6
(
cd octotree-2.5.6
git checkout b671960972d8e634ccbd10d88fd98693ff3732cf # 2.5.6(Fix issue branch with slashes)
)

mkdir -p octotree
mv octotree-2.5.6/dist/chrome.zip octotree/chrome.zip
(cd octotree; unzip chrome.zip)
rm -rf octotree-2.5.6
rm -f v2.5.6.zip
open .
)
```
