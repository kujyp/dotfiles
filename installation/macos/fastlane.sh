#!/usr/bin/env bash


if [[ "$(basename $SHELL)" == "bash" ]]; then
    rcfile=.bash_profile
elif [[ "$(basename $SHELL)" == "zsh" ]]; then
    rcfile=.zshrc
fi


brew install ruby
echo 'export PATH="/usr/local/opt/ruby/bin:$PATH"' >> ~/${rcfile}
source ~/${rcfile}


sudo gem install fastlane -NV
fastlane_bin_path=$(dirname $(find /usr/local -name fastlane 2> /dev/null | grep '/bin/fastlane' | grep -v 'gems/fastlane' | head -n1))
echo -e "# fastlane\nexport PATH=\"$fastlane_bin_path:\$PATH\"\n" >> ~/${rcfile}
source ~/${rcfile}
fastlane update_fastlane
