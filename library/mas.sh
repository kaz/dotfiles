#!/bin/sh -e

. $1

if (mas lucky "$name" | grep "already installed"); then
    echo "{\"changed\":false}"
else
    echo "{\"changed\":true}"
fi
