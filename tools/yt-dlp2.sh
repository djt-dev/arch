#!/bin/env bash

URL=$1
echo $URL
proxychains yt-dlp -f 137+140 $URL --external-downloader aria2c --downloader-args aria2c:"-x 16 -k 1M"

