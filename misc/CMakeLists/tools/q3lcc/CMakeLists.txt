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

project("q3lcc")

set(Q3LCC_TARGET "q3lcc")

set(SOURCE_DIR "${CMAKE_CURRENT_LIST_DIR}/../../../..")
set(CMAKELIST_DIR "${SOURCE_DIR}/misc/CMakeLists")

set(MOUNT_DIR "${SOURCE_DIR}/code" CACHE PATH "path to the code directory")

set(Q3LCCETC_DIR "${MOUNT_DIR}/tools/lcc/etc")
set(TEMP_DIR "$ENV{TMP}")
if(TEMP_DIR STREQUAL "")
	set(TEMP_DIR "/tmp")
endif()
set(TEMP_DIR "${TEMP_DIR}" CACHE STRING "Temporary directory")


include("${CMAKELIST_DIR}/include/default_options.cmake")

include("${CMAKELIST_DIR}/include/cmake_compatibility.cmake")


option(GENERATE_DEPENDENCIES "Preprocessing: Generate dependencies for make outputting" ${DEFAULT_GENERATE_DEPENDENCIES})


set(Q3LCC_SOURCES 
	"${Q3LCCETC_DIR}/lcc.c"
	"${Q3LCCETC_DIR}/bytecode.c"
)
set(Q3LCC_HEADERS 

)


if(MSVC)

	#Character Set, CharacterSet="0", Not Set, ASCII/SBCS (Single Byte Character Set)
	list(APPEND Q3LCC_DEFINITIONS "-D_SBCS")

	#no warnings about using old functions like strcmp
	list(APPEND Q3LCC_DEFINITIONS "-D_CRT_SECURE_NO_WARNINGS")
	list(APPEND Q3LCC_DEFINITIONS "-D_CRT_NONSTDC_NO_DEPRECATE")

endif(MSVC)


if(CMAKE_COMPILER_IS_GNUCC)

	#Produce debugging information
	list(APPEND Q3LCC_CFLAGS_OPTIMIZE "-g")
	#enable all compiler warning messages
	list(APPEND Q3LCC_CFLAGS_OPTIMIZE "-Wall")
	#Causes the compiler to avoid assumptions regarding non-aliasing of objects of different types
	list(APPEND Q3LCC_CFLAGS_OPTIMIZE "-fno-strict-aliasing")

	list(APPEND Q3LCC_CFLAGS ${Q3LCC_CFLAGS_OPTIMIZE})

	if(GENERATE_DEPENDENCIES)
		list(APPEND Q3LCC_CFLAGS "-MMD")
	endif(GENERATE_DEPENDENCIES)

endif(CMAKE_COMPILER_IS_GNUCC)

string(REPLACE "\\" "\\\\" TEMP_DIR_C_STRING "${TEMP_DIR}")
list(APPEND Q3LCC_DEFINITIONS "-DTEMPDIR=\"${TEMP_DIR_C_STRING}\"")



source_group("Source Files" FILES ${Q3LCC_SOURCES})
source_group("Header Files" FILES ${Q3LCC_HEADERS})

add_executable("${Q3LCC_TARGET}" ${Q3LCC_SOURCES} ${Q3LCC_HEADERS})

target_include_directories("${Q3LCC_TARGET}" PRIVATE ${Q3LCC_INCLUDE_DIRS})

target_compile_definitions("${Q3LCC_TARGET}" PRIVATE ${Q3LCC_DEFINITIONS})

target_compile_options("${Q3LCC_TARGET}" PRIVATE ${Q3LCC_CFLAGS})

target_link_libraries("${Q3LCC_TARGET}" ${Q3LCC_LIBRARIES})

string(REPLACE ";" " " Q3LCC_LDFLAGS_STRING "${Q3LCC_LDFLAGS}")
set_target_properties("${Q3LCC_TARGET}" PROPERTIES LINK_FLAGS "${Q3LCC_LDFLAGS_STRING}")

