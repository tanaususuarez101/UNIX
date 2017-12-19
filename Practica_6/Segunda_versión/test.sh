#!/bin/bash
##Script para ejecutar pruebas
#NOTA: este script tiene que estar en la misma carpeta que compare_snapshot.sh y shanshot.sh

##Crear los ficheros de prueba

echo "Comenzado batería de pruebas..."

archivo_delete="/bin/archivo_delete"
archivo_nuevo="/bin/archivo_nuevo"
archivo_mod1="/bin/archivo_modificado_cont"
archivo_mod2="/bin/archivo_modificado_perm"
archivo_mod3="/bin/archivo_modificado_perm_cont"
archivo_c_A="/bin/archivo_A"
archivo_c_B="/bin/archivo_B"

touch $archivo_delete $archivo_mod1 $archivo_mod2 $archivo_mod3 $archivo_c_A

./snapshot.sh

# Test 1 :: eliminación de archivo:
echo "Test 1 :: Borrando ";echo ""
rm $archivo_delete -f
./compare_snapshot.sh

# Test 2 :: creación de archivo:
echo "Test 2 :: Añadiendo";echo ""
touch $archivo_nuevo
./compare_snapshot.sh

# Test 3 :: modificación contenido
echo "Test 3 :: Modificando contenido";echo ""
echo "Nuevo contenido" >> $archivo_mod1
./compare_snapshot.sh

# Test 4 :: modificación permisos
echo "Test 4 :: Modificando permisos";echo ""
find $archivo_mod2 -type f -exec chmod 777 {} \;
./compare_snapshot.sh

# Test 5 :: modificación de permisos y contenido:
echo "Test 5 :: Modificando contenido y permisos";echo ""
echo "Nuevo contenido" >> $archivo_mod3
find $archivo_mod3 -type f -exec chmod 777 {} \;
./compare_snapshot.sh

# Test 6 :: cambio de nombre
echo "Test 6 :: Renombrando archivo";echo ""
mv $archivo_c_A $archivo_c_B
./compare_snapshot.sh

rm $archivo_nuevo $archivo_mod1 $archivo_mod2 $archivo_mod3 $archivo_c_B -f

./compare_snapshot.sh

echo "Fin de las pruebas"
echo ""




