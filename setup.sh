#!/bin/bash

# 루트 권한으로 실행
if [[ $EUID -ne 0 ]]; then
  echo "이 스크립트는 루트 권한으로 실행되어야 합니다." 
  exit 1
fi

# 패키지 업데이트 및 streamlink 설치
sudo apt -y -qq update >/dev/null 2>&1
echo "apt updating..."
sudo apt -y -qq upgrade >/dev/null 2>&1
echo "apt upgrading..."
sudo apt-key adv -q --keyserver keyserver.ubuntu.com --recv-keys 648ACFD622F3D138 0E98404D386FA1D9 >/dev/null 2>&1
sudo add-apt-repository -y "deb http://deb.debian.org/debian bullseye-backports main" >/dev/null 2>&1
echo "adding apt repository..."
sudo apt -y -qq update >/dev/null 2>&1
sudo apt -y -t -qq bullseye-backports install streamlink >/dev/null 2>&1
echo "streamlink install success"

# 필수 패키지 설치
sudo apt -y -qq install screen >/dev/null 2>&1
echo "screen install success"
sudo apt -y -qq install python-pip >/dev/null 2>&1
pip3 install requests -q
pip3 install pytz -q
pip3 install datetime -q
echo "python module install success" 

wget -q "https://raw.githubusercontent.com/csk200387/StreamRecorder/main/recorder.py"
echo "recorder.py download success"
wget -q "https://raw.githubusercontent.com/csk200387/StreamRecorder/main/screen.sh"
echo "screen.sh download success"
wget -q "https://raw.githubusercontent.com/csk200387/StreamRecorder/main/config.json"
echo "config.json download success" 
chmod +x screen.sh
tar -zxvf "gdrive_linux-x64.tar.gz" >/dev/null 2>&1
echo "unzip gdrive...."
rm "gdrive_linux-x64.tar.gz"
sudo mv gdrive /usr/local/bin
rm setup.sh
echo "setupfiles remove success"
echo "term screen-256color" > ~/.screenrc
echo -e "\e[34mDone!\e[0m"
echo -e "\e[32mPlease enter your token and information in config.json, and run \"./screen.sh\" to start recording.\e[0m"