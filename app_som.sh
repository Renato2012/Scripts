#!/bin/bash

# Renato Cavalcante
# 18/12/2015

# Script para listar e reproduzir músicas, vídeos e imagens.

OPCAO=$1
PATHMUSICA="$HOME/Música"
PATHVIDEO="$HOME/Vídeos"
PATHIMAGEM="$HOME/Imagens"

function ACAO() {
    case $OPCAO in
        1) echo "Listando Músicas"
        ls $PATHMUSICA/* 2> /dev/null
        sleep 5
        ;;        

        2) echo "Carregando Músicas"
        sleep 2
        find "$PATHMUSICA" -iname *.mp3 -exec totem {} + &> /dev/null
        echo "Reprodutor de Músicas encerrado!"
        ;;

        3) echo "Listando Vídeos"
        ls $PATHVIDEO/* 2> /dev/null
        sleep 5
        ;;        

        4) echo "Carregando Vídeos"
        sleep 2
        find "$PATHVIDEO" -iname *.mp4 -exec totem {} + &> /dev/null
        echo "Reprodutor de Vídeos encerrado!"
        ;;

        5) echo "Listando Imagens"
        ls $PATHIMAGEM/* 2> /dev/null
        sleep 5
        ;;

        6) echo "Carregando Imagens"
        sleep 2
        find "$PATHIMAGEM" -iname *.png -exec eog {} + &> /dev/null
        echo "Reprodutor de Imagens encerrado!"
        ;;

        7) echo "Saindo"
        exit 0
        ;;

        *) zenity --error --text="© Renato Cavalcante APPSOM --- Escolha uma opção \t
        1 - Listar Músicas \n
        2 - Reproduzir Músicas \n
        3 - Listar Vídeos \n
        4 - Reproduzir Vídeos \n
        5 - Listar Imagens \n
        6 - Reproduzir Imagens \n
        7 - Sair"
        ;;
    esac
}

function Menu() {
    clear # Limpa tela.
    echo -e "\t Escolha uma opção \n"
    echo "1 - Listar Músicas"
    echo "2 - Reproduzir Músicas"
    echo "3 - Listar Vídeos"
    echo "4 - Reproduzir Vídeos"
    echo "5 - Listar Imagens"
    echo "6 - Reproduzir Imagens"
    echo "7 - Sair"
    read OPCAO 
    ACAO # Chama função ACAO.
}

while :
do
    Menu # Chama função Menu.
done
