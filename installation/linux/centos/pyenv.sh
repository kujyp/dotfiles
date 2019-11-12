#!/bin/bash -e

curl https://pyenv.run | bash

echo "export PATH=\"/home1/irteam/.pyenv/bin:\$PATH\"
eval \"\$(pyenv init -)\"
eval \"\$(pyenv virtualenv-init -)\"
" >> ~/.bashrc

source ~/.bashrc
pyenv install 3.6.7
