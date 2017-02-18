#!/bin/bash

# script para tratar saídas do iperf e guarda no arquivo output.txt

# apaga linhas que começam com SUM
sed -i '/\bSUM/d' data.txt

# apaga linhas que começam com local
sed -i '/\blocal/d' data.txt 

# apaga linhas que terminam com out-of-order, pacotes fora de ordem.
sed -i '/out-of-order\b/d' data.txt

# pega coluna Transfer Bandwidth jitter Lost e total
#
# $5 valor transfer; 
# $6 unidade KBytes;
# $7 valor bandwidth; 
# $8 unidade Kbits/sec;
# $9 valor jitter;
# $10 unidade ms;
# $11 valor lost; 
# $12 total.
#

awk '{print $5 " " $6 " " $7 " " $8 "  " $9 " " $10 "  " $11 " " $12}' data.txt > output.txt


