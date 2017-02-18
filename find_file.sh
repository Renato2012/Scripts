#!/bin/bash

# =============== Script procura arquivo ================

# Procura qualquer arquivo no diretório /etc que contenha a frase informada no grep e imprime na tela o nome do arquivo.

for i in `ls /etc/*/*`
do
    if cat $i | grep "Waiting for network"; then
        echo "# O arquivo que contem o texto informado é: $i";
        break
    fi
done

# Tudo em apenas uma linha.
#for i in `ls /etc/*/*`; do if cat $i | grep "Waiting for network"; then echo $i#; break; fi done
