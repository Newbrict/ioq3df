cmake_minimum_required(VERSION 2.8)

project("ioquake3")

set(CMAKELIST_DIR "misc/CMakeLists")

include("${CMAKELIST_DIR}/include/default_options.cmake")

if(NOT CMAKE_BUILD_TYPE AND NOT CMAKE_CONFIGURATION_TYPES)
	message(STATUS "No build type set, but you can CMAKE_BUILD_TYPE or a generator with configurations.\n"
		"I.e: -DCMAKE_BUILD_TYPE=Release")
endif()
if(DEFINED BUILD_GAME_SO)
	message(DEPRECATION "BUILD_GAME_SO is deprecated, please use BUILD_GAME_VM.")
	set(BUILD_GAME_VM ${BUILD_GAME_SO})
	unset(BUILD_GAME_SO CACHE)
endif()
option(BUILD_BASEGAME "Build basegame (baseq3)" ${DEFAULT_BUILD_BASEGAME})
option(BUILD_CLIENT "Build client" ${DEFAULT_BUILD_CLIENT})
option(BUILD_GAME_QVM "Build quake virtual machine (qvm)" ${DEFAULT_BUILD_GAME_QVM})
option(BUILD_GAME_VM "Build native VM (so/dll)" ${DEFAULT_BUILD_GAME_VM})
option(BUILD_MISSIONPACK "Build missionpack" ${DEFAULT_BUILD_MISSIONPACK})
option(BUILD_RENDERER_OPENGL2 "Build renderer opengl2" ${DEFAULT_BUILD_RENDERER_OPENGL2})
option(BUILD_SERVER "Build server" ${DEFAULT_BUILD_SERVER})

option(USE_GIT_REV "Use Git revision for version" ${DEFAULT_USE_GIT_REV})

set(BASEGAME "${DEFAULT_BASEGAME}" CACHE STRING "Directory for the base game")
set(MISSIONPACK "${DEFAULT_MISSIONPACK}" CACHE STRING "Directory for the missionpack")


if(USE_GIT_REV)
	find_package(Git)

	if(NOT GIT_FOUND)
		set(GIT_EXECUTABLE "git")
	endif()

	execute_process(
		COMMAND "${GIT_EXECUTABLE}" show -s --pretty=format:%h-%ad --date=short
		WORKING_DIRECTORY "${CMAKE_SOURCE_DIR}"
		OUTPUT_VARIABLE GIT_REV
		RESULT_VARIABLE GIT_REV_RESULT
		ERROR_VARIABLE GIT_REV_ERROR
		OUTPUT_STRIP_TRAILING_WHITESPACE
	)

	if(NOT GIT_REV)
		message(WARNING "Could not find Git. ${GIT_REV_ERROR} ${GIT_REV_RESULT}")
	endif(NOT GIT_REV)
endif(USE_GIT_REV)

if(BUILD_CLIENT)
	add_subdirectory("${CMAKELIST_DIR}/client")

	if(USE_RENDERER_DLOPEN)
		add_subdirectory("${CMAKELIST_DIR}/renderergl1")
	endif(USE_RENDERER_DLOPEN)
	if(BUILD_RENDERER_OPENGL2)
		add_subdirectory("${CMAKELIST_DIR}/renderergl2")
	endif(BUILD_RENDERER_OPENGL2)
endif(BUILD_CLIENT)

if(BUILD_SERVER)
	add_subdirectory("${CMAKELIST_DIR}/server")
endif(BUILD_SERVER)

if(BUILD_GAME_VM)
	if(BUILD_BASEGAME)
		add_subdirectory("${CMAKELIST_DIR}/vm/${BASEGAME}")
	endif(BUILD_BASEGAME)

	if(BUILD_MISSIONPACK)
		add_subdirectory("${CMAKELIST_DIR}/vm/${MISSIONPACK}")
	endif(BUILD_MISSIONPACK)
endif(BUILD_GAME_VM)

if(BUILD_GAME_QVM)
	add_subdirectory("${CMAKELIST_DIR}/tools")

	if(BUILD_BASEGAME)
		add_subdirectory("${CMAKELIST_DIR}/qvm/${BASEGAME}")
	endif(BUILD_BASEGAME)

	if(BUILD_MISSIONPACK)
		add_subdirectory("${CMAKELIST_DIR}/qvm/${MISSIONPACK}")
	endif(BUILD_MISSIONPACK)
endif(BUILD_GAME_QVM)
