#!/bin/bash

echo Starting Update and Orphan Deletion;
yes | sudo pacman -Syu 
ORPHANS="$(pacman -Qtdq)"

LEVEL=1;
while [ "$ORPHANS" != "" ]
do
	echo Begining Orphan Search LVL$LEVEL
	yes | sudo pacman -Rns $ORPHANS;
	ORPHANS=$(pacman -Qtdq)
	LEVEL=$((LEVEL+1))
 done

echo Update and deletion process complete
echo Press the Any key to continue...

read -n 1
