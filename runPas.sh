#!/bin/bash

if [ -z "$1" ]; then
    echo "ERROR: Invalid arguments"
    echo "Usage:" "$0" " yourCode.pas [-k(eep)]"
    exit 1
fi

filePath="$1"
keepMode=0
if [ "$2" == "-k" ] || [ "$2" == "-K" ]; then
    keepMode=1
fi

tempObjectName="tmp.obj"
tempListName="tmp.lst"
tempOutName="tmp.out"

if [ $keepMode -eq 1 ]; then
    tempObjectName="$filePath"".obj"
    tempListName="$filePath"".lst"
    tempOutName="$filePath"".out"
fi

# run the compiler
compiler="./pfccomp"
echo "---COMPILING---"
"$compiler" "$filePath" "$tempListName" "$tempObjectName"

# run the interpreter
interpreter="./pint"
echo "---RUNNING---"
"$interpreter" "$tempObjectName" "$tempOutName"

# cleanup if keep mode is off
if [ $keepMode -eq 0 ]; then
    rm "$tempObjectName" "$tempListName" "$tempOutName"
fi