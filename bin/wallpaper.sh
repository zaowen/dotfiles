#!/bin/bash

# Capture SIGUSR1
trap 'handleSig' 10
trap 'handleSig' 30
trap 'handleSig' 16

handleSig(){
  getwall
  echo derp
}

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
  echo getwall
  PAPER=$(find /home/zao/Pictures/$DIR/ -type f \( -name '*.jpg' -o -name '*.png' \)  | shuf -n1 )
}

setwall(){
  echo setwall
  OLDLOC=$LOC
  feh "$PAPER" --bg-fill

  checkwifi
  if [[ ! $OLDLOC == $LOC ]]; then
    getwall
  fi
}

#killall -q wallpaper.sh
for p in $(pgrep $(basename $0)); do
  if [[ ! $$ == $p ]]; then
    kill -9 $p
  fi
done

DIR=.w
TIMEOUT=5s
LOC=1

checkwifi
getwall

while true;
do
  setwall
  sleep $TIMEOUT &
  wait $!
done

