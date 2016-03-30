#!/bin/bash

# Use exiv2 to tag photos

# arguments : START STOP <location|exiv2 tags>
#  tags easily created by easygeotag.info
#  see geotag-locations.sample for example of how to keep locations

START=$1
shift
STOP=$1
shift

echo "** start ${START}"
echo "** stop ${STOP}"

# array LOCATION[foo]=exif2 str
. ~/.geotag-locations

for i in `seq --format="%06g" ${START} ${STOP}`
do
    IMG="P1${i}.JPG"
    echo "${IMG}"

    if [ -n "${LOCATION[$1]}" ]; then
        array="${LOCATION[$1]}"
        array="${array}[@]"
        set -- "${!array}"
    fi

    exiv2 "$@" ${IMG}
done
