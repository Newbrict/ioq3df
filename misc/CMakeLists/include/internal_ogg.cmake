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

set(OGG_TARGET "internal_ogg")


set(OGG_SOURCES 
	"${OGG_DIR}/src/bitwise.c"
	"${OGG_DIR}/src/framing.c"
)
set(OGG_HEADERS 
	"${OGG_DIR}/include/ogg/config_types.h"
	"${OGG_DIR}/include/ogg/ogg.h"
	"${OGG_DIR}/include/ogg/os_types.h"
)

set(OGG_INCLUDE_DIRS)
set(OGG_LIBRARIES)
set(OGG_DEFINITIONS)

set(OGG_DEFS)
set(OGG_CFLAGS)
set(OGG_RELEASE_CFLAGS)
set(OGG_DEBUG_CFLAGS)
set(OGG_RELEASE_DEFINITIONS)
set(OGG_DEBUG_DEFINITIONS)


if(MSVC)
	#Optimization, Maximum Speed /O2
	list(APPEND OGG_CFLAGS "$<$<CONFIG:Release>:/O2>")
	#Inline Function Expansion, only Suitable /Ob2
	list(APPEND OGG_CFLAGS "$<$<CONFIG:Release>:/Ob2>")
	#Enable Intrinsic Functions /Oi
	list(APPEND OGG_CFLAGS "$<$<CONFIG:Release>:/Oi>")
	#Favor Size of Speed, Favor Fast Code /Ot
	list(APPEND OGG_CFLAGS "$<$<CONFIG:Release>:/Ot>")

	#Enable String Pooling /GF
	list(APPEND OGG_CFLAGS "/GF")
	#Buffer Security Check, No /GS-
	list(APPEND OGG_CFLAGS "/GS-")

	#Calling Convention, __cdecl /Gd
	list(APPEND OGG_CFLAGS "/Gd")	
	#Compile as, C Code /TC
	list(APPEND OGG_CFLAGS "/TC")
	#Disable specific warnings
	list(APPEND OGG_CFLAGS "/wd4244")

endif(MSVC)

if(CMAKE_COMPILER_IS_GNUCC)

	if(PLATFORM MATCHES "linux")
		list(APPEND OGG_RELEASE_CFLAGS "-Wall" "-fsigned-char" "-O20" "-ffast-math")
		list(APPEND OGG_DEBUG_CFLAGS "-Wall" "-fsigned-char" "-g")
	elseif(PLATFORM MATCHES "darwin")
		list(APPEND OGG_RELEASE_CFLAGS "-Wall" "-fno-common" "-fsigned-char" "-ffast-math" "-O4")
		list(APPEND OGG_DEBUG_CFLAGS "-Wall" "-fno-common" "-fsigned-char" "-g")
	elseif(ARCH STREQUAL "sparc")
		list(APPEND OGG_RELEASE_CFLAGS "-fsigned-char" "-O20")
		list(APPEND OGG_DEBUG_CFLAGS "-fsigned-char" "-g" "-Wall")
	else()
		list(APPEND OGG_RELEASE_CFLAGS "-fsigned-char" "-O20")
		list(APPEND OGG_DEBUG_CFLAGS "-fsigned-char" "-g" "-Wall")
	endif()

endif(CMAKE_COMPILER_IS_GNUCC)



if(CMAKE_BUILD_TYPE MATCHES "Release")
	list(APPEND OGG_CFLAGS ${OGG_RELEASE_CFLAGS})
	list(APPEND OGG_DEFS ${OGG_RELEASE_DEFINITIONS})
elseif(CMAKE_BUILD_TYPE MATCHES "Debug")
	list(APPEND OGG_CFLAGS ${OGG_DEBUG_CFLAGS})
	list(APPEND OGG_DEFS ${OGG_DEBUG_DEFINITIONS})
endif()


list(APPEND OGG_INCLUDE_DIRS "${OGG_DIR}/include")

list(APPEND OGG_LIBRARIES "${OGG_TARGET}")

if(NOT TARGET "${OGG_TARGET}")
	source_group("Source Files" FILES ${OGG_SOURCES})
	source_group("Header Files" FILES ${OGG_HEADERS})

	add_library("${OGG_TARGET}" STATIC ${OGG_SOURCES} ${OGG_HEADERS})

	target_include_directories("${OGG_TARGET}" PRIVATE ${OGG_INCLUDE_DIRS})

	target_compile_definitions("${OGG_TARGET}" PRIVATE ${OGG_DEFINITIONS} ${OGG_DEFS})

	target_compile_options("${OGG_TARGET}" PRIVATE ${OGG_CFLAGS})

endif()

unset(OGG_DEFINITIONS)
