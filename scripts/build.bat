echo "Ensure you have ran conan remote add bincrafters https://api.bintray.com/conan/bincrafters/public-conan"
mkdir build
cd build
mkdir release
conan install .. --build=missing
cd release
cmake ../.. -G "Visual Studio 16" 
cmake --build . --config Release
echo "Built target in bin/release/"
