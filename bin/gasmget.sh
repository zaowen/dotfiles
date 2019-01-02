#!/bin/bash
# Script to download the audio from a soundgasm link

#Set filename for the soundgasm page
filename=/tmp/$(basename $1)$(date +%s)

#Get the page
wget $1 -O $filename
#Find and download then audio
wget $( grep -ho -E "[^\"]{5,}\.m4a" $filename) -O $(basename $1).m4a


