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

set(CLIENT_ASM_TARGET "internal_client_asm" CACHE INTERNAL "Target name")

set(SOURCE_DIR "${CMAKE_CURRENT_LIST_DIR}/../../..")
set(CMAKELIST_DIR "${SOURCE_DIR}/misc/CMakeLists")

include("${CMAKELIST_DIR}/include/directory_constants.cmake")
include("${CMAKELIST_DIR}/include/default_options.cmake")
include("${CMAKELIST_DIR}/include/platform.cmake")
include("${CMAKELIST_DIR}/include/cmake_compatibility.cmake")


set(CLIENT_ASM_SOURCES 
	"${ASM_DIR}/matha.s"
	"${ASM_DIR}/snd_mixa.s"
)

set(CLIENT_ASM_LIBRARIES)
set(CLIENT_ASM_DEFINITIONS)

set(CLIENT_ASM_CFLAGS)


if(CMAKE_COMPILER_IS_GNUCC)
	list(APPEND CLIENT_ASM_CFLAGS "-x" "assembler-with-cpp")
endif(CMAKE_COMPILER_IS_GNUCC)


if(NOT TARGET "${CLIENT_ASM_TARGET}")
	enable_language(ASM)

	add_library("${CLIENT_ASM_TARGET}" STATIC ${CLIENT_ASM_SOURCES})

	target_compile_definitions("${CLIENT_ASM_TARGET}" PRIVATE ${CLIENT_ASM_DEFINITIONS})

	target_compile_options("${CLIENT_ASM_TARGET}" PRIVATE ${CLIENT_ASM_CFLAGS})

	set_target_properties("${CLIENT_ASM_TARGET}" PROPERTIES LINKER_LANGUAGE C)

endif()

list(APPEND CLIENT_ASM_LIBRARIES "${CLIENT_ASM_TARGET}")
