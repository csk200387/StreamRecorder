import datetime, time, os, subprocess, json, requests, sys, pytz
tz_korea = pytz.timezone('Asia/Seoul')

TWITCH_OAUTH_TOKEN = '' # 광고 제거용 트위치 OAuth토큰
TWITCH_BEARER_TOKEN = ''
TWITCH_CLIENT_ID = ''
GDRIVE_FILE_ID = '' # 구글 드라이브 폴더 ID
DISCORD_WEBHOOK_URL = '' # Checker 결과를 받을 WEBHOOK URL
PERIOD = 1  # 반복 대기 시간 (초)
PATH = r'./'  # 저장 경로
# ------------------------------------------------


def main() :
    username = sys.argv[1]  # 스트리머 ID
    processed_path = os.path.join(PATH, username)
    while True :
        now = datetime.datetime.now(tz_korea).strftime('%Y-%m-%d %Hh%Mm%Ss')
        # filename = ''.join(x for x in f'{username} - {now}.ts' if x.isalnum() or x in ' -_.')
        filename = username+'.ts'
        recorded_filename = os.path.join(processed_path, filename)
        if not os.path.isdir(processed_path) :
            os.makedirs(processed_path)
        subprocess.call(['streamlink', '--twitch-api-header=Authorization=OAuth '+TWITCH_OAUTH_TOKEN,
                        '--stream-segment-threads', '5', '--stream-segment-attempts', '5',
                        '--stream-segment-timeout', '20.0', '--hls-live-restart', '--twitch-disable-hosting',
                        '--twitch-disable-ads', 'twitch.tv/' + username, 'best', '-o', recorded_filename])
        try :
            if os.path.isfile(f'{processed_path}/{filename}') :
                subprocess.call(['twitchChecker', f'{processed_path}/{filename}'])
                checkedfile = filename.replace('.ts', '.txt')
                with open(f'{processed_path}/{checkedfile}', 'r') as f :
                    arr = f.readlines()
                content = ''.join(map(str, arr[:8]+arr[9:]))
                sendHook(username, f'```{content}```')
                Nick, streamTitle = map(str, getUserID(username))
                date = now.split()[0].replace('-', ' ')
                new_filename = ''.join(x for x in f'비디오 {Nick} {date} {streamTitle}.ts' if x.isalnum() or x in ' -_.')
                new_recorded_filename = os.path.join(processed_path, new_filename)
                os.rename(recorded_filename, new_recorded_filename)
                subprocess.call(['gdrive', 'files', 'upload', '--parent', GDRIVE_FILE_ID, new_recorded_filename])
                os.remove(f'{processed_path}/{new_filename}')
                os.remove(f'{processed_path}/{checkedfile}')
            else :
                pass
        except :
            pass
        print(f'{username} 녹화 종료/실패. 오프라인 상태입니다. {PERIOD}초 후에 다시 시도합니다.')
        time.sleep(PERIOD)

def sendHook(sender:str, content:str) :
    headers = {
        'Content-Type' : 'application/json'
    }
    data = {
        'content' : content,
        'username': sender
    }
    data = json.dumps(data)
    requests.post(DISCORD_WEBHOOK_URL, headers=headers, data=data)

def getUserID(loginID:str) :
    headers = {'Authorization': 'Bearer '+TWITCH_BEARER_TOKEN, 'Client-ID': TWITCH_CLIENT_ID}
    req = requests.get('https://api.twitch.tv/helix/users?login='+loginID, headers=headers).json()
    id = req['data'][0]['id']
    nick = req['data'][0]['display_name']
    req = requests.get('https://api.twitch.tv/helix/channels?broadcaster_id='+id, headers=headers).json()
    return [nick, req['data'][0]['title']]

if __name__ == '__main__':
    main()