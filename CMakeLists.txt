cmake_minimum_required(VERSION 3.1)

project(qalarm VERSION 1.0 LANGUAGES CXX)

set(CMAKE_INCLUDE_CURRENT_DIR ON)
set(CMAKE_AUTOMOC ON)
set(CMAKE_AUTORCC ON)
set(CMAKE_CXX_STANDARD 11)
set(CMAKE_CXX_STANDARD_REQUIRED ON)

find_package(Qt5 COMPONENTS Core Quick REQUIRED)

# Telling CMake location of our .qrc file
qt5_add_resources(APP_RESOURCES ${CMAKE_CURRENT_LIST_DIR}/src/qml/qml.qrc)


set(SOURCES 
    src/main.cpp
)

# for future use
if(ANDROID)
    # as library
    add_library(
        ${PROJECT_NAME}
        ${SOURCES}
        ${APP_RESOURCES}
    )
else()
    # as executable
    add_executable(
        ${PROJECT_NAME}
        ${SOURCES}
        ${APP_RESOURCES}    # App resources file
    )
endif()

# more android specifics
# https://github.com/LaurentGomila/qt-android-cmake
if(ANDROID)
    include(android/AddQtAndroidApk.cmake)
    add_qt_android_apk(
        my_app_apk my_app
        NAME "My App"
        VERSION_CODE 6 #  incremented everytime your app is updated on the play store
        PACKAGE_NAME "io.bitshift.qalarm"
        PACKAGE_SOURCES ${CMAKE_CURRENT_LIST_DIR}/android
        KEYSTORE ${CMAKE_CURRENT_LIST_DIR}/mykey.keystore myalias
        INSTALL # install to default adb device
    )
endif()


target_compile_definitions(
    ${PROJECT_NAME}
    PRIVATE
    $<$<OR:$<CONFIG:Debug>,$<CONFIG:RelWithDebInfo>>:QT_QML_DEBUG>
)

target_link_libraries(
    ${PROJECT_NAME}
    PRIVATE
        Qt5::Core
        Qt5::Quick
)
