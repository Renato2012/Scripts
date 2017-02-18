#!/bin/bash

# Renato

# faz SO mostrar notificação
notify-send "Bem vindo ao programa $USER"

vert='|'
incDir='/'
horiz='_'
incEsq='\'

echo -ne "\tLoading .................................... "

for i in $(seq 1 100)
do

    for j in $vert $incDir $horiz $incEsq
    do 
        echo -ne '\033[53G'
        echo -n "$j  $i%"
        sleep 0.4
    done

done

echo "Finished"
echo -e

