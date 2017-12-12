#!/bin/bash

rutas="/bin /usr/bin /sbin/ /usr/sbin"
find $rutas -type f -printf '%m ' -exec md5sum {} \; > /snapshot/registro_temp.txt 2>/dev/null


