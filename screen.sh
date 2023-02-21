#!/bin/bash

streamer=("woowakgood" "vo_ine" "jingburger" "lilpaaaaaa" "cotton__123" "gosegugosegu" "viichan6")
# 7개의 screen 세션을 만듭니다.
for i in {0..2}
do
    screen -dmS ${streamer[i]}
    screen -S ${streamer[i]} -X stuff "python3 ~/TwitchStreamRecorder/notepadd.py ${streamer[i]}$(printf \\r)"
done