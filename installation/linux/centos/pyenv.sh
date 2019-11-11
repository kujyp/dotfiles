#!/bin/bash -e

curl https://pyenv.run | bash
pyenv update

export PATH="/home1/irteam/.pyenv/bin:$PATH"
eval "$(pyenv init -)"
eval "$(pyenv virtualenv-init -)"
