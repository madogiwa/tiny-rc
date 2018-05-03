#!/bin/sh

trap 'echo "suppress signal"' 1 2 3 15

echo "$0 - begin"
while :
do
    echo "$0 - loop"
    sleep 30
done
echo "$0 - end"
