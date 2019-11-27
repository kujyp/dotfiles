#!/bin/bash -e

# curl https://raw.githubusercontent.com/kujyp/dotfiles/master/scripts/crontab_hourly.sh | bash
yellow="\033[0;33m"
red="\033[0;31m"
nocolor="\033[0m"

function info_msg() {
    echo -e "${yellow}[INFO] $@${nocolor}"
}

function err_msg() {
    echo -e "${red}[ERROR] $@${nocolor}" >&2
}

function git_pull_and_commit_and_push() {
    git pull

    if [[ ! -z "$(git status --porcelain)" ]]; then
        git add .
        git commit -m "$(git status --short)"
    else
        info_msg "No changes. Skip git commit..."
    fi

    git push
}


# Main
info_msg "[${BASH_SOURCE[0]}] ..."

(
cd ~/workspace/documents
if [[ -f .idea/documents.iml ]]; then
    (
    cd dotfiles/scripts
    mkdir -p document/.idea
    )
    cp .idea/documents.iml dotfiles/scripts/document/.idea/documents.iml
fi
)

(
info_msg "dotfiles..."
cd ~/workspace/documents/dotfiles
git_pull_and_commit_and_push
)

(
info_msg "private_documents..."
cd ~/workspace/documents/private_documents
git_pull_and_commit_and_push
)

(
info_msg "snippets..."
cd ~/workspace/documents/snippets
git_pull_and_commit_and_push
)
info_msg "[${BASH_SOURCE[0]}] done."
