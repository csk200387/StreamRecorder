import json

with open("config.json", "r") as f :
    config = json.loads(f.read())

print(config['TWITCH_OAUTH_TOKEN'])
print(config['TWITCH_BEARER_TOKEN'])
print(config['TWITCH_CLIENT_ID'])
print(config['GDRIVE_FILE_ID'])
print(config['DISCORD_WEBHOOK_URL'])
print(config['PERIOD'])