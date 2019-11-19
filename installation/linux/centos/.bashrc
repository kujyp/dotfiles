# .bashrc

# export HOME=/home/irteam/users/jaeyoung; mkdir -p $HOME; curl https://raw.githubusercontent.com/kujyp/dotfiles/master/installation/linux/centos/.bashrc > $HOME/.bashrc; source $HOME/.bashrc

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

    # todo irteam 에서 yum install 실패 후 진입 문제
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
}
export -f install_git


# Main
export HOME=/home/irteam/users/jaeyoung
if [[ ! -d "$HOME" ]]; then
    bashrc_info_msg "mkdir [$HOME]..."
    mkdir -p $HOME
fi

if [[ -f "$(eval echo ~$(whoami))/.bashrc" ]]; then
    source "$(eval echo ~$(whoami))/.bashrc"
fi

if ! bashrc_command_exists git; then
    bashrc_info_msg "[git] package not installed.
$ install_git"
fi

# Pyenv
if ! bashrc_command_exists pyenv; then
    bashrc_info_msg "[pyenv] package not installed.
$ install_pyenv"
fi

# todo docker
# todo docker pull large images
# todo zsh
