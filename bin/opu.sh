#!/usr/bin/bash
# Script to convert all mp3 files in $1 to .opus files
# Does 5 jobs at a time

#Makes it so the feild seperator in for loops is newline not space
IFS=$'\n'

#For everything in $1 with the type .mp3
for i in $(find "${1}" -type f -name "*.mp3" );
do
  # If an opus does not already exist then start a job to convert it
  if [ ! -e "${i%%.mp3}".opus ]; then
    ffmpeg -i "${i}" ${i%%.mp3}.opus &
  fi
# Check how many jobs we have running. Don't do too many. that was a bad afternoon
  if [ $(jobs | wc -l) -gt 5 ]; then
    wait
  fi
done
# Wait for all jobs to complete before exiting
while [ -n "$(jobs)"];
do wait;
done
