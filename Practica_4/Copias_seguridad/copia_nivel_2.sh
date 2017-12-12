#!/bin/bash
FECHA=$(date +"%Y%m%d")
RUTA="/backups"

#c) todos los martes, miércoles, jueves, viernes, sábados y domingos: copia de nivel 2
find /home -newer $RUTA/testigo_lunes | tar czf $RUTA/backup_nivel2_$FECHA.tar -T -

## Se creará por cada día una copia nueva, desde el lunes que se hizo la copia nivel 1.
