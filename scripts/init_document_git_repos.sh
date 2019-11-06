#!/bin/bash -e

# curl https://raw.githubusercontent.com/kujyp/dotfiles/master/scripts/init_document_git_repos.sh | bash
(
cd /tmp
if [[ ! -d private_documents ]]; then
    git clone https://github.com/kujyp/private_documents
fi
mkdir -p ~/.ssh
cp private_documents/keys/macbook_sshkeyfile_190826/id_rsa ~/.ssh/
cp private_documents/keys/macbook_sshkeyfile_190826/id_rsa.pub ~/.ssh/
chmod 0400 ~/.ssh/id_rsa
chmod 0400 ~/.ssh/id_rsa.pub

if ! grep -q "github.com" ~/.ssh/known_hosts; then
  ssh-keyscan -t rsa "github.com,$(dig +short github.com)" >> ~/.ssh/known_hosts
fi
)


mkdir -p ~/workspace/documents
cd ~/workspace/documents

if [[ ! -d dotfiles ]]; then
    git clone git@github.com:kujyp/dotfiles.git
fi
if [[ ! -d private_documents ]]; then
    git clone git@github.com:kujyp/private_documents.git
fi
if [[ ! -d snippets ]]; then
    git clone git@github.com:kujyp/snippets.git
fi
if [[ ! -d "kujyp.github.io" ]]; then
    git clone git@github.com:kujyp/kujyp.github.io.git
fi

(
crontab -l | grep -v crontab_hourly.sh
echo "0 * * * * ~/workspace/documents/dotfiles/scripts/crontab_hourly.sh"
) | crontab -

pycharm .
curl -o .idea/documents.iml https://raw.githubusercontent.com/kujyp/dotfiles/master/scripts/document/.idea/documents.iml
