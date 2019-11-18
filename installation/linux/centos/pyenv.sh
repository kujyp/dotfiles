#!/bin/bash -e

# curl https://raw.githubusercontent.com/kujyp/dotfiles/master/installation/linux/centos/pyenv.sh | bash
curl https://pyenv.run | bash

echo "export PATH=\"~/.pyenv/bin:\$PATH\"
eval \"\$(pyenv init -)\"
eval \"\$(pyenv virtualenv-init -)\"
" >> ~/.bashrc

source ~/.bashrc
pyenv install 3.6.7
