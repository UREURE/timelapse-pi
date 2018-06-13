#!/bin/bash

DIR_BASE=$1

DIA=$(date +%d)
MES=$(date +%m)
ANIO=$(date +%Y)

CARPETA_ANIO=$DIR_BASE'/'$ANIO
CARPETA_MES=$DIR_BASE'/'$ANIO'/'$MES
CARPETA_DIA=$DIR_BASE'/'$ANIO'/'$MES'/'$DIA

if [ ! -d $CARPETA_ANIO ];
then
    mkdir -p $CARPETA_ANIO;
fi;

if [ ! -d $CARPETA_MES ];
then
    mkdir -p $CARPETA_MES;
fi;

if [ ! -d $CARPETA_DIA ];
then
    mkdir -p $CARPETA_DIA;
fi;

echo $CARPETA_DIA
