#!/usr/bin/env bash
# -*- coding: utf8 -*-

# Author: Hwasung Lee

# This script downloads and links Bing's pictures to a fixed link.
#
# This script does three functions:
#   1. Execute bing-wallpaper script to download today's random picture.
#   2. Link it to $PICTURE_DIR/today.jpg
#   3. Randomly select a picture from $PICTURE_DIR/ that is not today's picture
#      and link it to $PICTURE_DIR/random.jpg
#
# Usage examples: (1) If the desktop background is set to $PICTURE_DIR/today.jpg
# this script will ensure it is always today's bing picture. (2) A Gnome
# slideshow can be setup to rotate between today.jpg and random.jpg. Look at the
# tools under gnome-bing-slideshow/


# If an error occurs, give up and terminate.
#set -e

SCRIPT_DIR="$(dirname ${BASH_SOURCE[0]})"
BING_SCRIPT="${SCRIPT_DIR}/../bing-wallpaper.sh"

printf "Running the bing-wallpaper script and loading settings.\n\n"
# NOTE: $PICTURE_DIR and $filename is sourced from bing-wallpaper.sh
source ${BING_SCRIPT}

printf "Ensuring there are no symlink errors.\n"
printf "Removing: ${PICTURE_DIR}today.jpg\n"
printf "Removing: ${PICTURE_DIR}random.jpg\n\n"
rm "${PICTURE_DIR}today.jpg" "${PICTURE_DIR}random.jpg"

printf "Linking today's Bing wallpaper.\n"
printf "Picture: ${PICTURE_DIR}${filename}\n"
printf "Ln link: ${PICTURE_DIR}today.jpg.\n\n"
ln -s -f "${PICTURE_DIR}${filename}" "${PICTURE_DIR}today.jpg"

echo 'Randomly selecting a picture and linking it to random.jpg'
RANDOM_PICTURE=$(ls ${PICTURE_DIR}*_*.jpg | grep -v ${filename} | shuf -n 1)
printf "Random: $RANDOM_PICTURE\n"
printf "Link to: ${PICTURE_DIR}random.jpg\n\n"
ln -s -f $RANDOM_PICTURE "${PICTURE_DIR}random.jpg"
printf "Succes!\n"
