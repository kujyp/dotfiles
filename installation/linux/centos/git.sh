#!/bin/bash -e

# curl https://raw.githubusercontent.com/kujyp/dotfiles/master/installation/linux/centos/git.sh > /tmp/git.sh && chmod +x /tmp/git.sh && /tmp/git.sh

function error_msg() {
    echo -e "\033[0;31m[ERROR] ${1-}\033[0m"
}


yum_packages="make gcc openssl-devel curl-devel expat-devel gettext-devel"
yum update -y \
  && yum install -y \
    ${yum_packages} \
  && rm -rf /var/cache/yum

if [[ "$?" -ne 0 ]]; then
    error_msg "yum install failed.
$ yum install -y ${yum_packages}
"
    exit 1
fi


curl -o v2.21.0.tar.gz -L https://github.com/git/git/archive/v2.21.0.tar.gz
tar -xvf v2.21.0.tar.gz
(
cd git-*
make prefix=/usr install
)
rm -rf git-*
rm -f v2.21.0.tar.gz
# git config --global credential.helper 'cache --timeout=600000' # 6.94 days
