# dotfiles
dotfile 을 넣고싶었으나, custom dotfile 이 딱히 없음.

## 컴퓨터 초기화 이후 수행해야하는 작업목록
### 회사컴에서 해야하는것
https://github.com/kujyp/private_documents/blob/master/docs/%ED%9A%8C%EC%82%AC%EC%BB%B4%EC%97%90%EC%84%9C%ED%95%B4%EC%95%BC%ED%95%98%EB%8A%94%EA%B2%83.md

### source installation_script
```bash
curl https://raw.githubusercontent.com/kujyp/dotfiles/master/installation/macos.sh > /tmp/macos.sh
source /tmp/macos.sh
```

### 크롬 설치
- 설치
```bash
install_with_homebrew_cask "google-chrome"
```
- 크롬 확장프로그램 로그인 필요

### 세팅시 당장 불편한것부터 해결
- spectacle 설치 - sudo 권한(비밀번호필요)
```bash
install_spectacle
```
-  spectacle - preferences - launch at login 체크
- Trackpad.prefPane - 탭하여 클릭하기 활성화
- caffeine 설치 http://lightheadsw.com/caffeine/
```bash
install_caffeine
```
- Spotlight > Caffeine.app - 뜨는 경고창 확인
- Security&Privacy General-Allow apps downloaded from: -> open anyway

### 오래걸리는것부터 설치
- icloud 로그인
  - https://github.com/kujyp/accounts/blob/master/accounts/icoud.md
  - app store에서만 하면안되고, iCloudPref.prefPane 에서 한번더 로그인해야 적용됨
  - 다른 apple 기기 없을때 - 인증번호 안온다는 부분 클릭 - 휴대폰문자로 확인으로 로그인
- appstore - xcode, kakaotalk, line 설치
```bash
install_appstore_packages
```
- toolbox 설치
```bash
install_with_homebrew_cask "jetbrains-toolbox"
```
- toolbox 설정 > generate shell scripts > /usr/local/bin
- toolbox 설정 > login - https://github.com/kujyp/private_documents/blob/master/accounts/jetbrains.md
- android studio 설치
  - android studio 실행 > android sdk 설치
  - platform tools 등 설치
```bash
echo -e "\n\
# Android\n\
export ANDROID_HOME=~/Library/Android/sdk\n\
export PATH=\$PATH:\$ANDROID_HOME/tools/bin:\$ANDROID_HOME/tools/bin:\$ANDROID_HOME/platform-tools" >> ~/.bash_profile
```
```bash
install_android_components
```
- pycharm 2019.1.4
  - pycharm 2019.2 는 command line launcher (pycharm .) 실행시 크래쉬나는 버그 존재함.
- webstorm, clion 설치
- jetbrains plugins 설치 - promoter X / .ignore
- 바탕화면 좌측상단 이 맥에관하여 - 소프트웨어 업데이트 - 업데이트
- 구글드라이브 설치 https://www.google.com/drive/download/
```bash
install_with_homebrew_cask "google-backup-and-sync"
mkdir -p ~/google_drive
# install_with_homebrew_cask "google-drive-file-stream" # (enterprise)  
```
  - 구글드라이브 로그인
  - ~/google_drive 경로 > 선택한 폴더만 동기화, google photos 만 제외

### 환경 설정
https://github.com/kujyp/dotfiles/blob/master/docs/macos_settings.md
https://github.com/kujyp/dotfiles/blob/master/docs/gitconfig.md

### 기타설치
- nosleep - sudo 권한(비밀번호필요)
```bash
install_nosleep
```
- teamviewer - sudo 권한(비밀번호필요)
```bash
install_with_homebrew_cask "teamviewer"
```
- viperftp
```bash
install_with_homebrew "wget"
echo 'export PATH="/usr/local/opt/gettext/bin:$PATH"' >> ~/.bash_profile
(
cd /tmp
wget https://naarakstudio.com/download/ViperFTPLite.dmg
)
open /tmp/ViperFTPLite.dmg
```
- homebrew cask packages
  - slack 친구목록받아오기 - https://slack.com/get-started
```bash
install_homebrew_cask_packages
```
- homebrew packages
```bash
install_homebrew_packages
```
- iterm2
  - Iterm preference > Profiles > Keys > 우측하단 Left Option Key: Esc+ 선택
  - Key Mappings 에 추가버튼(+) 클릭 > 아래 4개 추가
  - Keyboard Shortcut: ⌥←, Action: Send Escape Sequence, Esc+: b
  - Keyboard Shortcut: ⌥→, Action: Send Escape Sequence, Esc+: f
  - ⌘←  "SEND HEX CODE"      0x01
  - ⌘→  "SEND HEX CODE"      0x05
```bash
install_with_homebrew_cask "iterm2"
```
- zsh
```
install_with_homebrew "zsh"
install_with_homebrew "zsh-completions"
install_with_homebrew "yarn"
npm install --global pure-prompt

chsh -s /bin/zsh $whoami

sh -c "$(curl -fsSL https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
git clone https://github.com/agkozak/zsh-z ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-z

sed -i -e "s/^plugins.*/plugins=(git z zsh-syntax-highlighting zsh-autosuggestions)/" ~/.zshrc
sed -i -e "s/^ZSH_THEME.*/ZSH_THEME=\"\"/" ~/.zshrc
echo -e "\n# Pure\nautoload -U promptinit; promptinit\nprompt pure" >> ~/.zshrc
```
- 공인인증서 - https://github.com/kujyp/private_documents/blob/master/docs/%EA%B3%B5%EC%9D%B8%EC%9D%B8%EC%A6%9D%EC%84%9C.md
- octotree 구버전설치
  - 스크립트 실행
  - chrome 옵션 - 도구더보기 - 확장프로그램 > 폴더 드래그
  - github.com 사이트에서 > 좌측 환경설정 버튼(톱니바퀴)
    - token 추가 https://github.com/kujyp/private_documents/blob/master/docs/octotree.md
    - GitHub Enterprise URLs - https://oss.navercorp.com 추가
```bash
install_with_homebrew "wget"
(
cd /Applications
wget https://github.com/ovity/octotree/archive/v2.5.5.zip
unzip v2.5.5.zip
mkdir -p octotree
mv octotree-2.5.5/dist/chrome.zip octotree/chrome.zip
(cd octotree; unzip chrome.zip)
rm -rf octotree-2.5.5
rm -f v2.5.5.zip
open .
)
```


### IDE 세팅
- pair 검색해서 3개제거 [], {}, ""
- IDE preferences for new projects...
  - terminal > shell path > /bin/zsh
  - terminal > shell integration > uncheck


### python 설치
- pip install virtualenv
