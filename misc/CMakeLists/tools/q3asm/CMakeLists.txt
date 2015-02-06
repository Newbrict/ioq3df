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

project("q3asm")

set(Q3ASM_TARGET "q3asm")

set(SOURCE_DIR "${CMAKE_CURRENT_LIST_DIR}/../../../..")
set(CMAKELIST_DIR "${SOURCE_DIR}/misc/CMakeLists")

set(MOUNT_DIR "${SOURCE_DIR}/code" CACHE PATH "path to the code directory")

set(Q3ASM_DIR "${MOUNT_DIR}/tools/asm")


include("${CMAKELIST_DIR}/include/default_options.cmake")

include("${CMAKELIST_DIR}/include/cmake_compatibility.cmake")


option(GENERATE_DEPENDENCIES "Preprocessing: Generate dependencies for make outputting" ${DEFAULT_GENERATE_DEPENDENCIES})


set(Q3ASM_SOURCES 
	"${Q3ASM_DIR}/cmdlib.c"
	"${Q3ASM_DIR}/q3asm.c"
)
set(Q3ASM_HEADERS 
	"${Q3ASM_DIR}/cmdlib.h"
	"${Q3ASM_DIR}/mathlib.h"
	"${Q3ASM_DIR}/opstrings.h"
)


if(MSVC)

	#Character Set, CharacterSet="0", Not Set, ASCII/SBCS (Single Byte Character Set)
	list(APPEND Q3ASM_DEFINITIONS "-D_SBCS")

	#no warnings about using old functions like strcmp
	list(APPEND Q3ASM_DEFINITIONS "-D_CRT_SECURE_NO_WARNINGS")

endif(MSVC)


if(CMAKE_COMPILER_IS_GNUCC)

	list(APPEND Q3ASM_CFLAGS_OPTIMIZE "-g")
	list(APPEND Q3ASM_CFLAGS_OPTIMIZE "-Wall")
	list(APPEND Q3ASM_CFLAGS_OPTIMIZE "-fno-strict-aliasing")

	list(APPEND Q3ASM_CFLAGS ${Q3ASM_CFLAGS_OPTIMIZE})

	if(GENERATE_DEPENDENCIES)
		list(APPEND Q3ASM_CFLAGS "-MMD")
	endif(GENERATE_DEPENDENCIES)

endif(CMAKE_COMPILER_IS_GNUCC)



source_group("Source Files" FILES ${Q3ASM_SOURCES})
source_group("Header Files" FILES ${Q3ASM_HEADERS})

add_executable("${Q3ASM_TARGET}" ${Q3ASM_SOURCES} ${Q3ASM_HEADERS})

target_include_directories("${Q3ASM_TARGET}" PRIVATE ${Q3ASM_INCLUDE_DIRS})

target_compile_definitions("${Q3ASM_TARGET}" PRIVATE ${Q3ASM_DEFINITIONS})

target_compile_options("${Q3ASM_TARGET}" PRIVATE ${Q3ASM_CFLAGS})

target_link_libraries("${Q3ASM_TARGET}" ${Q3ASM_LIBRARIES})

string(REPLACE ";" " " Q3ASM_LDFLAGS_STRING "${Q3ASM_LDFLAGS}")
set_target_properties("${Q3ASM_TARGET}" PROPERTIES 	LINK_FLAGS "${Q3ASM_LDFLAGS_STRING}")
