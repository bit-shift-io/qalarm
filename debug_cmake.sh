#!/bin/bash
mkdir -p build
cd build
cmake .. -DDEFINE_DEBUG=ON -DCMAKE_INSTALL_PREFIX=../install
make
#sudo make install
$SHELL