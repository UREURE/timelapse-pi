#!/bin/bash

DIRECTORIO=$1

# La altura es 1072 (múltiplo de 16) en lugar de 1080 para que no falle la generación del vídeo.
raspistill -vf -hf -e jpg -q 100 -o $DIRECTORIO/timelapse%05d.jpeg -w 1920 -h 1072 -tl 4000 -t 64800000
