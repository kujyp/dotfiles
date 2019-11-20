#!/bin/bash -e

# curl https://raw.githubusercontent.com/kujyp/dotfiles/master/installation/linux/centos/pyenv.sh > /tmp/pyenv.sh && chmod +x /tmp/pyenv.sh && /tmp/pyenv.sh

function error_msg() {
    echo -e "\033[0;31m[ERROR] ${1-}\033[0m"
}

function info_msg() {
    echo -e "\033[0;33m[INFO] ${1-}\033[0m"
}

function echo_rcfile() {
    if [[ "$(basename $SHELL)" == "bash" ]]; then
        if [[ $(uname) == Darwin* ]]; then
            echo ".bash_profile"
        else
            echo ".bashrc"
        fi
    elif [[ "$(basename $SHELL)" == "zsh" ]]; then
        echo ".zshrc"
    fi
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


# yum installation to remove these errors, warnings above.
#WARNING: The Python bz2 extension was not compiled. Missing the bzip2 lib?
#WARNING: The Python readline extension was not compiled. Missing the GNU readline lib?
#WARNING: The Python sqlite3 extension was not compiled. Missing the SQLite3 lib?
#ERROR: The Python ssl extension was not compiled. Missing the OpenSSL lib?
yum_packages="zlib-devel openssl-devel sqlite-devel readline-devel bzip2-devel"
if ! has_yum_packages_installed ${yum_packages}; then
    error_msg "install dependencies first.
$ yum install -y ${yum_packages}
"
    exit 1
fi


curl https://pyenv.run | bash

echo "export PATH=\"~/.pyenv/bin:\$PATH\"
eval \"\$(pyenv init -)\"
eval \"\$(pyenv virtualenv-init -)\"
" >> ~/$(echo_rcfile)

info_msg "install [python 3.7.5]..."
pyenv install --skip-existing 3.7.5
info_msg "install [python 2.7.15]..."
pyenv install --skip-existing 2.7.17
