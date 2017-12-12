#! /bin/bash

59 23  1-6 * 1 /backups/copia_nivel_0.sh;
59 23  7-31 * 1 /backups/copia_nivel_1.sh;
59 23  * 0,2-7 * /backups/copia_nivel_2.sh;