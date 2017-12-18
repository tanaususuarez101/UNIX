#----------------------------------------------
# Práctica 5.1
#----------------------------------------------
# Apartado 4
# Respuesta 1
#Para ver todos los discos:
fdisk -l
#Para realizar particion /dev/sdb
fdisk /dev/sdb
#aquí no saldrá opcines y pulsando 'n' para crear una nueva
#particion.
# elegir la opción primaria.
# Opciones elegidas:
# Nº de particiones: 1
# Primer cilindro: default
# Último cilindro: default
# por último escribimos los resultados en disco: w
# Comprobamos que existe la partición y todo correcto.
fdisk -l /dev/sdb

# Respuesta 2
#Creamos el sistema de archivo con 3000 i-nodos y tamaño de blocke de 2048
mkfs.ext4 -N 3000 -b 2048 /dev/sdb1

# Respuesta 3
#montar 
mount /dev/sdb1 /mnt/
#desmontar
umount -a /dev/sdb1

# Respuesta 4
# sistemas montados
df -h

# Respuesta 5
#añadimos en el archivo /etc/fstab la siguiente linea
/dev/sdb1  /mnt/   ext4  auto   0 0



#------------------------------------
# Apartado 5

# Pregunta 1
# En el mismo menú que el anterior apartado creamos aprtición en cada disco
fdisk /dev/sdb
fdisk /dev/sdc
# Para que sean ambas particiones lvm
pvcreate /dev/sdb1
pvcreate /dev/sdc1
# ver resultado pvdisplay

# Pregunta 2
vgcreate VG_ASO /dev/sdb1 /dev/sdc1
vgdisplay

# Pregunta 3(Ver imagen)
lvcreate --size 100M --name VL_ASO VG_ASO
lvdisplay

# Pregunta 4
#Crear el sistema de archivo con ext4 y la etiquieta MEDIA
mkfs.ext4 -N 3000 -b 2048 /dev/VG_ASO/VL_ASO -L MEDIA
# montarlo en /mnt
mount /dev/VG_ASO/VL_ASO /mnt
df -h
# copiar en /mnt los directorio bin y /usr/bin recursivamente
cp -r -f /bin /usr/bin /mnt
# desmontar /mnt
umount /mnt 
# montaje del sistema de fichero solo lectura.
mount -r /dev/VG_ASO/VL_ASO /mnt
#Volvemos a desmontar
umount /mnt 
df -h

# Pregunta 5(Ver imagen)
lvextend -L +40M /dev/VG_ASO/VL_ASO
e2fsck -f /dev/VG_ASO/VL_ASO #Me pide que ejecute esto antes
resize2fs /dev/VG_ASO/VL_ASO

# Pregunta 6
lvcreate -n VL_BACKUP -L 80M VG_ASO
lvdisplay
mkfs.ext4  -N 3000 -b 2048 /dev/VG_ASO/VL_BACKUP

#Pregunta 7
fsck /dev/VG_ASO/VL_BACKUP
#lo mismo pero automático
fsck -a /dev/VG_ASO/VL_BACKUP

#Pregunta 8 (Ver imagen)
mkdir /var/media /var/backup
#Añadimos en el fichero /etc/fstab las siguientes dos líneas:
/dev/VG_ASO/VL_ASO  /var/media   ext4  auto   0 0
/dev/VG_ASO/VL_BACKUP  /var/backup   ext4  auto   0 0
# reboot del sistema y comprobamos:
df -h

#----------------------------------------------
# Práctica 5.2
#----------------------------------------------

#Pregunta 1
# El comando tune2fs nos pemite especificar cada cuantos reinicios
# o cada cuanto tiempo queremos que nos haga un chequeo del sistema
# de archivos
tune2fs -c 1 /dev/VG_ASO/VL_ASO 

#Pregunta 2
tune2fs -l /dev/VG_ASO/VL_ASO 

#Pregunta 3
#Nota: cada ves que se reinicia el sistema se monta
#Por tanto, cada 5 reinicios se comprueba la integridad
tune2fs -c 5 /dev/VG_ASO/VL_ASO 
tune2fs -c 5 /dev/VG_ASO/VL_BACKUP

#Pregunta 4
df -h #la columna use% muestra el espacio usado (además del disponible)

#Pregunta 5
# -s: solo muestra el total y -h en formato
du -s -h /usr
du -s -h /var

#----------------------------------------------
# Práctica 5.3
#----------------------------------------------
#Previo:
yum install quota
#editar achivo - forma radical - 
vi /etc/sysconfig/selinux
#modificar "selinux=disabled"
reboot

#Pregunta 1
# Añadir a las opciones de el uso de cuotas (usrquota,grpquota)
# en el archivo /etc/fstab
quotacheck -cvug /var/media
quotacheck -cvug /var/backup
#comprobar que se han creado los archivo quota.user y quota.group
# en los respectivo puntos
ls /var/media /var/backup
# activar quotas
quotaon /var/media
quotaon /var/backup

# Pregunta 2 (ver imagen)
# Como no tengo los usuarios creados, primero lo hago:
useradd prueba
edquota -u prueba # añadir block 20M y 300 inodes (ver imagen)

# Pregunta 3 (ver imagen)
edquota -g prueba #añadirr a block 50M y 600 inodes

# Pregunta 4
quota -u prueba

#Pregunta 5(Ver imagen)
#Como el enunciado es muy general vamos hacerlo sobre prueba
edquota -u -t
# colocar en block grace 7days y en inodes lo mismo.




