#!/bin/bash
# ensure the following is installed
# android-sdk
# android-ndk

# deinfe temorary paths if need be
#export ANDROID_NDK="$PATH:test"
#export ANDROID_SDK="$PATH:test"
#export JAVA_HOME="$PATH:test"

mkdir -p build_android
cd build_android
cmake -DCMAKE_TOOLCHAIN_FILE=${ANDROID_NDK}/build/cmake/android.toolchain.cmake .
cmake ..
make
#sudo make install
$SHELL