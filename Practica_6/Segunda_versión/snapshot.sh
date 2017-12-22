#!/bin/bash

ayuda() {
	echo "- Uso del script snapshot"
	echo -e "\nEl script elabora un listado en el que figuran los archivos del fichero: \n/bin\n/usr/bin\n/sbin/\n/usr/sbin"
	echo -e "\nLa sintaxis para usar el script debería ser la siguiente:"
	echo "snapshot.sh [-d] [-h | --help]"
	echo "[-d] Crea el directorio /snapshot/ para guardar los resultados"
	echo "[-h | --help] Abre la ayuda del script"
	exit
}

die() {
	echo $1 >&2
	exit 1
}

[ -d "/snapshot/" ] ||  mkdir "/snapshot/" #Directorio para guardar los snapshot
if [[ $@ > 0 ]]
then
    [[ $1 == '-h' ]] || [[ $1 == '--help' ]] && ayuda
    [[ $1 != '-h' ]] && [[ $1 != '--help' ]] && [[ $1 != '-d' ]] && die "Argumento incorrecto. Use --help para más información."
fi

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