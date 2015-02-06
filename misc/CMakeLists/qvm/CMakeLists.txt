cmake_minimum_required(VERSION 2.8)

project("qvm")

set(SOURCE_DIR "${CMAKE_CURRENT_LIST_DIR}/../../..")
set(CMAKELIST_DIR "${SOURCE_DIR}/misc/CMakeLists")

include("${CMAKELIST_DIR}/include/default_options.cmake")

set(BASEGAME "${DEFAULT_BASEGAME}" CACHE STRING "")
set(MISSIONPACK "${DEFAULT_MISSIONPACK}" CACHE STRING "")

add_subdirectory("${BASEGAME}")
add_subdirectory("${MISSIONPACK}")

