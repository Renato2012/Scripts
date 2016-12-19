#!/bin/bash

# Renato Cavalcante
# data: 05/07/2016
# Programa desenvolvido para ajustar o brilho do monitor de computadores que usam o sistema operacional Ubuntu/Linux. Principalmente para ajudar as pessoas que estão com problemas nas teclas de atalho para ajuste do brilho do monitor.

# Instale o xbacklight para o programa ter acesso ao controle do brilho da tela.
# sudo apt-get update
# sudo apt-get install xbacklight

function menu(){
echo -e "\t\t # Menu #			 © Renato Cavalcante
        |0| Diminuir brilho
        |1| Aumentar brilho
        |2| Mostrar brilho
        |3| Limpar tela
        |4| Sair do Programa
	|5| Sair e Fechar o Terminal" 
}

while true
do
    menu       # Chama função menu.
    read opcao

    brilho=$(xbacklight -get)
    brilho=$(echo $brilho | cut -d "." -f 1)      # Pegar parte inteira.

    case $opcao in
    0) read -p "Ajustar em %? " ajuste
       valor=$(($brilho - $ajuste))
       if [ $valor -ge 2 ]; then
           xbacklight -dec $valor
       else
           echo -e "\n Brilho muito baixo! --- Valor: $brilho \n"
       fi
    ;;
    1) read -p "Ajuste em %? " ajuste
       valor=$(($brilho - $ajuste))
       if [ $valor -le 0 ]; then           # Se negativo, deixa positivo.
           valor=$((valor * -1)) 
       fi
       if [ $valor -le 98 ]; then
           xbacklight -inc $valor
       else
           echo -e "\n Brilho máximo! --- Valor: $brilho \n"
       fi
    ;;
    2) echo "Brilho Atual: $brilho"
    ;;
    3) clear
    ;;
    4) break
    ;;
    5) pidTerminal=$(pgrep gnome-terminal)
       kill -9 $pidTerminal
    ;;
    *) echo "Opção Inválida, Veja o Menu!" 
    ;;
    esac
done

exit 0
