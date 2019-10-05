cmake_minimum_required(VERSION 3.1)

project(qalarm VERSION 1.0 LANGUAGES CXX)

# enable debug via cmd
# cmake -DDEFINE_DEBUG=ON -DCMAKE_INSTALL_PREFIX=/usr ..
option(DEFINE_DEBUG
  "Build using debug"
  OFF)

if(DEFINE_DEBUG)
  message("Adding Debug flag...")
  add_definitions(-DDEBUG)
  set(CMAKE_BUILD_TYPE Debug)
  message("Build type is " ${CMAKE_BUILD_TYPE})
endif(DEFINE_DEBUG)


# debug, enable debugging
# https://doc.qt.io/qt-5/qtquick-debugging.html#qml-debugging-infrastructure
if (CMAKE_BUILD_TYPE STREQUAL "Debug")
    set(CMAKE_CXX_FLAGS_DEBUG "${CMAKE_CXX_FLAGS_DEBUG} -DQT_QML_DEBUG ")
    message(STATUS "debug enabled")
endif (CMAKE_BUILD_TYPE STREQUAL "Debug")

# set output directories
set(CMAKE_ARCHIVE_OUTPUT_DIRECTORY ${CMAKE_BINARY_DIR}/$<CONFIG>) # /lib
set(CMAKE_LIBRARY_OUTPUT_DIRECTORY ${CMAKE_BINARY_DIR}/$<CONFIG>) # /lib
set(CMAKE_RUNTIME_OUTPUT_DIRECTORY ${CMAKE_BINARY_DIR}/$<CONFIG>) # /bin

set(CMAKE_INCLUDE_CURRENT_DIR ON)
set(CMAKE_AUTOMOC ON)
set(CMAKE_AUTORCC ON) # for compiling qrc file to rcc
set(CMAKE_CXX_STANDARD 11)
set(CMAKE_CXX_STANDARD_REQUIRED ON)

# widgets for systray qapplication
find_package(Qt5 COMPONENTS REQUIRED Core Quick Widgets QuickWidgets)


set(SOURCES
    src/main.cpp
)

set(HEADERS
)

set(RESOURCES
    src/qml/qml.qrc
    res/qml.qrc
)


# for future use
if(ANDROID)
    # as library
    add_library(
        ${PROJECT_NAME}
        ${SOURCES}
        ${HEADERS}
        ${RESOURCES}
    )
else()
    # as executable
    add_executable(
        ${PROJECT_NAME}
        ${SOURCES}
        ${HEADERS}
        ${RESOURCES}    # App resources file
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
        Qt5::Widgets
        Qt5::QuickWidgets
)

# plugins dir (external to binary)
add_subdirectory(plugin)
