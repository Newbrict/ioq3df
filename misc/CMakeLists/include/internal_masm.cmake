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

if(NOT DEFINED MASM_TARGET)
	set(MASM_TARGET "internal_masm" CACHE INTERNAL "Target name")
endif()

set(SOURCE_DIR "${CMAKE_CURRENT_LIST_DIR}/../../..")
set(CMAKELIST_DIR "${SOURCE_DIR}/misc/CMakeLists")

include("${CMAKELIST_DIR}/include/directory_constants.cmake")
include("${CMAKELIST_DIR}/include/default_options.cmake")
include("${CMAKELIST_DIR}/include/platform.cmake")
include("${CMAKELIST_DIR}/include/cmake_compatibility.cmake")


#microsoft macro assembler files
set(MASM_SOURCES 
	"${ASM_DIR}/ftola.asm"
	"${ASM_DIR}/snapvector.asm"
#	"${ASM_DIR}/vm_x86_64.asm"
)

set(MASM_LIBRARIES)
set(MASM_DEFINITIONS)

set(MASM_CFLAGS)


if(CMAKE_COMPILER_IS_GNUCC)

endif(CMAKE_COMPILER_IS_GNUCC)


if(NOT TARGET "${MASM_TARGET}")
	enable_language(ASM_MASM)

	add_library("${MASM_TARGET}" STATIC ${MASM_SOURCES})

	target_compile_definitions("${MASM_TARGET}" PRIVATE ${MASM_DEFINITIONS})

	target_compile_options("${MASM_TARGET}" PRIVATE ${MASM_CFLAGS})

	set_target_properties("${MASM_TARGET}" PROPERTIES LINKER_LANGUAGE C)

endif()

list(APPEND MASM_LIBRARIES "${MASM_TARGET}")
