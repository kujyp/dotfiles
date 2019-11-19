# .bashrc

# export HOME=/home/irteam/users/jaeyoung; mkdir -p $HOME; curl https://raw.githubusercontent.com/kujyp/dotfiles/master/installation/linux/centos/.bashrc > $HOME/.bashrc; source $HOME/.bashrc

yellow="\033[0;33m"
red="\033[0;31m"
nocolor="\033[0m"

function info_msg() {
    echo -e "${yellow}[INFO] ${1-}${nocolor}"
}

function error_msg() {
    echo -e "${red}[ERROR] ${1-}${nocolor}"
}

function warning_msg() {
    echo -e "${red}[WARNING] ${1-}${nocolor}"
}

function command_exists() {
    command -v "$@" 1> /dev/null 2>&1
}

function install_pyenv() {
    info_msg "install [pyenv]..."
    curl https://raw.githubusercontent.com/kujyp/dotfiles/master/installation/linux/centos/pyenv.sh > /tmp/pyenv.sh && chmod +x /tmp/pyenv.sh && /tmp/pyenv.sh

    # todo irteam 에서 yum install 실패 후 진입 문제
    if ! command_exists pyenv; then
        export PATH="~/.pyenv/bin:$PATH"
        eval "$(pyenv init -)"
        eval "$(pyenv virtualenv-init -)"
    fi

    info_msg "install [python 3.7.5]..."
    pyenv install --skip-existing 3.7.5
    info_msg "install [python 2.7.15]..."
    pyenv install --skip-existing 2.7.17
}
export -f install_pyenv

function install_git() {
    info_msg "install [git]..."
    curl https://raw.githubusercontent.com/kujyp/dotfiles/master/installation/linux/centos/git.sh > /tmp/git.sh && chmod +x /tmp/git.sh && /tmp/git.sh
}
export -f install_git


# Main
export HOME=/home/irteam/users/jaeyoung
if [[ ! -d "$HOME" ]]; then
    info_msg "mkdir [$HOME]..."
    mkdir -p $HOME
fi

if [[ -f "$(eval echo ~$(whoami))/.bashrc" ]]; then
    source "$(eval echo ~$(whoami))/.bashrc"
fi

if ! command_exists git; then
    info_msg "[git] package not installed.
$ install_git"
fi

# Pyenv
if ! command_exists pyenv; then
    info_msg "[pyenv] package not installed.
$ install_pyenv"
fi

# todo docker
# todo docker pull large images
# todo zsh
