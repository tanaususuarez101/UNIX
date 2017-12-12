#!/bin/bash


FECHA=$(date +"%Y%m%d")
RUTA="/backups"


#a) Primer lunes del mes: copia total (nivel 0)
touch $RUTA/testigo_lunes;
tar czf $RUTA/backup_nivel0_$FECHA.tar /home/;
## NOTA: Cada mes se creará una nueva copia total