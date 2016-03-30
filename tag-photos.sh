#!/bin/bash

# Give every file in a directory a common title, and prompt for a
# caption.  e.g. I tag my photos by week, with the caption being
# something descriptive about the photo.

# this comes from Debian's python-iptcdata package
PRG=/usr/share/doc/python-iptcdata/examples/set_iptc.py

if [ $# -lt 1 ]; then
    echo "usage: title"
    exit 1
fi

last_caption=""

for i in *.JPG
do
    echo "Set caption for $i"
    read caption
    if [ "$caption" == "" ]; then
        caption=$last_caption
        echo "Using previous caption : " $caption
    else
        last_caption=$caption
    fi

    python $PRG -T "$1" -c "$caption" $i
done
