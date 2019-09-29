TEMPLATE = lib
TARGET = Util
QT += qml quick
CONFIG += qt plugin

#TARGET = $$qtLibraryTarget($$TARGET)

# Input
SOURCES += \
    util.cpp

HEADERS += \
    util_plugin.h \
    util.h

OTHER_FILES += \
    qmldir

DISTFILES = qmldir
DESTDIR = plugin/Util
TARGET = Util

DESTPATH=$$PWD/plugin/Util

target.path=$$DESTPATH
qmldir.files=$$PWD/qmldir
qmldir.path=$$DESTPATH
INSTALLS += target qmldir

# Copy the qmldir file to the same folder as the plugin binary
QMAKE_POST_LINK += $$QMAKE_COPY $$replace($$list($$quote($$PWD/qmldir) $$DESTDIR), /, $$QMAKE_DIR_SEP)
