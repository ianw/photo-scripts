#!/bin/bash

COPYTO=/home/ianw/media/photos/import
LATEST_FILE=/home/ianw/media/photos/import/.latest-gf3

name_to_id () {
    ID=`basename $1`
    ID=${ID/P1//}
    ID=${ID/.JPG//}
    ID=`echo $ID | sed -e 's|/||g'`
    echo $ID
}

if [ ! -f $LATEST_FILE ]; then
    echo 'Starting at zero!'
    echo 0 > $LATEST_FILE
fi

LATEST=`cat $LATEST_FILE`
echo Latest is $LATEST

#for i in /media/LX3/DCIM/*
#for i in /media/3230-6530/DCIM/*
#for i in /media/2418-78BB/DCIM/*
#for i in /media/1C10-EB6D/DCIM/*
#for i in /media/BB9A-A71E/DCIM/*
#for i in /media/usb0/DCIM/*
#for i in /media/ianw/3538-6138/DCIM/*
for i in /media/ianw/3039-6635/DCIM/*
do
  cd $i
  for f in $i/*.JPG
  do
    ID=`name_to_id $f`
    if [ $ID -gt $LATEST ]; then
        echo copying $f
        cp $f $COPYTO
        LATEST=$ID
    fi
  done
  echo $LATEST > $LATEST_FILE
done
