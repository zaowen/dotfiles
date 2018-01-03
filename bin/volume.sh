#!/bin/zsh
zmodload zsh/mathfunc
VOL=$(amixer get Master | grep -m 1 -o -e "[[:digit:]]*%" | grep -o -e "[[:digit:]]*")
MUTE=$(amixer get Master |grep -o -e '\[on\]' | head -1 )

#echo $VOL
#echo $MUTE


if [[ "$MUTE" == "[on]" ]]; then
    if [[ "$VOL" -gt "50" ]]; then
	echo  $VOL
    else
        echo  $VOL
    fi
else
    echo 
fi
