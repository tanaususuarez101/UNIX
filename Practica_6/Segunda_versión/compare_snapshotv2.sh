#!/bin/bash

rutas="/bin /usr/bin /sbin/ /usr/sbin"
reg_new="/snapshot/registro_temp.txt"
reg_old="/snapshot/registro.txt"
reg_vol="/var/log/binchecker"



[[ -d reg_vol ]] || touch $reg_vol


if [[ $# > 1 ]] && [[ $1 == '-f' ]]; then
	if [[ -f $2 ]];then
		reg_old=$1
	else
		echo "ERROR: Fichero origen"
		exit -2;
	fi
fi

find $rutas -type f -printf '%m ' -exec md5sum {} \; > $reg_new  2>/dev/null

#La opción diff -c muestra toda la lista de los fichero y marca con:
# ! archivo que han cambiado (aparecerán dos)
# + Archivos añadidos
# - Archivos eliminados
# El grep filtra y obtiene todas la coincidencias que empieze por alguno de esos símbolos
perm_prov='x'
cont_prov='x'


diff -c $reg_old $reg_new | grep -e "^[!+-] " | sort -t" " -k4 |
while read opc permisos md5 archivo
do
	case "$opc" in	
		"+")
			echo "Archivo añadido :: $archivo ";;
		"-")
			echo "Archivo borrado :: $archivo";;
		"!")
		    if [[ $perm_prov == 'x' ]] || [[ $cont_prov == 'x' ]]
		    then
		   	    perm_prov=$permisos;
    		   	cont_prov=$md5;
		    else
				echo "Archivo modificado :: $archivo ";
				[[ $perm_prov != $permisos ]] && echo "  Permisos :: $perm_prov :: $permisos";
				[[ $cont_prov != $md5 ]] && echo "  Contenido :: $cont_prov :: $md5";
				perm_prov='x'
				cont_prov='x'                
			fi
			;;
	esac
done
rm -f $registro

echo "------------------"
exit 0;
#Archivo añadido
#Archivo borrado
#Archivo cambio permisos
#Cambios en el contenido archivos
