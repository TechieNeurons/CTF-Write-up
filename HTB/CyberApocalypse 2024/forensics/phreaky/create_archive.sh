#!/bin/bash

for FILE in ./imf_dump/*; do
	filename=$(cat $FILE | grep 'filename\*1' | cut -d'"' -f2);
	filecontent=$(cat $FILE | tail -n11 | head -n10 | tr -d '\t\r\n ');
	base64 -d <<< $filecontent > $filename
done
