#!/bin/bash

# Renato
# 27/08/2014

# Calcula a faixa de IPs, e procura por MACs e IPs na Rede, salvando-os em um arquivo listaDeMACs.txt e listaDeIPs.txt.

function automatico() {
    echo -e "\n\t\t\t Iniciando a procura de MACs e IPs! \n"
    read -p "Digite sua interface de rede: " nic

# Cortar o ip, broadcast e a mascara local.
    IPLocal=$(ifconfig $nic | sed -rn '/([0-9]+\.){3}[0-9]+/p' | sed 's/^.*end.: //' | sed 's/ [Bcast-Masc].*$//')
    echo -e "O ip é \t $IPLocal"

    broadcast=$(ifconfig $nic | sed -rn '/([0-9]+\.){3}[0-9]+/p' | sed 's/^.*Bcast://' | sed 's/ Masc.*$//')
    echo -e "O Broadcast é \t $broadcast"

    masc=$(ifconfig $nic | sed -rn '/([0-9]+\.){3}[0-9]+/p' | sed 's/^.*Masc://')
    echo -e "A mascara é \t $masc"

# Calcular a faixa de IPs, quebro a mascara pelo o ponto.
    octeto=$(echo $masc | sed -e 's/\./\n/g')
    barra=0
    octeto255=0
    for linha in $octeto
    do
        if [ "$linha" = 255 ]; then
            barra=$((barra + 8))
            echo "A Mascára é: $barra"
            octeto255=$(($octeto255 + 1))
            echo "octeto255 e $octeto255"

        elif [ $barra -lt 24 ]; then        # Ver se Mascara é < /24 para encerrar.
            echo -e "\e[31;1m Endereço não suportado, Mascara /16 \033[m"
            exit 0

        elif [ "$linha" = 0 ]; then         # Apenas para não entrar no else.
            echo "linha é zero ($linha)"

# Calcular a subrede.
        else
            soma=0
#        while [ $sequencia -ge 0 ]     # Ordem decrescente de 7 a 0
            for sequencia in $(seq 0 7)     # Ordem crescente de 0 a 7
            do
                result=$(expr $linha / 2)
                resto=$(expr $linha % 2)
                echo "o Resultado da divisão, e o resto são: $result, $resto"
                linha=$result

                echo "a sequencia é: $sequencia"
                pot=$((2**$sequencia))
                echo "A potencia é $pot"
                if [ $resto = 1 ]; then
                    soma=$((soma + pot))
                    echo "a soma total é: $soma"
                    barra=$((barra + 1))
                    echo "Mascara é: /$barra"
                fi
#            sequencia=$(expr $sequencia - 1)
            done
        fi
    done

# calcular a faixa do endereço de toda a rede até o broadcast.
    echo -e "\n\t\t\t Informações de sua Rede com classe. \n"

    parteRede=$(echo $IPLocal | cut -d "." -f1-$octeto255)
    echo "A parte da rede é $parteRede"
    completaRede=$(echo "$parteRede.0.0.0")
    rede=$(echo $completaRede | cut -d "." -f1-3)
    echo "Sua rede é $rede.0"
    endInicialRede=$(echo "$rede.1")
    echo "Endereço válido inicial da rede $endInicialRede"

    completaBcast=$(echo "$parteRede.254.254.254")
    endFinalRede=$(echo $completaBcast | cut -d "." -f1-4)
    echo "Endereço válido Final da rede $endFinalRede"

# Calcular a quantidade de hosts na subrede, a partir da mascara.
    echo -e "\n\t\t\t Informações de sua subrede. \n"

    bitsHosts=$(expr 32 - $barra)
    echo "Quantidade de bits para os hosts $bitsHosts"
    enderecoValidos=$(((2**$bitsHosts)-2))
    echo "Endereços válidos $enderecoValidos"

# Calcular a faixa inicial de IP na subrede.
    corta=$(expr $octeto255 + 1)
    Bcast=$(echo $broadcast | cut -d "." -f$corta-4)

    endHosts=$(expr $Bcast - $enderecoValidos - 1 2> /dev/null)
    subRede=$(echo "$rede.$endHosts")
    echo "Endereço de SubRede: $subRede"
    echo "Endereço de Broadcast: $broadcast"

## === Escrever informações obtidas para um arquivo de variaveis. === ##
    echo "IP_LOCAL=$IPLocal" > variaveis
    echo "IP_SUB_REDE=$subRede" >> variaveis
    echo "MASC_SUB_REDE=$masc" >> variaveis

# Percorrer de 1 até a quantidade máxima de endereços válidos.
    touch listaDeMACs.txt
    inicio=1
    for i in $(seq $inicio $enderecoValidos)
    do
        if [ "$endHosts" -le 254 ] 2> /dev/null; then
            endHosts=$(expr $endHosts + 1)
            IP=$(echo "$rede.$endHosts")
            echo  -e "\n \t O IP Válido é: \t $IP"

# ping e arp pra ver se o Host está ativo e pegar o MAC.
            if ping -c1 $IP | grep "Host Unreachable" &> /dev/null; then
                echo "Host não alcançado!"
                mac=""
            else
                mac=$(arp $IP | sed 's/^.*ether  //' | sed 's/C.*$//' | sed '1'd)
                echo -e "\t O MAC é:\t $mac"
            fi 

# Se MAC não é nulo, procura na lista de MACs se MAC já está presente.
            if [ -z "$mac" ]; then
                echo "MAC não obtido!" 

            elif cat listaDeMACs.txt | grep -w $mac &> /dev/null; then	# grep -w procura mac inteiro
                echo "MAC: $mac já está na lista de MACs"

            else
                echo -e "Inserindo MAC: $mac na lista de MACs, \t e IP: $IP na lista de IPs"
                echo $mac >> listaDeMACs.txt
                echo $IP >> listaDeIPs.txt
            fi
        fi
    done
}

function manual () {
    touch listaDeMACs.txt
    while :
    do
        read -p "Digite o endereço IP, ou sair para parar: " ip
        if [ "$ip" == "sair" ]; then
            break
            exit 0
        elif ping -c2 $ip | grep "Host Unreachable" &> /dev/null; then
                echo "Host não alcançado!"
                mac=""
        else
            mac=$(arp $ip | sed 's/^.*ether  //' | sed 's/C.*$//' | sed '1'd)
            echo -e "\t O MAC é:\t $mac"
        fi

# Se MAC não é nulo, procura na lista de MACs se MAC já está presente.
        if [ -z "$mac" ]; then
            echo "MAC não obtido!" 

        elif cat listaDeMACs.txt | grep -w $mac &> /dev/null; then  # grep -w procura mac inteiro
            echo "MAC: $mac já está na lista de MACs"

        else
            echo -e "Inserindo MAC: $mac na lista de MACs, \t e IP: $ip na lista de IPs"
            echo $mac >> listaDeMACs.txt
            echo $ip >> listaDeIPs.txt
       fi
    done        
}

echo -e "\tLista e salva todos os IPs ou apenas o que voce digitar\n"
read -p "Digite a opção: a - lista todos, m - apenas os digitados: " opcao

case $opcao in
a) automatico;;
m) manual;;

esac

exit 0
