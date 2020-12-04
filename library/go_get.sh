#!/bin/sh -e

. $1

GOPATH="$HOME/.go"

if [ -x "$GOPATH/bin/$(basename $name)" ]; then
    echo "{\"changed\":false}"
    exit 0
fi

GO111MODULE=on go get "$name@latest"

echo "{\"changed\":true}"
