TEMPLATE = app

QT += quick
QT += widgets
SUBDIRS = src plugin/JsonSettings

SOURCES += src/main.cpp \
    src/util.cpp

RESOURCES += src/qml/qml.qrc

QML_IMPORT_PATH += $$PWD

target.path = $$[QT_INSTALL_EXAMPLES]/build/alarm
INSTALLS += target

HEADERS += \
    src/util.h
