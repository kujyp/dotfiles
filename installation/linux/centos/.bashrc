# .bashrc

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


# Main
export HOME=/home/irteam/users/jaeyoung

if [[ -f "$(eval echo ~$USER)/.bashrc" ]]; then
    source "$(eval echo ~$USER)/.bashrc"
fi

if ! command_exists pyenv; then
    info_msg "install [pyenv]..."
    curl https://raw.githubusercontent.com/kujyp/dotfiles/master/installation/linux/centos/pyenv.sh | bash
fi
