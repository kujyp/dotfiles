#!/bin/bash -e

# curl https://raw.githubusercontent.com/kujyp/dotfiles/master/installation/linux/centos/pyenv.sh > /tmp/pyenv.sh && chmod +x /tmp/pyenv.sh && /tmp/pyenv.sh

function error_msg() {
    echo -e "\033[0;31m[ERROR] ${1-}\033[0m"
}


# yum installation to remove these errors, warnings above.
#WARNING: The Python bz2 extension was not compiled. Missing the bzip2 lib?
#WARNING: The Python readline extension was not compiled. Missing the GNU readline lib?
#WARNING: The Python sqlite3 extension was not compiled. Missing the SQLite3 lib?
#ERROR: The Python ssl extension was not compiled. Missing the OpenSSL lib?
yum_packages="zlib-devel openssl-devel sqlite-devel readline-devel bzip2-devel"
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


curl https://pyenv.run | bash

echo "export PATH=\"~/.pyenv/bin:\$PATH\"
eval \"\$(pyenv init -)\"
eval \"\$(pyenv virtualenv-init -)\"
" >> ~/.bashrc
