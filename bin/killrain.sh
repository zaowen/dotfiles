#/bin/bash

ps -ef | grep rain | awk '{print $2}' | xargs kill -9
ps -ef | grep aplay | awk '{print $2}' | xargs kill -9
