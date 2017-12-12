#1. Tiempo transcurrido de un proceso desde su lanzamiento:
ps -e -o command,pid,etime

#-o ordena según los campos siguiente, command:comando ejecutado, pid: identificador, etime: tiempo que ha pasado desde su lanzamiento
#-e muestra todos los procesos del sistema

#2. Muestre el pid y el propietario de todos los procesos que estén ejecutando el programa b ash. La lista debe estar ordenada por el nombre del propietario.

ps -A -o pid,user --sort=user -C=bash

#la opción -C cmdlist describe su uso como "esto selecciona el proceso cuyo nombre ejecutable se da en "cmdlist"" Pero lo cierto es que no es asi. Así que una solución sería:

ps -A -o pid,user,command --sort=user | grep bash

#3. ¿Qué hace la siguiente orden?
ps -e --forest

#muestra el árbol de todos los procesos

#4. ¿Qué hace la siguiente orden?
ps -e -opid,ppid,user,pcpu,cputime,cmd --sort=cputime

#Ordena los procesos por tiempo de cpu y formatea la salida: "pid del proceso" "pid del proceso padre" "usuario que lanzo el proceso" "Porcentaje CPU usada" "tiempo de cpu" "Proceso"

#5. Localice los 5 procesos que han consumido más CPU hasta el momento.

ps -e -o pid,cmd --sort=pcpu | head -n6



