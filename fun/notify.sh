#!/bin/bash
#
# Schedule a time and you will be notified when the current time is the scheduled time.
#
# Renato Araújo, in June 22 2020. 
#

read -p "Type exact hour and minute (hh:mm formart). " hhmm

STOP=false

while :
do
    if [ `date +%H:%M` = "$hhmm" ]
    then
        notify-send "Attention $USER the cuurent time is $hhmm!"
        spd-say "$USER your task is now."
        STOP=true
    elif $STOP
    then
        echo "Breaking"
        break # stopping script.
        exit 0
    fi
    sleep 10 # sleep every 30 seconds.
done

echo "end"

