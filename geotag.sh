#!/bin/bash

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
