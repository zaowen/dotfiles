#/bin/bash

ps -ef | grep jazz | awk '{print $2}' | xargs kill -9
ps -ef | grep coffee | awk '{print $2}' | xargs kill -9
