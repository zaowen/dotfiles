#!/bin/bash

#killall -q wallpaper.sh
for p in $(pgrep $(basename $0)); do
   if [[ ! $$ == $p ]]; then
      kill -9 $p
   fi
done

DIR=.w
TIMEOUT=5s
LOC=1

checkwifi(){
   SSID=$(iw dev wlp2s0 link | grep SSID: | awk -c '{ for( i=2; i <= NF; i++) { printf $i } }')

   if [[ $SSID == "InkandPaperTwin" ]]; then
      DIR=.nsw
      TIMEOUT=5s
      LOC=1
   else
      DIR=.w
      TIMEOUT=1m
      LOC=2
   fi

}

getwall(){
   PAPER=$(find /home/zao/Pictures/$DIR/ -type f \( -name '*.jpg' -o -name '*.png' \) -print0 | shuf -n1 -z)
}

checkwifi
getwall

while true;
do
   OLDLOC=$LOC
   feh "$PAPER" --bg-fill
   sleep $TIMEOUT

   checkwifi
   if [[ ! $OLDLOC == $LOC ]]; then
      echo getting new wall
      getwall
   fi
done
