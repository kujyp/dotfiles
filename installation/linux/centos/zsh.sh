#!/bin/bash -e

# curl https://raw.githubusercontent.com/kujyp/dotfiles/master/installation/linux/centos/zsh.sh > /tmp/zsh.sh && chmod +x /tmp/zsh.sh && /tmp/zsh.sh; rm -f /tmp/zsh.sh

function error_msg() {
    echo -e "\033[0;31m[ERROR] ${1-}\033[0m"
}

function has_yum_package_installed {
    yum list installed "$@" >/dev/null 2>&1
}

function has_yum_packages_installed {
    for each in $@; do
        if ! has_yum_package_installed "${each}"; then
            false
            return
        fi
    done
    true
}


yum_packages="zsh yarn"
if ! has_yum_packages_installed ${yum_packages}; then
    if [[ $UID -eq 0 ]]; then
        sudo_cmd=""
    else
        sudo_cmd="sudo"
    fi

    curl --silent --location https://dl.yarnpkg.com/rpm/yarn.repo | ${sudo_cmd} tee /etc/yum.repos.d/yarn.repo
    ${sudo_cmd} rpm --import https://dl.yarnpkg.com/rpm/pubkey.gpg

    ${sudo_cmd} yum install -y \
        ${yum_packages}

    if [[ "$?" -ne 0 ]]; then
        error_msg "yum install failed.
$ yum install -y ${yum_packages}
"
        exit 1
    fi
fi


echo 'y' | sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"

git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
git clone https://github.com/agkozak/zsh-z ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-z
git clone https://github.com/zsh-users/zsh-completions ${ZSH_CUSTOM:=~/.oh-my-zsh/custom}/plugins/zsh-completions

sed -i -e "s/^plugins.*/plugins=(git z zsh-syntax-highlighting zsh-autosuggestions)/" ~/.zshrc
sed -i -e "s/^ZSH_THEME.*/ZSH_THEME=\"\"/" ~/.zshrc

yarn global add pure-prompt
echo "# zsh
if [[ -f ~/.bashrc ]]; then
    source ~/.bashrc
fi" >> ~/.zshrc
echo "# Pure
autoload -U promptinit; promptinit
prompt pure" >> ~/.zshrc
