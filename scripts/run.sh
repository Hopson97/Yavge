#!/bin/bash

if [ "$1" = "release" ]
then
    ./build/release/bin/yavge 
else
    ./build/debug/bin/yavge 
fi