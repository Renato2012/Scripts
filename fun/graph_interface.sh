#!/bin/bash

# Renato

file=graph_interface.db
log=graph_interface.log
#path=~/$file		# to save /home/user/
path=$file
touch $path

cor=$(dialog --stdout --menu 'As cores:' 0 0 0 add 'Adiciona ao arquivo' list 'lista o arquivo' del 'Deleta o usuario' sort 'Lista em ordem alfabética')

if [ "$#" -eq 0 ]; then		# if qtd parameter == 0

  case $cor in
    add) dialog --inputbox 'Digite o nome : e-mail' 0 0  2>>$path
    ;;

    list) 
      tail -f "$path" > "$log" & 

      dialog --title 'Listando conteúdo' --tailbox "$log" 0 0
    ;;

    del) dialog --inputbox 'Digite o nome:' 0 0  2>>$log
      sed 's/ *$//' $log
      echo $log >$path
    ;;

    sort) sort --key=1 $path
    ;;

    *) echo $cor
    ;;
  esac

  exit 0

fi

echo $cor

