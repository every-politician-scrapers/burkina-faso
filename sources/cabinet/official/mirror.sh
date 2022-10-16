#!/bin/bash

cd $(dirname $0)

if [[ $(jq -r .reference.P854 meta.json) == http* ]]
then
  TMPFILE=$(mktemp)
  CURLOPTS='-L -c /tmp/cookies -A eps/1.2'

  curl $CURLOPTS -o $TMPFILE $(jq -r .reference.P854 meta.json)

  if grep -q "403 Forbidden" $TMPFILE; then
    echo "403 Forbidden"
    exit
  else
    mv $TMPFILE official.html
  fi
fi

cd ~-
