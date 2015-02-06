cmake_minimum_required(VERSION 2.8)

project("vm")

set(SOURCE_DIR "${CMAKE_CURRENT_LIST_DIR}/../../..")
set(CMAKELIST_DIR "${SOURCE_DIR}/misc/CMakeLists")

include("${CMAKELIST_DIR}/include/default_options.cmake")

set(BASEGAME "${DEFAULT_BASEGAME}" CACHE STRING "Directory for the base game")
set(MISSIONPACK "${DEFAULT_MISSIONPACK}" CACHE STRING "Directory for the missionpack")

add_subdirectory("${BASEGAME}")
add_subdirectory("${MISSIONPACK}")
