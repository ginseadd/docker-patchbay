#!/bin/bash

if [ $# -lt 1 ]; then
  echo "First argument should be the path to your .ssb directory (or where you want to have it created)"
  exit 1
fi

SSBDIR="$1"
docker run --rm -it -v /tmp/.X11-unix:/tmp/.X11-unix -e DISPLAY=unix$DISPLAY -v $SSBDIR:/root/.ssb patchbay npm start
