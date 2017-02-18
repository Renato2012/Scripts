#!/bin/bash

# Renato
# 04/08/2014
#
# Ler a lista com os MACs da rede, e manda pacote mágico para cada MAC.
# Requisitos:
#
# É preciso instalar o pacote wakeonlan.
# Salve os endereços MAC no arquivo mac_list.txt e coloque-o no mesmo diretório deste script.

for mac in $(cat mac_list.txt)
do

    echo -e "Sending packet to MAC:\t $mac \n"
    wakeonlan $mac 1> /dev/null

done


