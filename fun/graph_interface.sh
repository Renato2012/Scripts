#!/bin/bash

# Renato

file=graph_int.db
path=~/$file
touch $path

cor=$(dialog --stdout --menu 'As cores:' 0 0 0 add 'Adiciona ao arquivo' list 'lista o arquivo' del 'Deleta o usuario' sort 'Lista em ordem alfabética')

if [ "$#" -eq 0 ]; then		# if qtd parameter == 0

  case $cor in
    add) dialog --inputbox 'Digite o nome : e-mail' 0 0  2>>$path
  ;;

    list) cat $path
  ;;

    del) dialog --inputbox 'Digite o nome:' 0 0  2>>guardaUser
      sed 's/ *$//' guardaUser
      echo $guardaUser >$path
  ;;

    sort) sort --key=1 $path
  ;;

    *) echo $cor
  ;;
  esac

  exit 0

fi

echo $cor

