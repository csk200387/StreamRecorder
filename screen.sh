#!/bin/bash

# 녹화할 스트리머 리스트
streamers=("woowakgood" "vo_ine" "jingburger" "lilpaaaaaa" "cotton__123" "gosegugosegu" "viichan6")

for streamer in "${my_array[@]}";
do
    screen -dmS $item
    screen -S $item -X stuff "python3 ~/recorder.py ${streamer[i]}$(printf \\r)"
done