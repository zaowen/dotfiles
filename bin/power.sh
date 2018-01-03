#!/bin/bash
POWER=$(upower -i /org/freedesktop/UPower/devices/line_power_AC |grep online |grep -o "[[:alpha:]]*$" )

PERCENT=$(upower -i /org/freedesktop/UPower/devices/DisplayDevice | grep -o '[[:digit:]]*\.*[[:digit:]]*%' | grep -o '^[[:digit:]]*')

DISPLAY=$(upower -i /org/freedesktop/UPower/devices/DisplayDevice | grep -o '[[:digit:]]*\.*[[:digit:]]*%' )

#DISPLAY=${DISPLAY::-3}
#DISPLAY=$(echo 2 k $PERCENT 100 90 \/ \*  p | dc )


if [[ "$POWER" == "yes" ]]; then
	echo \ \  $DISPLAY
else
	if [[ "$PERCENT" -ge "90" ]]; then
		echo -n  \ $DISPLAY
	else
		if [[ "$PERCENT" -ge "60" ]]; then
			echo -n   \ \ $DISPLAY
		else
			if [[ "$PERCENT" -ge "35" ]]; then
				echo -n   \ \ $DISPLAY
			else
				if [[ "$PERCENT" -ge "15" ]]; then
					echo -n   \ \ $DISPLAY
				else
					echo -n   \ \ $DISPLAY
					#fi
				fi
			fi
		fi
	fi

fi


