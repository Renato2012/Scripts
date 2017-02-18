#!/bin/bash

# Renato
#
# 02/2017
#
# Point bar

# faz SO mostrar notificação
notify-send "Bem vindo $USER"

for i in $(seq 1 100)
do
    echo -n "Loading "

    for j in $(seq 1 50)
    do 
        # j='.'
        echo -n "."	# print on the same line.
        sleep 0.0001
    done
    
    sleep 0.1
    echo -n " $i%"	# print on the same line.
    echo -e		# new line.
done

echo -e "Finished"      # new line and print.
echo -e			# new line.

