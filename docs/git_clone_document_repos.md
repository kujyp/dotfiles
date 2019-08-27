```bash
mkdir -p ~/workspace/documents
cd ~/workspace/documents

git clone https://github.com/kujyp/dotfiles
git clone https://github.com/kujyp/private_documents
git clone https://github.com/kujyp/snippets
git clone https://github.com/kujyp/kujyp.github.io

(crontab -l; echo "0 * * * * ~/workspace/documents/dotfiles/scripts/crontab_hourly.sh") | crontab -
sudo crontab -e -u $(whoami)

pycharm .
```
