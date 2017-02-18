#!/bin/bash

# Renato
# 01/10/2014
#
# Liga, desliga e reinicia máquinas da rede remotamente.
#
# Requisitos:
# - IPs salvos no arquivo - ip_list.txt;
# - MACs salvos no arquivo - mac_list.txt;
#
# Deve está instalado:
# - sshpass;
# - wakeonlan;

function turn_on() {
    begin=0
    qtd_host=$1

    for mac in $(cat mac_list.txt)
    do
        if [ $begin -lt $qtd_host ] &> /dev/null; then
            echo -e "Sending packet to MAC:\t $mac \n"
            wakeonlan $mac &> /dev/null
            begin=$(expr $begin + 1)
        fi   
    done
}

function turn_off () {
    read -p "Enter with remote adm login: " remote_adm
    read -s -p "Enter with remote adm password: " passwd_adm
    echo -e "\n"
    read -p "Turn off all machines? [y/n] " off_all
    
    if [[ "$off_all" == y || "$off_all" == Y ]]; then
        for ip in $(cat ip_list.txt)
        do    
            sshpass -p $passwd_adm ssh $remote_adm@$ip "echo $passwd_adm | sudo -S shutdown -h now" &> /dev/null
            echo -e "Turn off the host $ip \n"
        done

    elif [[ "$off_all" == n || "$off_all" == N ]]; then
        read -p "Enter the IP address: " ip
        sshpass -p $passwd_adm ssh $remote_adm@$ip "echo $passwd_adm | sudo -S shutdown -h now" &> /dev/null
        echo -e "Turn off the host $ip \n"

    else
       echo "Enter y or n!"
       exit 0
    fi
}

function restarting() { 
    read -p "Enter the remote admin login: " remote_adm
    read -s -p "Enter the remote admin password: " passwd_adm
    echo -e "\n"
    read -p "Enter the IP: " ip

    sshpass -p $passwd_adm ssh $remote_adm@$ip "echo $passwd_adm | sudo -S reboot" &> /dev/null 

    echo -e "Restarting host $ip \n"
}

function helper() {
    helper="Usage: 
           to turn_on:		$0 p <Number of machines to connect>
           to turn_off:		$0 s
           to restarting:	$0 r"
    
    echo "$helper"
}

option=$1
qtd_host=$2

case $option in
p) turn_on $qtd_host ;;
s) turn_off ;;
r) restarting ;;
*) helper ;;

esac

exit 0

