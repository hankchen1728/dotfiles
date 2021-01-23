#!/bin/bash
# Program:
#    This file is used to download large files (public file) from google drive
# Usage:
#    ./google_drive_download.sh <file_share_id> <save_file_name>
# Reference:
#    https://www.matthuisman.nz/2019/01/download-google-drive-files-wget-curl.html

FILE_ID=$1
FILE_NAME=${2:-"download_file"}

# Make a folder for storing cookies
mkdir -p $HOME/tmp/
wget --save-cookies $HOME/tmp/cookies.txt 'https://docs.google.com/uc?export=download&id='$FILE_ID \
         -O- | sed -rn 's/.*confirm=([0-9A-Za-z_]+).*/\1/p' > $HOME/tmp/confirm.txt

wget --load-cookies $HOME/tmp/cookies.txt -O $FILE_NAME \
         'https://docs.google.com/uc?export=download&id='$FILE_ID'&confirm='$(< $HOME/tmp/confirm.txt)

# remove the cookies file
cd $HOME/tmp/
rm cookies.txt confirm.txt
