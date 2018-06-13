#!/bin/bash

DIRECTORIO_RENOMBRADO=$1
DIRECTORIO_FINAL=$2

cd $DIRECTORIO_RENOMBRADO
ls *.jpeg | awk 'BEGIN{ a=0 }{ printf "mv \"%s\" timelapse%05d.jpeg\n", $0, a++ }' | bash
cd $DIRECTORIO_FINAL
