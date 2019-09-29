TEMPLATE = app

QT += qml quick widgets quickwidgets core
SUBDIRS = src \
    plugin

SOURCES += \
    src/main.cpp

RESOURCES += src/qml/qml.qrc \
    res/qml.qrc

QML_IMPORT_PATH += $$PWD

target.path = $$[QT_INSTALL_EXAMPLES]/build/alarm
INSTALLS += target

HEADERS += 

DISTFILES += \
    plugin/CMakeLists.txt \
    plugin/Util/CMakeLists.txt \
    plugin/Util/qmldir \
    src/qml/AlarmDelegate.qml \
    src/qml/AlarmDialog.qml \
    src/qml/AlarmModel.qml \
    src/qml/Config.qml \
    src/qml/JsonListModel.qml \
    src/qml/Style.qml \
    src/qml/Theme.qml \
    src/qml/Theme1.qml \
    src/qml/TumblerDelegate.qml \
    src/qml/main.qml \
    src/qml/qmldir \
    src/qml/qtquickcontrols2.conf


