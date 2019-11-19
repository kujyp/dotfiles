# .bashrc

# export HOME=/home/irteam/users/jaeyoung; mkdir -p $HOME; curl https://raw.githubusercontent.com/kujyp/dotfiles/master/installation/linux/centos/.bashrc > $HOME/.bashrc; source $HOME/.bashrc
# init_statements="export HOME=$remote_home; if [[ ! -f ~/.bashrc ]]; then curl https://raw.githubusercontent.com/kujyp/dotfiles/master/installation/linux/centos/.bashrc > \$HOME/.bashrc; fi; source \$HOME/.bashrc"
function bashrc_info_msg() {
    echo -e "\033[0;33m[INFO] ${1-}\033[0m"
}
export -f bashrc_info_msg

function bashrc_error_msg() {
    echo -e "\033[0;31m[ERROR] ${1-}\033[0m"
}
export -f bashrc_error_msg

function bashrc_warning_msg() {
    echo -e "\033[0;31m[WARNING] ${1-}\033[0m"
}
export -f bashrc_warning_msg

function bashrc_command_exists() {
    command -v "$@" 1> /dev/null 2>&1
}
export -f bashrc_command_exists

function install_pyenv() {
    bashrc_info_msg "install [pyenv]..."
    curl https://raw.githubusercontent.com/kujyp/dotfiles/master/installation/linux/centos/pyenv.sh > /tmp/pyenv.sh && chmod +x /tmp/pyenv.sh && /tmp/pyenv.sh
    rm -f /tmp/pyenv.sh

    if [[ ! -f ~/.pyenv/bin/pyenv ]]; then
        bashrc_error_msg "[pyenv] installation failed."
        return
    fi

    if ! bashrc_command_exists pyenv; then
        export PATH="~/.pyenv/bin:$PATH"
        eval "$(pyenv init -)"
        eval "$(pyenv virtualenv-init -)"
    fi

    bashrc_info_msg "install [python 3.7.5]..."
    pyenv install --skip-existing 3.7.5
    bashrc_info_msg "install [python 2.7.15]..."
    pyenv install --skip-existing 2.7.17
}
export -f install_pyenv

function install_git() {
    bashrc_info_msg "install [git]..."
    curl https://raw.githubusercontent.com/kujyp/dotfiles/master/installation/linux/centos/git.sh > /tmp/git.sh && chmod +x /tmp/git.sh && /tmp/git.sh
    rm -f /tmp/git.sh
}
export -f install_git

function echo_large_docker_images() {
    echo "\
registry.navercorp.com/mtengine/cuda_python_base:cuda9.0_cudnn7.3_python3.6.7
registry.navercorp.com/mtengine/cuda_python_base:cuda10.0_cudnn7.3_python3.6.7
registry.navercorp.com/mtengine/mttok:python3.6.7
registry.navercorp.com/mtengine/mttrain:2.2.0rc6
"
}
export -f echo_large_docker_images

function large_docker_image_pulled() {
    for each in $(echo_large_docker_images); do
        if [[ -z $(docker images --filter=reference="${each}" --format="{{.Repository}}:{{.Tag}}") ]]; then
            false
            return
        fi
    done
    true
}

function install_docker_pull() {
    for each in $(echo_large_docker_images); do
        docker pull "${each}"
    done
}
export -f install_docker_pull

function install_zsh_help() {
    bashrc_info_msg "$ sudo yum install -y zsh
$ echo -e \"\\n# zsh\\nif [[ -f ~/.bashrc ]]; then\\n    source ~/.bashrc\\nfi\\n\" >> ~/.zshrc
$ install_ohmyzsh_help"
}
export -f install_zsh_help

function install_ohmyzsh_help() {
    install_zsh_help
    bashrc_info_msg "$ install_ohmyzsh_help
echo 'y' | sh -c \"\$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)\"

git clone https://github.com/zsh-users/zsh-autosuggestions \${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git \${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
git clone https://github.com/agkozak/zsh-z \${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-z
git clone https://github.com/zsh-users/zsh-completions \${ZSH_CUSTOM:=~/.oh-my-zsh/custom}/plugins/zsh-completions

sed -i -e \"s/^plugins.*/plugins=(git z zsh-syntax-highlighting zsh-autosuggestions)/\" ~/.zshrc
sed -i -e \"s/^ZSH_THEME.*/ZSH_THEME=\"\"/\" ~/.zshrc

curl --silent --location https://dl.yarnpkg.com/rpm/yarn.repo | sudo tee /etc/yum.repos.d/yarn.repo
sudo rpm --import https://dl.yarnpkg.com/rpm/pubkey.gpg
sudo yum install -y yarn

yarn global add pure-prompt
echo -e \"\n# Pure\nautoload -U promptinit; promptinit\nprompt pure\" >> ~/.zshrc
"
}
export -f install_ohmyzsh_help


# Main
export HOME=/home/irteam/users/jaeyoung
if [[ ! -d "$HOME" ]]; then
    bashrc_info_msg "mkdir [$HOME]..."
    mkdir -p $HOME
fi

if [[ -f "$(eval echo ~$(whoami))/.bashrc" ]]; then
    source "$(eval echo ~$(whoami))/.bashrc"
fi


# git
if ! bashrc_command_exists git; then
    bashrc_info_msg "[git] package not installed.
$ install_git"
fi


# pyenv
if [[ -f ~/.pyenv/bin/pyenv ]]; then
    export PATH="~/.pyenv/bin:$PATH"
    eval "$(pyenv init -)"
    eval "$(pyenv virtualenv-init -)"
fi
if ! bashrc_command_exists pyenv; then
    bashrc_info_msg "[pyenv] package not installed.
$ install_pyenv"
fi


# docker
if ! bashrc_command_exists docker; then
    bashrc_info_msg "[docker] package not installed.
$ curl -sL http://mtdependency.navercorp.com/static/packages/install_docker_and_nvidia_docker-0.5.0.sh | sudo bash"
fi

if bashrc_command_exists docker; then
    if ! large_docker_image_pulled; then
        bashrc_info_msg "[large docker images] not pulled.
$ install_docker_pull"
    fi
fi


# zsh
if ! bashrc_command_exists zsh; then
    bashrc_info_msg "[zsh] package not installed."
    install_zsh_help
fi

if bashrc_command_exists zsh; then
    if [[ ! -d ~/.oh-my-zsh ]]; then
        bashrc_info_msg "[oh-my-zsh] not installed."
        install_ohmyzsh_help
    fi
fi
