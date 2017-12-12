#!/bin/bash

rutas="/bin /usr/bin /sbin/ /usr/sbin"
find $rutas -type f -printf '%m ' -exec md5sum {} \; > /snapshot/registro_temp.txt 2>/dev/null


#La opción -c muestra toda la lista de los fichero y marca con:
# ! archivo que han cambiado (aparecerán dos)
# + Archivos añadidos
# - Archivos eliminados
# El grep filtra y obtiene todas la coincidencias que empieze por alguno de esos símbolos

del=$()

diff -c /snapshot/registro.txt /snapshot/registro_temp.txt | grep -e "^[!+-] " |
while read opc permisos md5 archivo
do
	
	case "$opc" in	
		"+")
			echo "Archivo añadido :: $archivo ";;
		"-")
			echo "Archivo borrado :: $archivo";;
		"!")
			echo "Archivo cambiado :: $archivo";;
	esac
done


#Archivo añadido
#Archivo borrado
#Archivo cambio permisos
#Cambios en el contenido archivos
