#!/bin/sh

trap "echo 'suppress signal'" 1 2 3 15

echo "$0 - begin"
sleep 1800
echo "$0 - end"
