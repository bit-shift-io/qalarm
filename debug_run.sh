#!/bin/bash
# https://doc.qt.io/qt-5/qtquick-debugging.html#qml-debugging-infrastructure
cd build
./qalarm -qmljsdebugger=port:29777,block
$SHELL