# The MIT License (MIT)
# 
# Copyright (c) 2015 github.com/Pan7
#
# Permission is hereby granted, free of charge, to any person obtaining a copy
# of this software and associated documentation files (the "Software"), to deal
# in the Software without restriction, including without limitation the rights
# to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
# copies of the Software, and to permit persons to whom the Software is
# furnished to do so, subject to the following conditions:
#
# The above copyright notice and this permission notice shall be included in all
# copies or substantial portions of the Software.
# 
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
# OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
# SOFTWARE.
# 
cmake_minimum_required(VERSION 2.8.9)

set(OPUSFILE_TARGET "internal_opusfile")


include(CheckCCompilerFlag RESULT_VARIABLE MODULE_CHECKCCOMPILERFLAG_EXISTS)



set(OPUSFILE_SOURCES 
	"${OPUSFILE_DIR}/src/http.c"
	"${OPUSFILE_DIR}/src/info.c"
	"${OPUSFILE_DIR}/src/internal.c"
	"${OPUSFILE_DIR}/src/opusfile.c"
	"${OPUSFILE_DIR}/src/stream.c"
	"${OPUSFILE_DIR}/src/wincerts.c"
)
set(OPUSFILE_HEADERS 
	"${OPUSFILE_DIR}/include/opusfile.h"
)

set(OPUSFILE_INCLUDE_DIRS)
set(OPUSFILE_LIBRARIES)
set(OPUSFILE_DEFINITIONS)

set(OPUSFILE_DEFS)
set(OPUSFILE_CFLAGS)

if(MSVC)
	#Optimization, Maximum Speed /O2
	list(APPEND OPUSFILE_CFLAGS "$<$<CONFIG:Release>:/O2>")
	#Inline Function Expansion, only Suitable /Ob2
	list(APPEND OPUSFILE_CFLAGS "$<$<CONFIG:Release>:/Ob2>")
	#Enable Intrinsic Functions /Oi
	list(APPEND OPUSFILE_CFLAGS "$<$<CONFIG:Release>:/Oi>")
	#Favor Size of Speed, Favor Fast Code /Ot
	list(APPEND OPUSFILE_CFLAGS "$<$<CONFIG:Release>:/Ot>")
	#Omit Frame Pointers, Yes /Oy
	list(APPEND OPUSFILE_CFLAGS "$<$<CONFIG:Release>:/Oy>")

	#Enable String Pooling /GF
	list(APPEND OPUSFILE_CFLAGS "/GF")
	#Buffer Security Check, No /GS-
	list(APPEND OPUSFILE_CFLAGS "/GS-")
	#Enable Function-Level Linking /Gy
	list(APPEND OPUSFILE_CFLAGS "/Gy")
	#Floating Point Model /fp:fast
	list(APPEND OPUSFILE_CFLAGS "/fp:fast")

	#no warnings about using old functions like strcmp
	list(APPEND OPUSFILE_DEFS "-D_CRT_SECURE_NO_WARNINGS")

endif(MSVC)


if(CMAKE_COMPILER_IS_GNUCC)

	if(CMAKE_BUILD_TYPE MATCHES "Release")
		set(OFLAGS "-O4" "-O3" "-O2" "-O")
		foreach(OFLAG ${OFLAGS})
			CHECK_C_COMPILER_FLAG("${OFLAG}" COMPILER_HAS_O_FLAG)
			if(COMPILER_HAS_O_FLAG)
				list(APPEND OPUSFILE_CFLAGS "${OFLAG}")
				break()
			endif(COMPILER_HAS_O_FLAG)
		endforeach()
	endif()

	set(FLAGS "-std=c89" "-pedantic" "-Wall" "-Wextra" "-Wno-parentheses" "-Wno-long-long")

	if(MINGW)
		list(APPEND FLAGS "-U__STRICT_ANSI__")
	endif(MINGW)

	foreach(FLAG ${FLAGS})
		CHECK_C_COMPILER_FLAG("${FLAG}" COMPILER_HAS_FLAG)
		if(COMPILER_HAS_FLAG)
			list(APPEND OPUSFILE_CFLAGS "${FLAG}")
		endif(COMPILER_HAS_FLAG)
	endforeach()

	if(CMAKE_BUILD_TYPE MATCHES "Debug")
		set(FLAGS "-O0" "-ggdb")
		foreach(FLAG ${FLAGS})
			CHECK_C_COMPILER_FLAG("${FLAG}" COMPILER_HAS_FLAG)
			if(COMPILER_HAS_FLAG)
				list(APPEND OPUSFILE_CFLAGS "${FLAG}")
			endif(COMPILER_HAS_FLAG)
		endforeach()
	endif()

endif(CMAKE_COMPILER_IS_GNUCC)


if(CMAKE_CONFIGURATION_TYPES)
	list(APPEND OPUSFILE_DEFINITIONS "$<$<CONFIG:Debug>:-DOP_ENABLE_ASSERTIONS>")
endif(CMAKE_CONFIGURATION_TYPES)
if(CMAKE_BUILD_TYPE MATCHES "Debug")
	list(APPEND OPUSFILE_DEFINITIONS "-DOP_ENABLE_ASSERTIONS")
endif()


list(APPEND OPUSFILE_INCLUDE_DIRS "${OGG_DIR}/include")
list(APPEND OPUSFILE_INCLUDE_DIRS "${OPUS_DIR}/include")
list(APPEND OPUSFILE_INCLUDE_DIRS "${OPUSFILE_DIR}/include")

list(APPEND OPUSFILE_LIBRARIES "${OPUSFILE_TARGET}")

if(NOT TARGET "${OPUSFILE_TARGET}")
	source_group("Source Files" FILES ${OPUSFILE_SOURCES})
	source_group("Header Files" FILES ${OPUSFILE_HEADERS})

	add_library("${OPUSFILE_TARGET}" STATIC ${OPUSFILE_SOURCES} ${OPUSFILE_HEADERS})

	target_include_directories("${OPUSFILE_TARGET}" PRIVATE ${OPUSFILE_INCLUDE_DIRS})

	target_compile_definitions("${OPUSFILE_TARGET}" PRIVATE ${OPUSFILE_DEFINITIONS} ${OPUSFILE_DEFS})

	target_compile_options("${OPUSFILE_TARGET}" PRIVATE ${OPUSFILE_CFLAGS})

endif()
