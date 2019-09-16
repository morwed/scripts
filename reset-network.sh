#!/bin/sh

echo "Flushing routes...";
for i in $(ifconfig | egrep -o "^[a-z].+\d{1}:" | sed 's/://');
do
	echo "interface $i going DOWN"
	sudo ifconfig "$i" down;
done;
sudo route -n flush;
for i in $(ifconfig | egrep -o "^[a-z].+\d{1}:" | sed 's/://');
do
	echo "interface $i going UP"
	sudo ifconfig "$i" up;
done