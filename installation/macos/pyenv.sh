

brew install openssl readline sqlite3 xz zlib
curl https://pyenv.run | bash

echo "export PATH=~/.pyenv/bin:\$PATH
eval \"\$(pyenv init -)\"
eval \"\$(pyenv virtualenv-init -)\"
" >> ~/.zshrc
source ~/.zshrc

# pyenv install --list | grep 3.5
pyenv install --skip-existing 3.5.9
pyenv install --skip-existing 3.6.9
pyenv install --skip-existing 3.7.5
pyenv install --skip-existing 2.7.17
