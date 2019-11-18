#!/bin/bash -e

# curl https://raw.githubusercontent.com/kujyp/dotfiles/master/installation/linux/centos/git.sh > /tmp/git.sh && chmod +x /tmp/git.sh && /tmp/git.sh
curl -o v2.21.0.tar.gz -L https://github.com/git/git/archive/v2.21.0.tar.gz

yum_packages="make gcc openssl-devel curl-devel expat-devel gettext-devel"
yum install -y \
 "${yum_packages}" \
 && rm -rf /var/cache/yum

if [[ "$?" -ne 0 ]]; then
    echo "yum install failed.
$ yum install -y ${yum_packages}
"
    exit 1
fi

tar -xvf v2.21.0.tar.gz
(
cd git-*
make prefix=/usr install
)
rm -rf git-*
rm -f v2.21.0.tar.gz
