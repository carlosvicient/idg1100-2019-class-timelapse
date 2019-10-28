#!/bin/bash

display_usage() {
    echo "This script must be run with 2 arguments."
    echo -e "\nUsage:\n $0 nGroups nPicsPerGroup \n"
}

echo "Executing script $0 (PID: $$)"

#USE
# ./class-timelapse nGroups nPicturesPerGroup
if [  $# -ne 2 ]
then
    display_usage
    exit 1
fi

N_GROUPS=$1
N_PICS_PER_GROUP=$2;
IMAGE_FOLDER="images"
EXT="jpg"
TMP="tmp"
TIMELAPSES="timelapses"

mkdir -p $TMP
mkdir -p $TIMELAPSES

count=1
for (( pic=1; pic<=$N_PICS_PER_GROUP; pic++ ))
do
    echo "Adding first round of pictures pic:$pic..."
    for (( group=1; group<=$N_GROUPS; group++, count++ ))
    do
        #max number of pictures 9999
        c4digits=$(printf "%04d" $count)
        cp $IMAGE_FOLDER/$group/$pic.$EXT $TMP/$c4digits.$EXT
    done
done

( cd $TMP ; ffmpeg -framerate 2 -pattern_type glob -i '*.jpg' -c:v libx264 -r 15 -pix_fmt yuv420p ../$TIMELAPSES/all-timelapse.mp4)
rm -rf $TMP