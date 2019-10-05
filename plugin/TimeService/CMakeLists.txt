# https://stackoverflow.com/questions/51022680/building-qt-qml-plugin-using-cmake


set(PLUGIN_NAME
    TimeService
)

#qt5_add_resources(PLUGIN_RESOURCES ${CMAKE_CURRENT_LIST_DIR}/plugin.qrc)

add_library(
    ${PLUGIN_NAME}
    SHARED # STATIC - compiled into binary | SHARED - so file, external plugin

    # h files
    ${CMAKE_CURRENT_LIST_DIR}/plugin.h
    ${CMAKE_CURRENT_LIST_DIR}/time_service.h
    ${CMAKE_CURRENT_LIST_DIR}/minute_timer.h

    # cpp files
    ${CMAKE_CURRENT_LIST_DIR}/time_service.cpp

    # It's not important to include 'qmldir' or 'plugin.qmltypes' here,
    # but it will make IDEs (such as Qt Creator) to include them in project tree
    ${CMAKE_CURRENT_LIST_DIR}/qmldir
    #${CMAKE_CURRENT_LIST_DIR}/plugin.qmltypes

    ${PLUGIN_RESOURCES}     # Plugin resources file
)

set(CMAKE_AUTOMOC ON)
find_package(Qt5 REQUIRED COMPONENTS Quick Core Qml)

target_compile_features(
    ${PLUGIN_NAME}
    PRIVATE
        cxx_auto_type
        cxx_generic_lambdas
)

target_compile_options(
    ${PLUGIN_NAME}
    PRIVATE
        -Wall
        -Wextra
        -Wpedantic
)

target_link_libraries(
    ${PLUGIN_NAME}
    PRIVATE
        Qt5::Core
        Qt5::Quick
        Qt5::Qml
)

# only need these if we want to move the build files
# set plugin output dir
set_target_properties(${PLUGIN_NAME} PROPERTIES
    AUTOMOC TRUE
    LIBRARY_OUTPUT_DIRECTORY ${CMAKE_BINARY_DIR}/$<CONFIG>/plugin/${PLUGIN_NAME}
)

# During plugin searching Qt will be looking for 'qmldir' file
# So we should place it next to our plugin lib.
add_custom_command(
    TARGET ${PLUGIN_NAME}
    POST_BUILD
    COMMAND
        ${CMAKE_COMMAND} -E copy
        ${CMAKE_CURRENT_LIST_DIR}/qmldir
        ${CMAKE_BINARY_DIR}/$<CONFIG>/plugin/${PLUGIN_NAME}/qmldir # $<TARGET_FILE_DIR:${PLUGIN_NAME}>/qmldir
)
