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

project("internal_client_masm")

#enable_language(ASM_MASM)

set(SOURCE_DIR "${CMAKE_CURRENT_LIST_DIR}/../../../..")
set(CMAKELIST_DIR "${SOURCE_DIR}/misc/CMakeLists")

set(MASM_TARGET "internal_client_masm")

include("${CMAKELIST_DIR}/include/internal_masm.cmake")

set(TRY_MASM_TARGET "try_client_masm")

if(MSVC)
	#Image Has Safe Exception Handlers, is no longer default no in msvc 2013, /SAFESEH:NO
	list(APPEND TRY_MASM_LDFLAGS "/SAFESEH:NO")
endif(MSVC)

add_executable("${TRY_MASM_TARGET}" "${CMAKELIST_DIR}/include/try_asm.c")
target_link_libraries("${TRY_MASM_TARGET}" "${MASM_TARGET}")

string(REPLACE ";" " " TRY_MASM_LDFLAGS_STRING "${TRY_MASM_LDFLAGS}")
set_target_properties("${TRY_MASM_TARGET}" PROPERTIES LINK_FLAGS "${TRY_MASM_LDFLAGS_STRING}")
