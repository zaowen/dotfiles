#!/bin/bash
# Update script that in theory works on Void and Arch.

echo Starting Update and Orphan Deletion;

if which pacman > /dev/null;
then
INSTALLER="pacman -Syu";
REMOVER="pacman -Rns $(pacman -Qtdq)"
elif which xbps-install > /dev/null;
then 
INSTALLER="xbps-install -Su"
REMOVER="xbps-remove -o"
fi


echo "\tBegining Update..."
yes | sudo $INSTALLER

echo "\tBegining Orphan Deletion"

yes | sudo $REMOVER


echo Update and deletion process complete
echo Press the Any key to continue...

read -n 1
