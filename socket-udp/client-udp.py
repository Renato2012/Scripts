#!/usr/bin/python
#coding=UTF-8
#
# Renato Araújo
# 09/07/2023.
# 
# Exemplo básico de socket cliente usando o protocolo de transporte UDP.
# Cliente envia um texto ao servidor que responde com TEXTO em maiúsculo.
#
from socket import *

serverName = '127.0.0.1'
serverPort = 12000

clientSocket = socket(AF_INET, SOCK_DGRAM)
clientSocket.connect((serverName, serverPort))

message = input('Digite um texto: ')
messageByte = message.encode() # string to byte

clientSocket.sendto(messageByte, (serverName, serverPort))
modifiedMessage, serverAddress = clientSocket.recvfrom(2048)

print(modifiedMessage.decode())

clientSocket.close()
