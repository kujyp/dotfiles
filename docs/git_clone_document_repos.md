```bash
mkdir -p ~/workspace/documents
cd ~/workspace/documents

git clone https://github.com/kujyp/dotfiles
git clone https://github.com/kujyp/private_documents
git clone https://github.com/kujyp/snippets
git clone https://github.com/kujyp/kujyp.github.io

(crontab -l; echo "0 * * * * ~/workspace/documents/dotfiles/scripts/crontab_hourly.sh") | crontab -
sudo su

git config --global user.email swe.jaeyoungpark@navercorp.com
git config --global user.name "kujyp"
(
cd /Users/jaeyoung/workspace/documents/private_documents
git fetch origin
)

pycharm .
```
