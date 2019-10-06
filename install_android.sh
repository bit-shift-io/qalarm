#!/bin/bash

# https://github.com/LaurentGomila/qt-android-cmake
# https://github.com/calincru/QML-Android-Demo

# ensure the following is installed
# android-sdk
# android-ndk

# deinfe temorary paths if need be
export ANDROID_NDK="$PATH:/opt/android-ndk/"
export ANDROID_SDK="$PATH:/opt/android-sdk/"
export JAVA_HOME="$PATH:/usr/lib/jvm/default/"
#export ANDROID_TOOLCHAIN_ROOT="$PATH:/opt/android-ndk/toolchains/"

mkdir -p build_android
cd build_android
cmake -DCMAKE_TOOLCHAIN_FILE=${ANDROID_NDK}/build/cmake/android.toolchain.cmake -DANDROID=ON ..
#cmake ..
make
#sudo make install
$SHELL
