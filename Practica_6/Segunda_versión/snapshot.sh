#!/bin/bash

[ -d "/snapshot/" ] ||  mkdir "/snapshot/" #Directorio para guardar los snapshot

REGISTRO_FILE="/snapshot/registro.txt"
rutas="/bin /usr/bin /sbin/ /usr/sbin"

if [[ $# > 0 ]] && [[ $1 == '-p' ]]
then
    find $rutas -type f -printf '%m ' -exec md5sum {} \; >&1 2>/dev/null    
else
    find $rutas -type f -printf '%m ' -exec md5sum {} \; > $REGISTRO_FILE 2>/dev/null
    echo "Imagen del sistema en :: $REGISTRO_FILE"
fi

exit 0;	


