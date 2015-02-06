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

project("internal inline asm")

if(NOT DEFINED INLINE_ASM_TARGET)
	set(INLINE_ASM_TARGET "internal_inline_asm" CACHE INTERNAL "Target name")
endif()

set(SOURCE_DIR "${CMAKE_CURRENT_LIST_DIR}/../../..")
set(CMAKELIST_DIR "${SOURCE_DIR}/misc/CMakeLists")

include("${CMAKELIST_DIR}/include/directory_constants.cmake")
include("${CMAKELIST_DIR}/include/default_options.cmake")
include("${CMAKELIST_DIR}/include/platform.cmake")
include(CheckCCompilerFlag RESULT_VARIABLE MODULE_CHECKCCOMPILERFLAG_EXISTS)
include("${CMAKELIST_DIR}/include/cmake_compatibility.cmake")



set(INLINE_ASM_SOURCES 
	"${ASM_DIR}/ftola.c"
	"${ASM_DIR}/snapvector.c"
)

set(INLINE_ASM_LIBRARIES)
set(INLINE_ASM_DEFINITIONS)

set(INLINE_ASM_CFLAGS)


if(CMAKE_COMPILER_IS_GNUCC)
#	set(FLAGS "-msse4.1" "-msse4" "-msse3" "-msse2" "-msse" "-march=k8" "-march=pentium-m" "-march=pentium3")
	set(FLAGS "-march=k8")
	foreach(FLAG ${FLAGS})
		CHECK_C_COMPILER_FLAG("${OFLAG}" COMPILER_HAS_SSE)
		if(COMPILER_HAS_SSE)
			list(APPEND INLINE_ASM_CFLAGS "${FLAG}")
			break()
		endif(COMPILER_HAS_SSE)
	endforeach()

endif(CMAKE_COMPILER_IS_GNUCC)


if(NOT TARGET "${INLINE_ASM_TARGET}")
	add_library("${INLINE_ASM_TARGET}" STATIC ${INLINE_ASM_SOURCES})

	target_compile_definitions("${INLINE_ASM_TARGET}" PRIVATE ${INLINE_ASM_DEFINITIONS})

	target_compile_options("${INLINE_ASM_TARGET}" PRIVATE ${INLINE_ASM_CFLAGS})

endif()

list(APPEND INLINE_ASM_LIBRARIES "${INLINE_ASM_TARGET}")
