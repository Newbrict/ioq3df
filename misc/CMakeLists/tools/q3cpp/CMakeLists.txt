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

project("q3cpp")

set(Q3CPP_TARGET "q3cpp")

set(SOURCE_DIR "${CMAKE_CURRENT_LIST_DIR}/../../../..")
set(CMAKELIST_DIR "${SOURCE_DIR}/misc/CMakeLists")

set(MOUNT_DIR "${SOURCE_DIR}/code" CACHE PATH "path to the code directory")

set(Q3CPP_DIR "${MOUNT_DIR}/tools/lcc/cpp")


include("${CMAKELIST_DIR}/include/default_options.cmake")

include("${CMAKELIST_DIR}/include/cmake_compatibility.cmake")


option(GENERATE_DEPENDENCIES "Preprocessing: Generate dependencies for make outputting" ${DEFAULT_GENERATE_DEPENDENCIES})


set(Q3CPP_SOURCES 
	"${Q3CPP_DIR}/cpp.c"
	"${Q3CPP_DIR}/lex.c"
	"${Q3CPP_DIR}/nlist.c"
	"${Q3CPP_DIR}/tokens.c"
	"${Q3CPP_DIR}/macro.c"
	"${Q3CPP_DIR}/eval.c"
	"${Q3CPP_DIR}/include.c"
	"${Q3CPP_DIR}/hideset.c"
	"${Q3CPP_DIR}/getopt.c"
	"${Q3CPP_DIR}/unix.c"
)
set(Q3CPP_HEADERS 
	"${Q3CPP_DIR}/cpp.h"
)

set(Q3CPP_INCLUDE_DIRS)
set(Q3CPP_LIBRARIES)
set(Q3CPP_DEFINITIONS)

set(Q3CPP_CFLAGS)
set(Q3CPP_LDFLAGS)

if(MSVC)

	#Character Set, CharacterSet="0", Not Set, ASCII/SBCS (Single Byte Character Set)
	list(APPEND Q3CPP_DEFINITIONS "-D_SBCS")

	#no warnings about using old functions like strcmp
	list(APPEND Q3CPP_DEFINITIONS "-D_CRT_SECURE_NO_WARNINGS")
	list(APPEND Q3CPP_DEFINITIONS "-D_CRT_NONSTDC_NO_DEPRECATE")


endif(MSVC)


if(APPLE)
#	required to use the mac memmove function
	list(APPEND Q3CPP_DEFINITIONS "-DMACOS_X")
endif(APPLE)

if(CMAKE_COMPILER_IS_GNUCC)

	set(Q3CPP_CFLAGS_OPTIMIZE)
	list(APPEND Q3CPP_CFLAGS_OPTIMIZE "-g")
	list(APPEND Q3CPP_CFLAGS_OPTIMIZE "-Wall")
	list(APPEND Q3CPP_CFLAGS_OPTIMIZE "-fno-strict-aliasing")

	list(APPEND Q3CPP_CFLAGS ${Q3CPP_CFLAGS_OPTIMIZE})

	if(GENERATE_DEPENDENCIES)
		list(APPEND Q3CPP_CFLAGS "-MMD")
	endif(GENERATE_DEPENDENCIES)

endif(CMAKE_COMPILER_IS_GNUCC)



source_group("Source Files" FILES ${Q3CPP_SOURCES})
source_group("Header Files" FILES ${Q3CPP_HEADERS})

add_executable("${Q3CPP_TARGET}" ${Q3CPP_SOURCES} ${Q3CPP_HEADERS})

target_include_directories("${Q3CPP_TARGET}" PRIVATE ${Q3CPP_INCLUDE_DIRS})

target_compile_definitions("${Q3CPP_TARGET}" PRIVATE ${Q3CPP_DEFINITIONS})

target_compile_options("${Q3CPP_TARGET}" PRIVATE ${Q3CPP_CFLAGS})

target_link_libraries("${Q3CPP_TARGET}" ${Q3CPP_LIBRARIES})

string(REPLACE ";" " " Q3CPP_LDFLAGS_STRING "${Q3CPP_LDFLAGS}")
set_target_properties("${Q3CPP_TARGET}" PROPERTIES LINK_FLAGS "${Q3CPP_LDFLAGS_STRING}")


