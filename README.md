# TimeLapse Pi

Proyecto educativo con una Raspberry Pi para:
* La generación de un vídeo TimeLapse y su publicación en [YouTube](https://www.youtube.com/channel/UCEMC5gzIGsH5YPr5IDWFLDw) diariamente.
* La publicación periódica en [Twitter](https://twitter.com/TimeLapse_Mad) de algunas imágenes que componen el vídeo TimeLapse.

## Requisitos

* Hardware:
  * [Raspberry Pi 2B](https://www.raspberrypi.org/products/raspberry-pi-2-model-b/) o superior.
  * [Pi Camera v2](https://www.raspberrypi.org/products/camera-module-v2/) con filtro IR (no se pretende capturar imágenes por la noche).
* Sistema Operativo: [Raspbian](https://www.raspberrypi.org/downloads/raspbian/) (Stretch).
* Dependencias:
  * *Falta detallar*.
* Conexión a Internet.

## Scripts Auxiliares

* [crear_directorios.sh](/timelapse/crear_directorios.sh): genera y retorna la estructura de carpetas AÑO/MES/DIA para la ejecución del proceso.
* [capturar_1920_1072_jpeg.sh](/timelapse/capturar_1920_1072_jpeg.sh): captura una imagen JPG de 1920x1072 pixeles, cada 4 segundos, durante 18 horas (1072 es múltiplo de 16, necesario para la generación del vídeo).
* [numero_ficheros.sh](/timelapse/numero_ficheros.sh): obtiene el número de archivos que existen en un directorio.
* [obtener_ultima_captura.sh](/timelapse/obtener_ultima_captura.sh): obtiene el archivo de la última imagen capturada por el proceso (puede que el archivo no se haya terminado de persistir).
* [renombrar.sh](/timelapse/renombrar.sh): renombra los ficheros de las imágenes capturadas para que estén en orden, y sin los posibles huecos de las capturas fallidas.
* [tamanio_carpeta.sh](/timelapse/tamanio_carpeta.sh): obtiene el tamaño en disco de un directorio.
* [codificar_avi_mp3.sh](/timelapse/codificar_avi_mp3.sh): genera el vídeo con las imágenes capturadas durante el proceso, y con el audio del fichero MP3.

## Audio

* [musica_video.mp3](/timelapse/musica_video.mp3): este archivo debe ser MP3 y tener una duración de 9 minutos (aproximadamente).

## Puntos de Entrada

1. [timelapse.sh](/timelapse/timelapse.sh): proceso que captura imágenes, genera un vídeo, y lo sube a Youtube.
   1. Este proceso es independiente, no necesita de ningún otro para funcionar.
1. [tweet_ultima_captura.sh](/timelapse/tweet_ultima_captura.sh): proceso que publica en Twitter la última captura realizada por [timelapse.sh](/timelapse/timelapse.sh).
   1. Este proceso no funcionará si el proceso anterior no está activo.

## Crontab

Es necesario programar la ejecución periódica de los procesos. Lo más fácil es utilizar [crontab](https://linux.die.net/man/5/crontab). Los siguientes ejemplos funcionan si la carpeta "timelapse" con los scripts se encuentra en el directorio "home" del usuario.

* Ejecutar el proceso [timelapse.sh](/timelapse/timelapse.sh) todos los días a las 05:00 horas.

```crontab
0 5 * * * ~/timelapse/timelapse.sh > /dev/null 2>&1
```

* Ejecutar el proceso [tweet_ultima_captura.sh](/timelapse/tweet_ultima_captura.sh) todos los días a las:
  * 06:00 horas.
  * 08:00 horas.
  * 10:00 horas.
  * 12:00 horas.
  * 14:00 horas.
  * 16:00 horas.
  * 18:00 horas.
  * 20:00 horas.
  * 22:00 horas.

```crontab
0 6,8,10,12,14,16,18,20,22 * * * ~/timelapse/tweet_ultima_captura.sh > /dev/null 2>&1
```

## Scripts de Terceros

* [upload_video.py](/timelapse/upload_video.py): script (python) para la subida de vídeos a YouTube; el script original proporcionado por YouTube está [aquí](https://github.com/youtube/api-samples/blob/master/python/upload_video.py).
* [tweet.sh](/timelapse/tweet.sh): script para la publicación de contenido en Twitter; el script original está [aquí](https://github.com/piroor/tweet.sh/blob/master/tweet.sh).

## API Keys

Es necesario reemplazar el contenido de los siguientes ficheros con las API Keys proporcionadas por el proveedor:
* [client_secrets.json](/timelapse/client_secrets.json): credenciales utilizadas por el script [upload_video.py](/timelapse/upload_video.py).
* [tweet.client.key](/timelapse/tweet.client.key): credenciales utilizadas por el script [tweet.sh](/timelapse/tweet.sh).

