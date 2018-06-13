#!/bin/bash

CARPETA=$1

TAMANIO_CARPETA=$(du -bsh $CARPETA | awk '{ print $1 }')

echo $TAMANIO_CARPETA
