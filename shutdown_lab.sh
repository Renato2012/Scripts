#!/bin/bash

# Renato
# 15/08/2014 Ultima atualização

# Script que desliga todas as máquinas remotamente.
#
# Requisitos:
# É preciso ter o sshpass instalado.
# Salve os endereços IPs da máquinas que serão desligadas no arquivo ip_list.txt, e coloque-o no mesmo diretório deste script.

read -p "Enter the remote user: " user
echo "Enter the password of the remote user: "
read -s password

for ip in $(cat ip_list.txt)
do

    sshpass -p "$password" ssh $user@$ip "echo $password |sudo -S shutdown -h now"

done


