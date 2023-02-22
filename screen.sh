#!/bin/bash

streamer=("woowakgood" "vo_ine" "jingburger" "lilpaaaaaa" "cotton__123" "gosegugosegu" "viichan6")

for i in {0..6}
do
    screen -dmS ${streamer[i]}
    screen -S ${streamer[i]} -X stuff "python3 ~/recorder.py ${streamer[i]}$(printf \\r)"
done