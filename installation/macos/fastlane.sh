#!/usr/bin/env bash

# brew cask install fastlane # 2.28.3
brew install ruby
echo 'export PATH="/usr/local/opt/ruby/bin:$PATH"' >> ~/.zshrc
source ~/.zshrc

sudo gem install fastlane -NV
# signet requires Ruby version >= 2.4.0.

if [[ "$(basename $SHELL)" == "bash" ]]; then
    rcfile=.bash_profile
elif [[ "$(basename $SHELL)" == "zsh" ]];
    rcfile=

echo -e "# fastlane\nexport PATH=\"\$HOME/.fastlane/bin:\$PATH\"\n" >> ~/.zshrc
source ~/.zshrc
fastlane update_fastlane
