#!/bin/bash

DIR_BASE="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

CARPETA_DIA=$($DIR_BASE/crear_directorios.sh $DIR_BASE)

FECHA=$(date +"%d/%m/%Y")

ARCHIVO_VIDEO=$CARPETA_DIA'/timelapse.avi'
ARCHIVO_AUDIO=$DIR_BASE'/musica_video.mp3'

LOG=$CARPETA_DIA'/log.txt'
echo >> $LOG 2>&1
echo >> $LOG 2>&1

# Capturar imágenes.
echo 'Captura de imágenes comenzada el '$(date +"%d/%m/%Y")' a las '$(date +"%H:%M")'.' >> $LOG 2>&1
echo >> $LOG 2>&1
echo 'Ejecutando:' >> $LOG 2>&1
echo >> $LOG 2>&1
echo '__________________' >> $LOG 2>&1
echo >> $LOG 2>&1
cat $DIR_BASE/capturar_1920_1072_jpeg.sh >> $LOG 2>&1
echo >> $LOG 2>&1
echo '__________________' >> $LOG 2>&1
echo >> $LOG 2>&1
$DIR_BASE/capturar_1920_1072_jpeg.sh $CARPETA_DIA > /dev/null 2>&1
echo >> $LOG 2>&1

# Renombrar imágenes capturadas para que los nombres de archivos sigan una secuencia continua.
# En ocasiones se pierden imágenes capturadas de la cámara.
echo 'Renombrado de imágenes comenzado el '$(date +"%d/%m/%Y")' a las '$(date +"%H:%M")'.' >> $LOG 2>&1
echo >> $LOG 2>&1
echo 'Ejecutando:' >> $LOG 2>&1
echo >> $LOG 2>&1
echo '__________________' >> $LOG 2>&1
echo >> $LOG 2>&1
cat $DIR_BASE/renombrar.sh  >> $LOG 2>&1
echo >> $LOG 2>&1
echo '__________________' >> $LOG 2>&1
echo >> $LOG 2>&1
$DIR_BASE/renombrar.sh $CARPETA_DIA $DIR_BASE >> /dev/null 2>&1
echo >> $LOG 2>&1

NUMERO_IMAGENES=$($DIR_BASE/numero_ficheros.sh $CARPETA_DIA "jpeg")
TAMANIO_IMAGENES=$($DIR_BASE/tamanio_carpeta.sh $CARPETA_DIA)
echo 'Número de imágenes capturadas: '$NUMERO_IMAGENES'.' >> $LOG 2>&1
echo 'Total tamaño imágenes capturadas: '$TAMANIO_IMAGENES'.' >> $LOG 2>&1
echo >> $LOG 2>&1

# Generar el vídeo a partir de las imágenes capturadas.
echo 'Generación del vídeo comenzada el '$(date +"%d/%m/%Y")' a las '$(date +"%H:%M")'.' >> $LOG 2>&1
echo >> $LOG 2>&1
echo 'Ejecutando:' >> $LOG 2>&1
echo >> $LOG 2>&1
echo '__________________' >> $LOG 2>&1
echo >> $LOG 2>&1
cat $DIR_BASE/codificar_avi_mp3.sh  >> $LOG 2>&1
echo >> $LOG 2>&1
echo '__________________' >> $LOG 2>&1
echo >> $LOG 2>&1
$DIR_BASE/codificar_avi_mp3.sh $CARPETA_DIA $ARCHIVO_VIDEO $ARCHIVO_AUDIO >> $LOG 2>&1
echo >> $LOG 2>&1

# Borrar las imágenes capturadas.
echo 'Borrado de imágenes comenzado el '$(date +"%d/%m/%Y")' a las '$(date +"%H:%M")'.' >> $LOG 2>&1
echo >> $LOG 2>&1
rm $CARPETA_DIA/*.jpeg >> $LOG 2>&1
echo >> $LOG 2>&1

TAMANIO_VIDEO=$($DIR_BASE/tamanio_carpeta.sh $CARPETA_DIA)
echo 'Total tamaño vídeo generado: '$TAMANIO_VIDEO'.' >> $LOG 2>&1
echo >> $LOG 2>&1

# Subir vídeo a YouTube.
echo 'Subida del vídeo a YouTube comenzada el '$(date +"%d/%m/%Y")' a las '$(date +"%H:%M")'.' >> $LOG 2>&1
echo 'Ejecutando script: upload_video.py.' >> $LOG 2>&1
echo >> $LOG 2>&1
cd $DIR_BASE

INTENTO=1
echo 'Intentos de subida a YouTube: '$INTENTO'.' >> $LOG 2>&1
echo >> $LOG 2>&1
DESCRIPCION_VIDEO=$(cat $LOG)
RESULTADO_YOUTUBE=$(python $DIR_BASE/upload_video.py --file=$ARCHIVO_VIDEO --title="TimeLapse Madrid $FECHA" --description="Log proceso:$DESCRIPCION_VIDEO" --keywords="TimeLapse, Time, Lapse, Madrid, Raspberry, Pi, Camera" --category=28 --privacyStatus="public" --noauth_local_webserver)
echo $RESULTADO_YOUTUBE >> $LOG 2>&1
echo >> $LOG 2>&1

until [[ $RESULTADO_YOUTUBE == *"was successfully uploaded"* ]]; do
  sleep 20m
  INTENTO=$(($INTENTO+1))
  echo 'Intentos de subida a YouTube: '$INTENTO'.' >> $LOG 2>&1
  echo >> $LOG 2>&1
  DESCRIPCION_VIDEO=$DESCRIPCION_VIDEO' '$INTENTO'.'
  RESULTADO_YOUTUBE=$(python $DIR_BASE/upload_video.py --file=$ARCHIVO_VIDEO --title="TimeLapse Madrid $FECHA" --description="Log proceso:$DESCRIPCION_VIDEO" --keywords="TimeLapse, Time, Lapse, Madrid, Raspberry, Pi, Camera" --category=28 --privacyStatus="public" --noauth_local_webserver)
  echo $RESULTADO_YOUTUBE >> $LOG 2>&1
  echo >> $LOG 2>&1
done

if [[ $RESULTADO_YOUTUBE == *"was successfully uploaded"* ]]; then
  # Borrar el vídeo generado.
  echo 'Borrado del vídeo comenzado el '$(date +"%d/%m/%Y")' a las '$(date +"%H:%M")'.' >> $LOG 2>&1
  echo >> $LOG 2>&1
  rm $ARCHIVO_VIDEO >> $LOG 2>&1
  echo >> $LOG 2>&1
fi

echo 'Proceso finalizado el '$(date +"%d/%m/%Y")' a las '$(date +"%H:%M")'.' >> $LOG 2>&1
echo >> $LOG 2>&1
