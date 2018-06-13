#!/bin/bash

DIRECTORIO=$1
ARCHIVO=$2
MP3=$3

gst-launch-1.0 multifilesrc location=$DIRECTORIO/timelapse%05d.jpeg index=0 caps="image/jpeg,framerate=30/1" ! jpegdec ! queue ! omxh264enc target-bitrate=8000000 control-rate=variable ! video/x-h264,framerate=30/1,profile=high ! h264parse ! avimux name=m ! filesink location=$ARCHIVO filesrc location=$MP3 ! queue ! mpegaudioparse ! m.
