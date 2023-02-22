sudo apt update
sudo apt upgrade
sudo apt-key adv --keyserver keyserver.ubuntu.com --recv-keys 648ACFD622F3D138 0E98404D386FA1D9
sudo add-apt-repository "deb http://deb.debian.org/debian bullseye-backports main"
sudo apt update
sudo apt -Y -t bullseye-backports install streamlink
sudo apt install screen
sudo apt install python-pip
pip3 install requests
pip3 install pytz
pip3 install datetime
sudo wget "https://github.com/csk200387/StreamRecorder/blob/main/twitchChecker" -P /usr/local/bin
wget "https://github.com/glotlabs/gdrive/releases/download/3.6.0/gdrive_linux-x64.tar.gz"
tar -zxvf gdrive_linux-x64.tar.gz
sudo mv gdrive /usr/local/bin
echo "done!"