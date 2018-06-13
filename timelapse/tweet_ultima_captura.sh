#!/bin/bash

DIR_BASE="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

DIA=$(date +%d)
MES=$(date +%m)
ANIO=$(date +%Y)

CARPETA_DIA=$DIR_BASE'/'$ANIO'/'$MES'/'$DIA

LOG=$CARPETA_DIA'/log_twitter.txt'
echo >> $LOG 2>&1
echo >> $LOG 2>&1

echo 'Publicación de imagen en Twitter comenzada el '$(date +"%d/%m/%Y")' a las '$(date +"%H:%M")'.' >> $LOG 2>&1
echo >> $LOG 2>&1

ULTIMA_CAPTURA=$($DIR_BASE/obtener_ultima_captura.sh $CARPETA_DIA)

echo 'Última captura: '$ULTIMA_CAPTURA'.' >> $LOG 2>&1
echo >> $LOG 2>&1

sleep 2

ID_CAPTURA_TWITTER=$($DIR_BASE/tweet.sh upload $ULTIMA_CAPTURA | jq -r '.media_id_string')

echo 'Imagen subida a Twitter con ID: '$ID_CAPTURA_TWITTER'.' >> $LOG 2>&1
echo >> $LOG 2>&1

RESULTADO=$($DIR_BASE/tweet.sh tw -m $ID_CAPTURA_TWITTER 'Así está ahora el cielo de #Madrid. Quieres ver su #timelapse? Visita https://enlace mañana para ver el vídeo en @YouTube ;)')

echo 'JSON del tweet publicado con la imagen de la útlima captura: '$RESULTADO'.' >> $LOG 2>&1
echo >> $LOG 2>&1

echo 'Publicación en Twitter finalizada el '$(date +"%d/%m/%Y")' a las '$(date +"%H:%M")'.' >> $LOG 2>&1
echo >> $LOG 2>&1

echo '__________________' >> $LOG 2>&1

