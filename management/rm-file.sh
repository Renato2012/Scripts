#!/bin/bash
#
# Renato Araújo -- UFBA -- 2017
#
# Remove arquivos com certa extensão recursivamente em subdiretórios, a partir do diretŕio corrente.
#

read -p "Digite a extensão dos arquivos a serem apagados " ext
echo -e "\nAguarde: Apagando files.$ext em subdiretórios\n"

for file in $(find . -name *.$ext)
do
#    echo $file
    yes | rm -r $file
done

echo -e "\nDone\n"

