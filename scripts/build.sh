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
    if [ -d "$basic3 " ]
    then
        rm -rf -d basic3 
    fi

    mkdir -p basic3 
fi

# Creates the folder for the buildaries
mkdir -p basic3
mkdir -p basic3/Data
mkdir -p build
mkdir -p build/release
mkdir -p build/debug
cd build

conan install .. -s compiler.libcxx=libstdc++11 --build=missing

# Builds target
if [ "$1" = "release" ]
then
    target_release
    cp build/release/bin/basic3  basic3/basic3 
else
    target_debug
fi

cp -R Data basic3/Data
