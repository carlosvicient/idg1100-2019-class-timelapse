#!/bin/bash

display_usage() {
    echo "This script must be run with 1 argument."
    echo -e "\nUsage:\n $0 groupNumber \n"
}

echo "Executing script $0 (PID: $$)"

#USE
# ./class-timelapse nGroups nPicturesPerGroup
if [  $# -ne 1 ]
then
    display_usage
    exit 1
fi



#Init variables
IMAGE_ROOT_FOLDER="images"
IMAGE_GROUP_FOLDER=$1
TARGET_FOLDER_FULL_PATH="$IMAGE_ROOT_FOLDER/$IMAGE_GROUP_FOLDER"
TIMELAPSES="timelapses"

mkdir -p $TIMELAPSES

#####
## ls -1 (list 1 file per line)
## wc -l counts number of lines (but ls -1 | wc -l adds some spaces in front of the number of files)
## awk ... convert the string to number
NUM_FILES=$(ls -1 $TARGET_FOLDER_FULL_PATH | wc -l | awk '{temp = $1 + 0; print temp}')
echo "creating timelapse for $TARGET_FOLDER_FULL_PATH. Total number of files to process: $NUM_FILES"

( cd $TARGET_FOLDER_FULL_PATH ; ffmpeg -framerate 1 -pattern_type glob -i '*.jpg' -i %01d.JPG -c:v libx264 -r 30 -pix_fmt yuv420p ../../$TIMELAPSES/group$IMAGE_GROUP_FOLDER-timelapse.mp4)