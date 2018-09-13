#!/bin/bash

echo Starting Update and Orphan Deletion;

if which pacman >/dev/null 2>&1
then
INSTALLER="pacman -Syu";
REMOVER="pacman -Rns $(pacman -Qtdq)"
elif which xbps-install >/dev/null 2>&1
then 
INSTALLER="xbps-install -Su"
REMOVER="xbps-remove -o"
fi


echo -e "\tBegining Update..."
yes | sudo $INSTALLER

echo -e "\tBegining Orphan Deletion"

yes | sudo $REMOVER


echo Update and deletion process complete
echo Press the Any key to continue...

read -n 1
