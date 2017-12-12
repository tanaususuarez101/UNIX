#! /bin/bash


#1. Mostrar solamente las líneas impares  y pares (según la opción)de un archivo de texto que se pasa como argumento al script.

[ $# > 1 ] || { echo "ERROR: faltan argumentos ">&2; exit -1; }

opc=n

for i in $@
do		
	if [ -f $i ] ;then		
		grupoficheros[n_ficheros]=$i
		((n_ficheros++))		
	elif [ $i == '-i' ] || [ $i == '-p' ];then
		opc=$i	
	fi

done

[ $opc == 'n' ] && { echo "ERROR: option not found">&2; exit -1; }
echo "Ficheros encontrados: ${grupo_ficheros[*]}"

#recorre los ficheros encontrados:
for fichero
do	
	echo "---> Leyendo $fichero"	
	paridad=1

	while read linea
	do
		if [ $opc == '-i' ] && [ $((paridad%2)) == 0 ]; then	
			echo  "$paridad $linea"
		elif [ $opc == '-p' ] && [ $((paridad%2)) == 1 ]; then
			echo  "$paridad $linea"
		fi	
		(( paridad++ ))	
	done < $fichero
done < $grupoficheros

exit 0 
