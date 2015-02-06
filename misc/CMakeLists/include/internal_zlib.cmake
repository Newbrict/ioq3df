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

set(ZLIB_TARGET "internal_zlib")

include(CheckCCompilerFlag RESULT_VARIABLE MODULE_CHECKCCOMPILERFLAG_EXISTS)
include(CheckCSourceCompiles RESULT_VARIABLE MODULE_CHECKCSOURCECOMPILES_EXISTS)


set(ZLIB_SOURCES 
	"${ZLIB_DIR}/adler32.c"
	"${ZLIB_DIR}/crc32.c"
	"${ZLIB_DIR}/inffast.c"
	"${ZLIB_DIR}/inflate.c"
	"${ZLIB_DIR}/inftrees.c"
	"${ZLIB_DIR}/zutil.c"
)
set(ZLIB_HEADERS 
	"${ZLIB_DIR}/crc32.h"
	"${ZLIB_DIR}/inffast.h"
	"${ZLIB_DIR}/inffixed.h"
	"${ZLIB_DIR}/inflate.h"
	"${ZLIB_DIR}/inftrees.h"
	"${ZLIB_DIR}/zconf.h"
	"${ZLIB_DIR}/zlib.h"
	"${ZLIB_DIR}/zutil.h"
)

set(ZLIB_INCLUDE_DIRS)
set(ZLIB_LIBRARIES)
set(ZLIB_DEFINITIONS)

set(ZLIB_DEFS)
set(ZLIB_CFLAGS)

if(MSVC)
	#Inline Function Expansion, only __inline /Ob1
	list(APPEND ZLIB_CFLAGS "$<$<CONFIG:Release>:/Ob1>")
	#Omit Frame Pointers, Yes /Oy
	list(APPEND ZLIB_CFLAGS "$<$<CONFIG:Release>:/Oy>")

	#Enable String Pooling /GF
	list(APPEND ZLIB_CFLAGS "/GF")
	#Buffer Security Check, No /GS-
	list(APPEND ZLIB_CFLAGS "/GS-")
	#Enable Function-Level Linking /Gy
	list(APPEND ZLIB_CFLAGS "/Gy")

	#no crt warnings
	list(APPEND ZLIB_DEFS "-D_CRT_NONSTDC_NO_DEPRECATE")
	list(APPEND ZLIB_DEFS "-D_CRT_SECURE_NO_DEPRECATE")
	list(APPEND ZLIB_DEFS "-D_CRT_NONSTDC_NO_WARNINGS")

	#switch on the WINAPI (STDCALL) convention
	#list(APPEND ZLIB_DEFINITIONS "-DZLIB_WINAPI")
	#unused
	#list(APPEND ZLIB_DEFINITIONS "-DASMV")
	#machine dependent optimization
	#list(APPEND ZLIB_DEFINITIONS "-DASMINF")

	#Character Set, CharacterSet="0", Not Set, ASCII/SBCS (Single Byte Character Set)
	list(APPEND ZLIB_DEFS "-D_SBCS")

endif(MSVC)

#unused
#list(APPEND ZLIB_DEFINITIONS "-DZLIB_CONST")

if(CMAKE_COMPILER_IS_GNUCC)

	if(CMAKE_BUILD_TYPE MATCHES "Release")
		set(OFLAGS "-O4" "-O3" "-O2" "-O")
		foreach(OFLAG ${OFLAGS})
			CHECK_C_COMPILER_FLAG("${OFLAG}" COMPILER_HAS_O_FLAG)
			if(COMPILER_HAS_O_FLAG)
				list(APPEND ZLIB_CFLAGS "${OFLAG}")
				break()
			endif(COMPILER_HAS_O_FLAG)
		endforeach()
	endif()


	set(FLAGS "-Wall" "-Wextra" "-Wcast-qual" "-pedantic")

	foreach(FLAG ${FLAGS})
		CHECK_C_COMPILER_FLAG("${FLAG}" COMPILER_HAS_W_FLAG)
		if(COMPILER_HAS_W_FLAG)
			list(APPEND ZLIB_CFLAGS "${FLAG}")
		endif(COMPILER_HAS_W_FLAG)
	endforeach()

endif(CMAKE_COMPILER_IS_GNUCC)


list(APPEND ZLIB_INCLUDE_DIRS "${ZLIB_DIR}")
list(APPEND ZLIB_LIBRARIES "${ZLIB_TARGET}")
list(APPEND ZLIB_DEFINITIONS "-DNO_GZIP")

if(NOT TARGET "${ZLIB_TARGET}")
	source_group("Source Files" FILES ${ZLIB_SOURCES})
	source_group("Header Files" FILES ${ZLIB_HEADERS})

	add_library("${ZLIB_TARGET}" STATIC ${ZLIB_SOURCES} ${ZLIB_HEADERS})

	target_include_directories("${ZLIB_TARGET}" PRIVATE ${ZLIB_INCLUDE_DIRS})

	target_compile_definitions("${ZLIB_TARGET}" PRIVATE ${ZLIB_DEFINITIONS} ${ZLIB_DEFS})

	target_compile_options("${ZLIB_TARGET}" PRIVATE ${ZLIB_CFLAGS})

endif()
