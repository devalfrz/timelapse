#!/bin/bash

# Timelapse image directory
DIR=/var/www/html/timelapse

# Device
DEVICE=/dev/video0

# Configuration File
CONFIG_FILE=/etc/timelapse/fswebcam.conf

# Edit this lines if you have the information from your webcam. You can 
# get this information by running the lsusb command and searching for
# your device.
MANUFACTURER_ID=""
DEVICE_ID=""

# Image Resolution
RESOLUTION=1280x720

# Time for capturing images
MORNING=8 # 8:00 am
NIGHT=20 # 8:00 pm


while [ true ]; do

  HOUR=$(date +"%H")
  if [ $MORNING -le $HOUR ] && [ $NIGHT -ge $HOUR ]; then

    # Create timelapse directory if doesn't exist
    mkdir $DIR -p

    # Create image file name
    IMAGE=$DIR/`date +"%Y-%m-%d_%H.jpg"`

    # Test if the image has already been captured
    if [ ! -f $IMAGE ]; then

      # If defined, get the device port number and usbreset program exists
      if [ -z "$DEVICE_ID" ] && [ -z "$MANUFACTURER_ID" ] && [ -f ./usbreset ]; then

        DEVICE_INFO=$(lsusb | grep $MANUFACTURER_ID:$DEVICE_ID | sed -e 's/^Bus \([0-9]*\) Device \([0-9]*\)\(.*\)$/\/dev\/bus\/usb\/\1\/\2/g')

        # Reset device if it was defined
        if [ -z "$DEVICE_INFO" ]; then
          ./usbreset $DEVICE_INFO
        fi
      fi

      # Capture imge
      fswebcam -r $RESOLUTION $IMAGE -S 10 -d $DEVICE -c $CONFIG_FILE

    fi
  fi
  
  # Wait 10 seconds
  sleep 10

done
