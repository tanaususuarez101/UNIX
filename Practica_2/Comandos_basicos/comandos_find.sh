#BLOQUE B: ejercicios con find

#Estos son varios ejercicios que se pueden resolver fácilmente con la orden find. 

#Envíe sus soluciones respondiendo directamente a este mensaje.

#En el contexto de este bloque  de ejercicios se entenderá que el término «fichero» se refiere a un fichero regular, mientras que «archivo» se refiere a cualquier entidad del sistema de ficheros (archivo, directorio, enlace, ...).

#1. ¿Qué hace la siguiente orden?
find /etc /boot -type f -newer /etc/passwd 
#Busca en los directorio "/etc" y "/boot" fichero que ha sido modificado más recientemente que "/etc/passwd"

#2. Localice todos los archivos que no pertenezcan al usuario root cuyo tamaño sea mayor que 10 KiB y menor que 50 KiB
find / -size +10k -and -size -50k -and -not -user root

#3. Calcule la suma md5 de los ficheros de tamaño inferior a 10Kib o superior a 1Mib, que haya bajo los directorios /bin y /sbin. El cálculo de la suma md5 típicamente se realiza con la orden «md5sum». 
find /bin /sbin -type -f \( -size -10k -or -size +1M \) -exec md5sum {} +
#El comando nos mostrará el resultado  md5 y el nombre del archivo al que se le ha hecho, pero como nos dice "calcular la suma md5 de los ficheros ..." y en ningún caso nos pide a que fichero se lo hemos hechos
#habrá que añadir :
find /bin /sbin -type -f \( -size -10k -or -size +1M \) -exec md5sum {} + | cut -d " " -f1

#4. Localice todos los archivos del directorio /root que tengan permiso de lectura para el grupo propietario, independientemente del resto de permisos.
find /root -perm -g+r

#5. ¿Qué hace la siguiente orden?
cd ; find . -maxdepth 1 \( -empty -o -newer /etc/passwd \)
#Primero se situa en la carpeta del usuario "cd" luego ejecuta la búsqueda de los archivos vacios o que hayan sido modificado mas recientemente que /etc/passwd descendiendo máximo un nivel 
