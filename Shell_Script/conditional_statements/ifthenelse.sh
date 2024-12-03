#!/bin/bash

FILE=export.txt

if [[ ! -f  $FILE ]];then
  touch $FILE
else
  echo "file exists"
fi

