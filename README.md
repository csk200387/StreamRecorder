# StreamRecorder
클라우드 인스턴스에서 구동하는 트위치 스트림 레코더

## 기능
* 스트림 추적기능
* 손실정보를 디스코드 웹훅을 통해 전송
* 구글 드라이브 자동업로드

# setup
```bash
wget https://raw.githubusercontent.com/csk200387/StreamRecorder/main/setup.sh
sudo sh setup.sh
```
아래의 [파일](#required-files) 다운 후 터미널에 입력

# Required files
* ## GDrive Install
  ## [Download Here](https://github.com/glotlabs/gdrive)
  ```bash
  wget https://github.com/glotlabs/gdrive/releases/download/X.X.X/gdrive_linux-x64.tar.gz
  ```

* ## Checker Download
  ## [Download Here](https://github.com/nxwqwer/twitchchecker)
  **recorder.py 와 같은 위치에 저장해야 함**