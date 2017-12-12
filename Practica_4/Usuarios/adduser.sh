# Enunciado:

#En tu máquina virtual, crea cuarenta cuentas de usuario user01, user02, user03… que
#pertenezcan al grupo myusers y que tengan la misma política de seguridad de contraseñas
#descrita en el apartado anterior. Además, deberá existir una cuenta poweruser que funcione
#como administrador de ese grupo. Esta cuenta de administración no tendrá caducidad de
#contraseñas.
#Cada usuario tendrá un directorio de su propiedad en /Users (ej. /Users/user01), en el que se
#copiará el esqueleto general de una cuenta de usuario del sistema. Además, todos los usuarios
#compartirán una carpeta llamada /Users/myusers, en la que todos ellos tendrán permisos de
#lectura y escritura. La cuenta poweruser no tendrá directorio de usuario.
#Para la ejecución de esta actividad se recomienda (bueno, se exige :) crear un shell script que
#automatice el trabajo y permita repetir la creación de cuentas si es necesario. Este script
#tendrá que entregarse como evidencia de realización del trabajo.

#!/bin/bash

groupadd myusers
mkdir "/users/"
mkdir "/users/myusers"

echo "Creando usuario..."
for ((i=1; i<41; i++))
do
	uid=$((1890+$i))
	useradd -m -g myusers -s /bin/bash -d "/users/user$i" -u $uid "user$i"
	chage -E 2017-12-27 -m 15 -W 7 -I 7 "user$i"
done

echo "Creando usuario administrador...."
useradd -m -g myusers -s /bin/bash -u 1890 poweruser #usuario administrador

echo "Configurando usuarios y sus directorios"
chgrp -R myusers /users/myusers
chmod -R 760 /users/myusers/ # todos los permisos al propietario; lectura y escritura al grupo.
chown -R poweruser /users/myusers

echo "Procesos terminado"

exit 0;

