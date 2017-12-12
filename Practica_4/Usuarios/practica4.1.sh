#2 Actividad para realizar en laboratorio
#1. Crear el grupo alumnos y hacer que el usuario prueba #pertenezca a él.
groupadd alumnos;
useradd -g alumnos usuario
#2. Crear una cuenta llamada invitado con las siguientes características:
#a) identificador de usuario: 1890
#b) grupo primario invitado y alternativo alumnos
#c) intérprete de órdenes inicial: bash
#d) caducidad de la cuenta: 4 meses
useradd -u 1890 -g invitado -G alumnos -s /bin/bash -e 2018-03-28 invitado


#3. Para la cuenta anterior, establecer para su contraseña estas características:
#a) caducidad: 1 mes
#b) antigüedad mínima: 15 días
#c) avisar una semana antes de que la contraseña caduque
#d) periodo de gracia de una semana en caso de que la #contraseña caduque
chage -e 2018-12-28 -e 15  -W 7

