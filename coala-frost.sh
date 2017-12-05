#!/bin/bash
#
# Renato Araújo -- UFBA -- 2017
#
# Trata saída do Iperf
#

Interval=0
Jitter=0
Lost=0
AllDatagrams=0
PctPerdas=0
QtdPctReceive=0

FILEIN="exp2-cli1.log"
FILEOUT="coala-frost.txt"

# get values
Interval=$(cat $FILEIN | grep "%" | awk '{ print $3 }' | cut -d "-" -f2 | awk '{ sum += $1 } END { print sum }') 
Jitter=$(cat $FILEIN | grep "%" | awk '{ sum += $9 } END { print sum }')
Lost=$(cat $FILEIN | grep "%" | awk '{ print $11 }' | cut -d "/" -f1 | awk '{ sum += $1 } END { print sum }')
AllDatagrams=$(cat $FILEIN | grep "%" | awk '{ print $11 }' | cut -d "/" -f2 | awk '{ sum += $1 } END { print sum }')
PctPerdas=$(cat $FILEIN | grep "%" | cut -d "(" -f2 | cut -d "%" -f1 | awk '{ sum += $1 } END { print sum }')

# Pacotes recebidos
QtdPctReceive=$(awk "BEGIN{ print $AllDatagrams - $Lost }")

# Salvar em arquivo de saída e mostrar na tela
echo -e "# Interval\tJitter\tLost\tAllDatagrams\tPctPerdas\tQtdPctReceive\n" | tee $FILEOUT
echo -e "$Interval\t$Jitter\t$Lost\t$AllDatagrams\t$PctPerdas\t$QtdPctReceive\n" | tee $FILEOUT






