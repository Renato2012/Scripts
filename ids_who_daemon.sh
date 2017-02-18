#!/bin/bash

# Renato
# Intrusion Detection System


function stop_network() {
    echo "in function"
    sleep 1
    notify-send "Stopping the network!"
    sleep 1
    sudo service networking stop
}

user=$USER

while :
do
    # get all logged users. 
    logged=$(who | cut -d " " -f1)

    #echo $logged > who_daemon.log
    #echo -e $logged

    # see logged users. 
    for usr in $logged
    do

        if [ "$usr" != "$user" ]; then		# if !=
            echo "detected other User - Attacker user is $usr"
            notify-send "Danger - detected invader $usr!"
            
            # call function 
            stop_network
        fi

    done

done

exit 0


