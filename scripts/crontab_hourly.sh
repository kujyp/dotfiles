#!/bin/bash -e

yellow="\033[0;33m"
red="\033[0;31m"
nocolor="\033[0m"

function info_msg() {
    echo -e "${yellow}[INFO] $@${nocolor}"
}

function err_msg() {
    echo -e "${red}[ERROR] $@${nocolor}" >&2
}

function git_commit_and_push() {
    git add .
    git commit -m "$(git status --short)"
    git push
}


# Main
info_msg "[${BASH_SOURCE[0]}] ..."
(
info_msg "dotfiles..."
cd ~/workspace/documents/dotfiles
git_commit_and_push
)

(
info_msg "private_documents..."
cd ~/workspace/documents/private_documents
git_commit_and_push
)

(
info_msg "snippets..."
cd ~/workspace/documents/snippets
git_commit_and_push
)
info_msg "[${BASH_SOURCE[0]}] done."
