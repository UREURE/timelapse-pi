#!/bin/bash

CARPETA=$1
EXTENSION=$2

NUMERO_FICHEROS_CARPETA=$(ls -1 $CARPETA/*.$EXTENSION | wc -l)

echo $NUMERO_FICHEROS_CARPETA