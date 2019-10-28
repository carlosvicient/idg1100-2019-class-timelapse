#!/bin/bash

display_usage() {
    echo "This script has no arguments"
}

echo "Executing script $0 (PID: $$)"

#USE
# ./class-timelapse nGroups nPicturesPerGroup
if [  $# -ne 0 ]
then
    display_usage
    exit 1
fi

IMAGE_ROOT_FOLDER="images"

#####
## ls -1 (list 1 file per line)
## wc -l counts number of lines (but ls -1 | wc -l adds some spaces in front of the number of files)
## awk ... convert the string to number
N_GROUPS=$(ls -1 $IMAGE_ROOT_FOLDER | wc -l | awk '{temp = $1 + 0; print temp}')
echo "Creating 1 timelapse per group. Total number of groups: $N_GROUPS"

for (( group=1; group<=$N_GROUPS; group++, count++ ))
do
    ./group-timelapse.sh $group
done