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

function has_yum_package_installed {
    yum list installed "$@" >/dev/null 2>&1
}

function has_yum_packages_installed {
    for each in $@; do
        if ! has_yum_package_installed "${each}"; then
            false
            return
        fi
    done
    true
}

function install_zsh() {
    bashrc_info_msg "install [zsh]..."

    if ! has_yum_packages_installed "zsh yarn"; then
        bashrc_error_msg "install zsh, yarn first
$ yum install -y zsh yarn"
        return
    fi
    curl https://raw.githubusercontent.com/kujyp/dotfiles/master/installation/linux/centos/zsh.sh > /tmp/zsh.sh && chmod +x /tmp/zsh.sh && /tmp/zsh.sh
    rm -f /tmp/git.sh
}
export -f install_zsh


# Main
export HOME=/home/irteam/users/jaeyoung
if [[ ! -d "$HOME" ]]; then
    bashrc_info_msg "mkdir [$HOME]..."
    mkdir -p $HOME
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
if ! bashrc_command_exists zsh || [[ ! -d ~/.oh-my-zsh ]]; then
    bashrc_info_msg "[zsh] or [oh-my-zsh] package not installed.
$ install_zsh"
fi
