#!/bin/bash

target_release() {
    cd release
    cmake -DCMAKE_BUILD_TYPE=Release ../..
    make
    echo "Built target in build/release/"
    cd ../..
}

target_debug() {
    cd debug 
    cmake -DCMAKE_BUILD_TYPE=Debug ../..
    make
    echo "Built target in build/debug/"
    cd ../..
}

# Create folder for distribution
if [ "$1" = "release" ]
then
    if [ -d "$yavge " ]
    then
        rm -rf -d yavge 
    fi

    mkdir -p yavge 
fi

# Creates the folder for the buildaries
mkdir -p yavge
mkdir -p yavge/Data
mkdir -p build
mkdir -p build/release
mkdir -p build/debug
cd build

conan install .. -s compiler.libcxx=libstdc++11 --build=missing

# Builds target
if [ "$1" = "release" ]
then
    target_release
    cp build/release/bin/yavge  yavge/yavge 
else
    target_debug
fi

cp -R Data yavge/Data
