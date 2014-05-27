#!/bin/sh

WGET="/usr/bin/wget"

$WGET --timeout=10 http://www.google.com -O /tmp/google.idx &> /dev/null
if [ ! -s /tmp/google.idx ]
then
    echo "error"
else
    echo "ok"
fi