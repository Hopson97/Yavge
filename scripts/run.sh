#!/bin/bash

if [ "$1" = "release" ]
then
    ./build/release/bin/basic3 
else
    ./build/debug/bin/basic3 
fi