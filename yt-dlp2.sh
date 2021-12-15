#!/bin/env bash

URL=$1
echo $URL

proxychains yt-dlp -f 'bv*+ba' $URL --external-downloader aria2c --downloader-args aria2c:"-x 16 -k 10M"

