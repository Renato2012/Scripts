#!/bin/bash

# Renato Cavalcante
# 09/07/2015

# Script remove virus de pendrive

echo "Discos montados! "
ls /media/$USER/
echo -e "\n"

read -p "Digite o disco para remover virus: " disco

cd /media/"$USER"/"$disco"/

echo "Arquivos a serem removidos! "
ls -la | grep $*.lnk

rm -r *.lnk

