#! bin/bash

echo "Iniciando el proceso de borrado de usuario..."

for ((i=1; i<41; i++))
do	
	userdel -r "user$i";
done

userdel -r poweruser;

echo "Borrando grupo..."
groupdel myusers;
echo "Borrando directorio..."
rm /user -r -f 
echo "Proceso de borrado finalizado"

