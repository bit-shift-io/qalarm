#!/bin/bash

# https://github.com/LaurentGomila/qt-android-cmake
# https://github.com/calincru/QML-Android-Demo

# ensure the following is installed
# android-sdk
# android-ndk
# android-sdk-build-tools-xxx

# deinfe temorary paths if need be
# put these in ~/.bashrc
export ANDROID_NDK="/opt/android-ndk/"
export ANDROID_SDK="/opt/android-sdk/"
export JAVA_HOME="/usr/lib/jvm/default/"
export ANDROID_TOOLCHAIN_ROOT="/opt/android-ndk/toolchains/"

mkdir -p build_android
cd build_android
cmake -DCMAKE_TOOLCHAIN_FILE=${ANDROID_NDK}/build/cmake/android.toolchain.cmake -DANDROID=ON ..
#cmake ..
make
#sudo make install
$SHELL
