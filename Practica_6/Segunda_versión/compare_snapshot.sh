#!/bin/bash

rutas="/bin /usr/bin /sbin/ /usr/sbin"



#La opción -c muestra toda la lista de los fichero y marca con:
# ! archivo que han cambiado (aparecerán dos)
# + Archivos añadidos
# - Archivos eliminados
# El grep filtra y obtiene todas la coincidencias que empieze por alguno de esos símbolos
perm_prov='x'
cont_prov='x'

fichero_registro="/snapshot/registro.txt"
fichero_comparativo="/snapshot/registro_temp.txt"
fichero_log="/var/log/binchecker"



if [[ $# > 1 ]] && [[ $1 == '-f' ]]; then
	if [[ -f $2 ]];then
		fichero_log=$2
	else
		echo "ERROR: Fichero volcado no encontrado"
		exit -2;
	fi
fi



date +"%Y/%m/%d" >> $fichero_log
find $rutas -type f -printf '%m ' -exec md5sum {} \; > $fichero_comparativo 2>/dev/null

diff -c $fichero_registro $fichero_comparativo | grep -e "^[!+-] " | sort -t" " -k4 |
while read opc permisos md5 archivo
do
	case "$opc" in	
		"+")
			echo "Archivo añadido :: $archivo " >> $fichero_log;;
		"-")
			echo "Archivo borrado :: $archivo" >> $fichero_log;;
		"!")

		    if [[ $perm_prov == 'x' ]] && [[ $cont_prov == 'x' ]]
		    then
		   	    perm_prov=$permisos;
    		   	cont_prov=$md5;
		    else
				echo "Archivo modificado :: $archivo " >> $fichero_log;
				[[ $perm_prov != $permisos ]] && echo "  Permisos :: $perm_prov :: $permisos" >> $fichero_log;
				[[ $cont_prov != $md5 ]] && echo "  Contenido :: $cont_prov :: $md5" >> $fichero_log;
				perm_prov='x'
				cont_prov='x'                
			fi
			;;
	esac


done

rm -f $fichero_comparativo
echo "------------------" >> $fichero_log

#Archivo añadido
#Archivo borrado
#Archivo cambio permisos
#Cambios en el contenido archivos
