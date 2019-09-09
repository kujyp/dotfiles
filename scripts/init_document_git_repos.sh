#!/bin/bash

mkdir -p ~/workspace/documents
cd ~/workspace/documents

git clone git@github.com:kujyp/dotfiles.git
git clone git@github.com:kujyp/private_documents.git
git clone git@github.com:kujyp/snippets.git
git clone git@github.com:kujyp/kujyp.github.io.git

(
crontab -l | grep -v crontab_hourly.sh
echo "0 * * * * ~/workspace/documents/dotfiles/scripts/crontab_hourly.sh"
) | crontab -

#git config --global user.email swe.jaeyoungpark@navercorp.com
#git config --global user.name "kujyp"
#(
#cd /Users/jaeyoung/workspace/documents/private_documents
#git fetch origin
#)

pycharm .
