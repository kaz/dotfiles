#!/bin/sh -e

. $1

if [ -x "$GOPATH/bin/$(basename $name)" ]; then
    echo "{\"changed\":false}"
    exit 0
fi

go get -u "$name"

echo "{\"changed\":true}"
