#!/bin/bash

# 루트 권한으로 실행
if [[ $EUID -ne 0 ]]; then
  echo "이 스크립트는 루트 권한으로 실행되어야 합니다." 
  exit 1
fi

# 패키지 업데이트 및 streamlink 설치
sudo apt -y -qq update
sudo apt -y -qq upgrade
sudo apt-key adv -q --keyserver keyserver.ubuntu.com --recv-keys 648ACFD622F3D138 0E98404D386FA1D9
sudo add-apt-repository -q "deb http://deb.debian.org/debian bullseye-backports main"
sudo apt -y -qq update
sudo apt -y -t -qq bullseye-backports install streamlink

# 필수 패키지 설치
sudo apt -y -qq install screen
sudo apt -y -qq install python-pip
pip3 install requests -q
pip3 install pytz -q
pip3 install datetime -q

# twitchChecker 다운로드 및 gdrive 설치
sudo wget "https://raw.githubusercontent.com/csk200387/StreamRecorder/main/twitchChecker" -P /usr/local/bin
sudo wget "https://raw.githubusercontent.com/csk200387/StreamRecorder/main/screen.sh"
wget "https://github.com/glotlabs/gdrive/releases/download/3.8.0/gdrive_linux-x64.tar.gz"
wget "https://raw.githubusercontent.com/csk200387/StreamRecorder/main/recorder.py"
chmod +x /usr/local/bin/twitchChecker
chmod +x screen.sh
tar -zxvf "gdrive_linux-x64.tar.gz"
rm "gdrive_linux-x64.tar.gz"
sudo mv gdrive /usr/local/bin
rm setup.sh
echo "term screen-256color" > ~/.screenrc
echo "run \"./screen.sh\""