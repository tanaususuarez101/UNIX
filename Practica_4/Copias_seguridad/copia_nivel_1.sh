#!/bin/bash
FECHA=$(date +"%Y%m%d")
RUTA="/backups"


#b) Demás lunes del mes: copia incremental de nivel
touch $RUTA/testigo_lunes;
find /home -newer $RUTA/testigo_lunes | tar czf $RUTA/backup_nivel1_$FECHA.tar -T -

## NOTA: Cada lunes del mes se creará un nueva copia con los cambios que se hayan producido del lunes anterior, al actual.
## No se dice nada sobre actualizar el contenido ya copiado el lunes pasado.