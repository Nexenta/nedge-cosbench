#!/bin/bash

echo "Starting $1"
if [  $1  ]; then
	echo 'lol'
else
	echo 'no'
fi

while [ ! -f log/system.log ]; do
   sleep 10
done

tail -f log/system.log
