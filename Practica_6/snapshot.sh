#!/bin/bash

[ -d "/snapshot/" ] ||  mkdir "/snapshot/" #Directorio para guardar los snapshot

REGISTRO_FILE="/snapshot/registro.txt"
rutas="/bin /usr/bin /sbin/ /usr/sbin"

find $rutas -type f -printf '%m ' -exec md5sum {} \; > $REGISTRO_FILE 2>/dev/null

exit 0;	



