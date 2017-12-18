#! /bin/bash

rutas="/bin /user/bin /sbin/ /user/sbin"

if [[ $1 == '-d' ]];then
	mkdir "/snapshot"
	find $rutas -type f -printf '%m' -exec md5sum {} \; > /snapshot/registro.txt 2>/dev/null
else
	find $rutas -type f -printf '%m' -exec md5sum {} \; 2>/dev/null
fi