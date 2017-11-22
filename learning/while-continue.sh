#!/bin/bash
#
# Renato Araújo -- 2017
#
# Exemplo de uso de:
# while; if; e condição continue [programa pula para a próxima iteração].

n=-1
while [ $n -le 5 ]
do
    n=$(($n + 1))
    echo "number $n"
    if [ $(($n % 2)) == 0 ]
    then
        echo "$n é par"
        continue # pula para a próxima iteração.
    fi
    # só imprime 'n é impar' se não entrar no if.
    echo "$n é impar"
done


