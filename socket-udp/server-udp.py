#!/usr/bin/python
#coding=UTF-8
#
# Renato Araújo
# 09/07/2023.
# 
# Exemplo básico de socket servidor usando o protocolo de transporte UDP.
# Cliente envia um texto ao servidor que responde com TEXTO em maiúsculo.
#
from socket import *

serverPort = 12000

serverSocket = socket(AF_INET, SOCK_DGRAM)
serverSocket.bind(('', serverPort))

print("Servidor em execução!")

while 1:
    message, clientAddress = serverSocket.recvfrom(2048)
    messageString = message.decode()
    modifiedMessage = messageString.upper()

    serverSocket.sendto(modifiedMessage.encode(), clientAddress)
