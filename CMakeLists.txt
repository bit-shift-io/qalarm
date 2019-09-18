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

# our executable
add_executable(
    ${PROJECT_NAME}
    ${SOURCES}
    ${APP_RESOURCES}    # App resources file
)

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
