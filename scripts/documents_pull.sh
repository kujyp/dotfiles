#!/bin/bash -e

# curl https://raw.githubusercontent.com/kujyp/dotfiles/master/scripts/documents_pull.sh | bash

yellow="\033[0;33m"
red="\033[0;31m"
nocolor="\033[0m"

function info_msg() {
    echo -e "${yellow}[INFO] $@${nocolor}"
}

function err_msg() {
    echo -e "${red}[ERROR] $@${nocolor}" >&2
}


cd ~/workspace/documents
for each_dir in $(ls -d */); do
    (
    info_msg "[${each_dir}]..."
    cd "${each_dir}"
    git pull
    )
done
