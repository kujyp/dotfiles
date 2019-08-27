#!/bin/bash

yellow="\033[0;33m"
red="\033[0;31m"
nocolor="\033[0m"

# region utility functions
function command_exists() {
    command -v "$@" 1> /dev/null 2>&1
}

function info_msg() {
    echo -e "${yellow}[INFO] ${1-}${nocolor}"
}

function error_msg() {
    echo -e "${red}[ERROR] ${1-}${nocolor}"
}

function warning_msg() {
    echo -e "${red}[WARNING] ${1-}${nocolor}"
}

function with_root_privilege() {
  if [[ "$(id -u)" -ne "0" ]]; then
    sudo $1
  else
    $@
  fi
}
# endregion

function install_homebrew() {
    /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
}

function install_homebrew_if_not_exists() {
    if ! command_exists brew; then
        install_homebrew
    fi
}

function install_with_homebrew() {
    if [[ -z "${1-}" ]]; then
        error_msg "[install_with_homebrew] Empty argument. call function with argument."
        exit 1
    fi

    install_homebrew_if_not_exists
    brew install "$1"
}

function install_with_homebrew_cask() {
    if [[ -z "${1-}" ]]; then
        error_msg "[install_with_homebrew_cask] Empty argument. call function with argument."
        exit 1
    fi

    install_homebrew_if_not_exists
    brew cask install "$1"
}

function install_spectacle() {
    install_with_homebrew_cask "spectacle"
    # Application이 아니라 Utility폴더에 있어야 시작프로그램이 재대로 작동함.
    with_root_privilege "mv /Applications/Spectacle.app /Applications/Utilities/"
}

function install_caffeine() {
    install_with_homebrew_cask "caffeine"
    # Application이 아니라 Utility폴더에 있어야 시작프로그램이 재대로 작동함.
    with_root_privilege "mv /Applications/Caffeine.app /Applications/Utilities/"
}

function install_nosleep() {
    install_with_homebrew_cask "nosleep"
    # Application이 아니라 Utility폴더에 있어야 시작프로그램이 재대로 작동함.
    with_root_privilege "mv /Applications/NoSleep.app /Applications/Utilities/"
}

function install_homebrew_packages() {
    install_with_homebrew "python3"
    install_with_homebrew "tree"
    install_with_homebrew "telnet"
}

function install_homebrew_cask_packages() {
    # java 설치
    install_with_homebrew_cask "homebrew/cask-versions/adoptopenjdk8"
    install_with_homebrew_cask "docker"
    install_with_homebrew_cask "alfred"

    install_with_homebrew_cask "vlc"
    install_with_homebrew_cask "gyazo"
    install_with_homebrew_cask "jandi"
    install_with_homebrew_cask "slack"
    install_with_homebrew_cask "postman"

    open /Applications/docker.app
    open /Applications/alfred.app
    open /Applications/jandi.app
    open /Applications/slack.app
    open /Applications/postman.app
}

function install_appstore_packages() {
    install_with_homebrew "mas"
    mas install 497799835 # Xcode
    mas install 539883307 # line
    mas install 869223134 # kakaotalk
}

function install_android_component_with_sdkmanager() {
    local sdkmanager=~/Library/Android/sdk/tools/bin/sdkmanager

    if [[ -z "${1-}" ]]; then
        error_msg "[install_android_component_with_sdkmanager] Empty argument. call function with argument."
        exit 1
    fi
    echo y | ${sdkmanager} "$1"
}

function install_android_components() {
    install_android_component_with_sdkmanager "build-tools;29.0.2"
    install_android_component_with_sdkmanager "build-tools;28.0.3"
    install_android_component_with_sdkmanager "build-tools;25.0.0"
    install_android_component_with_sdkmanager "cmake;3.6.4111459"
    install_android_component_with_sdkmanager "emulator"
    install_android_component_with_sdkmanager "extras;intel;Hardware_Accelerated_Execution_Manager"
    install_android_component_with_sdkmanager "platforms;android-29"
    install_android_component_with_sdkmanager "system-images;android-25;google_apis;x86_64"
    install_android_component_with_sdkmanager "system-images;android-25;google_apis_playstore;x86"
    install_android_component_with_sdkmanager "platforms;android-28"
    install_android_component_with_sdkmanager "platforms;android-25"
    install_android_component_with_sdkmanager "platforms;android-17"
    install_android_component_with_sdkmanager "sources;android-28"
}
