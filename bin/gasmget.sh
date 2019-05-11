#!/bin/bash
# Script to download the audio from a soundgasm link

#Soundgasm url handler

function soundgasm() {
#Set filename for the soundgasm html page
filename=/tmp/sg-$(basename $1)$(date +%s)

#Get the page
wget $1 -O $filename

if [ -e $(basename $1).m4a  ]; then
  echo "Audio Found!"
  echo "Would you like to redownload $(basename $1)? (y/n)"
  read -r ans

  if [ $ans = 'n' ]; then
		return
    #wget $( grep -ho -E "[^\"]{5,}\.m4a" $filename) -O $(basename $1).m4a
  fi
else
  #Find and download then audio
  wget $( grep -ho -E "[^\"]{5,}\.m4a" $filename) -O $(basename $1).m4a
fi
}

function reddit() {
#Set filename for the reddit html page
filename=/tmp/reddit-$(basename $1)$(date +%s)

wget $1 -O $filename

links=$(grep -Eo "soundgasm.net[[:alnum:]/_-]*" $filename | uniq)

if [ $(echo $filename | wc -l) -gt 1 ]; then
	echo "Multiple links found"
	echo "Download all? (y/n)"
	for i in $links; do
		echo "	$i"
	done
	read -r ans

	if [ $ans = 'n' ]; then
		links=$(echo $links | head -n1 )
	fi
fi
	for i in $links; do
		soundgasm $i
	done
}

if echo $1 | grep "reddit.com"; then
	reddit $@
elif echo $1 | grep "soundgasm.net"; then
	soundgasm $@
fi
