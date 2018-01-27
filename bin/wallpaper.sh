#!/bin/bash

#killall -q wallpaper.sh
for p in $(pgrep $(basename $0)); do
   if [[ ! $$ == $p ]]; then
      kill -9 $p
   fi
done

PAPER=$(find /home/zao/Pictures/.w/ -type f \( -name '*.jpg' -o -name '*.png' \) -print0 | shuf -n1 -z)

#find /home/khan/Pictures/.w/ -type f \( -name '*.jpg' -o -name '*.png' \) -print0 | shuf -n1 -z | xargs -0 feh --bg-fill

while true;
do
	feh "$PAPER" --bg-fill
      sleep 30m
done
