#! /bin/bash

if [ "$(uname)" == "Darwin" ]; then
  echo "date: " $(date +%Y-%m-%dT%H:%M:%S%z)
else
  echo "date: " $(date --iso-8601=seconds)
fi




