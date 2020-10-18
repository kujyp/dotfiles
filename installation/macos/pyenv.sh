

brew install openssl readline sqlite3 xz zlib
curl https://pyenv.run | bash

echo "export PATH=~/.pyenv/bin:\$PATH
eval \"\$(pyenv init -)\"
eval \"\$(pyenv virtualenv-init -)\"
" >> ~/.zshrc
source ~/.zshrc

# pyenv install --list | grep 3.5
pyenv install --skip-existing $(pyenv install --list | grep -E '^\s*3.5' | tail -n1)
pyenv install --skip-existing $(pyenv install --list | grep -E '^\s*3.6' | tail -n1)
pyenv install --skip-existing $(pyenv install --list | grep -E '^\s*3.7' | tail -n1)
pyenv install --skip-existing $(pyenv install --list | grep -E '^\s*3.8' | tail -n1)
pyenv install --skip-existing $(pyenv install --list | grep -E '^\s*2.7' | tail -n1)
