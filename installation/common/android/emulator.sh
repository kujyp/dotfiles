#!/bin/bash -e

yellow="\033[0;33m"
red="\033[0;31m"
nocolor="\033[0m"

function info_msg() {
    echo -e "${yellow}[INFO] $@${nocolor}"
}

function err_msg() {
    echo -e "${red}[ERROR] $@${nocolor}" >&2
}

function echo_os_distribution() {
    if [[ $(uname) == Darwin* ]]; then
        echo macos
        return
    elif [[ $(uname) == Linux* ]]; then
        if [[ -f /etc/lsb-release || -d /etc/lsb-release.d ]]; then
            distribution=$(lsb_release -i | cut -d: -f2 | sed s/'^\t'//)
        else
            distribution=$(. /etc/os-release; echo ${NAME} | cut -f1 -d ' ')
        fi
        echo "$(echo ${distribution} | tr '[:upper:]' '[:lower:]')"
        return
    else
        echo "Unexpected OS"
    fi
}

function command_exists() {
    command -v "$@" 1> /dev/null 2>&1
}


# Main
if command_exists sdkmanager; then
    sdkmanager=$(command -v sdkmanager)
else
    if [[ "$(echo_os_distribution)" == macos ]]; then
        sdkmanager=~/Library/Android/sdk/tools/bin/sdkmanager
    else
        sdkmanager=sdkmanager
    fi
fi

if [[ ! -f "${sdkmanager}" ]]; then
    err_msg "Finding [sdkmanager] failed. [${sdkmanager}]"
    exit 1
fi

info_msg "Sdkmanager [${sdkmanager}] detected."

# sdkmanager --list | grep "x86_64"
${sdkmanager} "emulator"
${sdkmanager} "system-images;android-14;default;armeabi-v7a"
${sdkmanager} "system-images;android-15;google_apis;armeabi-v7a"
${sdkmanager} "system-images;android-16;google_apis;armeabi-v7a"
${sdkmanager} "system-images;android-17;google_apis;armeabi-v7a"
${sdkmanager} "system-images;android-18;default;armeabi-v7a"
${sdkmanager} "system-images;android-18;google_apis;armeabi-v7a"
${sdkmanager} "system-images;android-19;default;armeabi-v7a"
${sdkmanager} "system-images;android-19;google_apis;armeabi-v7a"
#${sdkmanager} "system-images;android-21;default;x86_64"
${sdkmanager} "system-images;android-21;google_apis;x86_64"
#${sdkmanager} "system-images;android-22;default;x86_64"
${sdkmanager} "system-images;android-22;google_apis;x86_64"
#${sdkmanager} "system-images;android-23;default;x86_64"
${sdkmanager} "system-images;android-23;google_apis;x86_64"
#${sdkmanager} "system-images;android-24;default;x86_64"
${sdkmanager} "system-images;android-24;google_apis;x86_64"
#${sdkmanager} "system-images;android-25;default;x86_64"
${sdkmanager} "system-images;android-25;google_apis;x86_64"
#${sdkmanager} "system-images;android-26;default;x86_64"
${sdkmanager} "system-images;android-26;google_apis;x86_64"
${sdkmanager} "system-images;android-27;default;x86_64"
#${sdkmanager} "system-images;android-28;default;x86_64"
#${sdkmanager} "system-images;android-28;google_apis;x86_64"
${sdkmanager} "system-images;android-28;google_apis_playstore;x86_64"
#${sdkmanager} "system-images;android-29;default;x86_64"
#${sdkmanager} "system-images;android-29;google_apis;x86_64"
${sdkmanager} "system-images;android-29;google_apis_playstore;x86_64"
