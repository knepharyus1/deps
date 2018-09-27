#!/bin/sh

urlfile="./urls"
datadir="./data"

for url in $(cat $urlfile); do
  ofile=$(echo $url | md5sum | cut -d' ' -f1)
  curl -k $url -o $datadir/$ofile
done

./push.sh
