#!/bin/sh

ls |sort -R |tail -1 |while read file; do
	echo $file
done