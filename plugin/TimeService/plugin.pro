TEMPLATE = lib
#TARGET = Util
QT += qml quick
CONFIG += qt plugin
#CONFIG += staticlib

TARGET = $$qtLibraryTarget($$TARGET)

# Input
SOURCES += \
    time_service.cpp

HEADERS += \
    plugin.h \
    time_service.h

OTHER_FILES += \
    qmldir

DISTFILES = qmldir
DESTDIR = plugin/TimeService
TARGET = TimeService

DESTPATH=$$PWD/plugin/TimeService

target.path=$$DESTPATH
qmldir.files=$$PWD/qmldir
qmldir.path=$$DESTPATH
INSTALLS += target qmldir

# Copy the qmldir file to the same folder as the plugin binary
QMAKE_POST_LINK += $$QMAKE_COPY $$replace($$list($$quote($$PWD/qmldir) $$DESTDIR), /, $$QMAKE_DIR_SEP)

# copy another way?
!equals(PRO_FILE_PWD, $$OUT_PWD) {
    copy_qmldir.target = $$OUT_PWD/$$DESTDIR/qmldir
    copy_qmldir.depends = $$PRO_FILE_PWD/qmldir
    copy_qmldir.commands = $(COPY_FILE) "$$replace(copy_qmldir.depends, /, $$QMAKE_DIR_SEP)" "$$replace(copy_qmldir.target, /, $$QMAKE_DIR_SEP)"

    sourceQmlFilesPath = $$_PRO_FILE_PWD_/MslQmlControllerItem.qml
    targetQmlFilesPath = $$OUT_PWD/$$DESTDIR/MslQmlControllerItem.qml
    copy_qmldir.commands += && $(COPY_FILE) \"$$replace(sourceQmlFilesPath, /, $$QMAKE_DIR_SEP)\" \"$$replace(targetQmlFilesPath, /, $$QMAKE_DIR_SEP)\"
    QMAKE_EXTRA_TARGETS += copy_qmldir
    PRE_TARGETDEPS += $$copy_qmldir.target
}
