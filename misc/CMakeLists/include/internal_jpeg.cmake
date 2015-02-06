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

set(JPEG_TARGET "internal_jpeg")


set(JPEG_SOURCES 
	"${JPEG_DIR}/jaricom.c"
	"${JPEG_DIR}/jcapimin.c"
	"${JPEG_DIR}/jcapistd.c"
	"${JPEG_DIR}/jcarith.c"
	"${JPEG_DIR}/jccoefct.c"
	"${JPEG_DIR}/jccolor.c"
	"${JPEG_DIR}/jcdctmgr.c"
	"${JPEG_DIR}/jchuff.c"
	"${JPEG_DIR}/jcinit.c"
	"${JPEG_DIR}/jcmainct.c"
	"${JPEG_DIR}/jcmarker.c"
	"${JPEG_DIR}/jcmaster.c"
	"${JPEG_DIR}/jcomapi.c"
	"${JPEG_DIR}/jcparam.c"
	"${JPEG_DIR}/jcprepct.c"
	"${JPEG_DIR}/jcsample.c"
	"${JPEG_DIR}/jctrans.c"
	"${JPEG_DIR}/jdapimin.c"
	"${JPEG_DIR}/jdapistd.c"
	"${JPEG_DIR}/jdarith.c"
	"${JPEG_DIR}/jdatadst.c"
	"${JPEG_DIR}/jdatasrc.c"
	"${JPEG_DIR}/jdcoefct.c"
	"${JPEG_DIR}/jdcolor.c"
	"${JPEG_DIR}/jddctmgr.c"
	"${JPEG_DIR}/jdhuff.c"
	"${JPEG_DIR}/jdinput.c"
	"${JPEG_DIR}/jdmainct.c"
	"${JPEG_DIR}/jdmarker.c"
	"${JPEG_DIR}/jdmaster.c"
	"${JPEG_DIR}/jdmerge.c"
	"${JPEG_DIR}/jdpostct.c"
	"${JPEG_DIR}/jdsample.c"
	"${JPEG_DIR}/jdtrans.c"
	"${JPEG_DIR}/jerror.c"
	"${JPEG_DIR}/jfdctflt.c"
	"${JPEG_DIR}/jfdctfst.c"
	"${JPEG_DIR}/jfdctint.c"
	"${JPEG_DIR}/jidctflt.c"
	"${JPEG_DIR}/jidctfst.c"
	"${JPEG_DIR}/jidctint.c"
	"${JPEG_DIR}/jmemmgr.c"
	"${JPEG_DIR}/jmemnobs.c"
	"${JPEG_DIR}/jquant1.c"
	"${JPEG_DIR}/jquant2.c"
	"${JPEG_DIR}/jutils.c"
)
set(JPEG_HEADERS 
	"${JPEG_DIR}/jconfig.h"
	"${JPEG_DIR}/jdct.h"
	"${JPEG_DIR}/jerror.h"
	"${JPEG_DIR}/jinclude.h"
	"${JPEG_DIR}/jmemsys.h"
	"${JPEG_DIR}/jmorecfg.h"
	"${JPEG_DIR}/jpegint.h"
	"${JPEG_DIR}/jpeglib.h"
	"${JPEG_DIR}/jversion.h"
)


set(JPEG_INCLUDE_DIRS)
set(JPEG_LIBRARIES)
set(JPEG_DEFINITIONS)

set(JPEG_DEFS)
set(JPEG_CFLAGS)


if(MSVC)
	#Optimization, Full /Ox
	list(APPEND JPEG_CFLAGS "/Ox")
	#Enable Intrinsic Functions, No /Oi-
	list(APPEND JPEG_CFLAGS "/Oi-")
	#Omit Frame Pointers, Yes /Oy
	list(APPEND JPEG_CFLAGS "/Oy")
	#Enable Fiber-Safe Optimizations /GT
	list(APPEND JPEG_CFLAGS "/GT")
	#Enable Function-Level Linking /Gy
	list(APPEND JPEG_CFLAGS "/Gy")
	#Disable specific warnings
	list(APPEND JPEG_CFLAGS "/wd4996")

	#no warnings about using old functions like strcmp
	list(APPEND JPEG_DEFS "-D_CRT_SECURE_NO_WARNINGS")

endif(MSVC)

list(APPEND JPEG_INCLUDE_DIRS "${JPEG_DIR}")
list(APPEND JPEG_LIBRARIES "${JPEG_TARGET}")


if(NOT TARGET "${JPEG_TARGET}")
	source_group("Source Files" FILES ${JPEG_SOURCES})
	source_group("Header Files" FILES ${JPEG_HEADERS})

	add_library("${JPEG_TARGET}" STATIC ${JPEG_SOURCES} ${JPEG_HEADERS})

	target_compile_definitions("${JPEG_TARGET}" PRIVATE ${JPEG_DEFINITIONS} ${JPEG_DEFS})

	target_compile_options("${JPEG_TARGET}" PRIVATE ${JPEG_CFLAGS})

endif()
