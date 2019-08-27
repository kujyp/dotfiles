#!/bin/bash -e

function git_commit_and_push() {
    git add .
    git commit -m "$(git status --short)"
    git push
}

(
cd ~/workspace/documents/dotfiles
git_commit_and_push
)

(
cd ~/workspace/documents/private_documents
git_commit_and_push
)

(
cd ~/workspace/documents/snippets
git_commit_and_push
)
