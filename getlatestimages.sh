#!/bin/bash

# Get the latest images off a camera's SD card.  If you are reading
# this; this will not work for you ... it depends on the card, where
# it is mounted and the way it names files.  But you get the gist.

COPYTO=/home/ianw/media/photos/import
COPYFROM=/media/ianw/3039-6635/DCIM/
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

for i in $COPYFROM/*
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
