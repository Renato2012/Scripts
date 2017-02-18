#!/bin/bash

cor=$( dialog --stdout --menu 'As cores:' 0 0 0 add 'Adiciona ao arquivo' list 'lista o arquivo' del 'Deleta o usuario' sort 'Lista em ordem alfabética' )

if [ "$#" -eq 0 ]
then

case $cor in
add) dialog --inputbox 'Digite o nome : e-mail' 0 0  2>>/home/renato/user.db
    	#echo $user:$email >> /home/renato/user.db
;;

list) cat /home/renato/user.db
;;

del) dialog --inputbox 'Digite o nome:' 0 0  2>>guardaUser
sed 's/ *$//' guardaUser
echo $guardaUser >/home/renato/user.db 
;;

sort) sort --key=1 /home/renato/user.db
;;

*) echo $cor
;;
esac
exit 0
fi
	echo $cor

