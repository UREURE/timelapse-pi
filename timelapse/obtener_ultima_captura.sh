#!/bin/bash

CARPETA=$1

ULTIMO_FICHERO_TIME_LAPSE=$(ls -t $CARPETA/timelapse*.jpeg | head -1)

echo $ULTIMO_FICHERO_TIME_LAPSE
