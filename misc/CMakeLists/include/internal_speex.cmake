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

set(SPEEX_TARGET "internal_speex")

include(CheckCCompilerFlag RESULT_VARIABLE MODULE_CHECKCCOMPILERFLAG_EXISTS)
include(CheckCSourceCompiles RESULT_VARIABLE MODULE_CHECKCSOURCECOMPILES_EXISTS)
include(CheckIncludeFile RESULT_VARIABLE MODULE_CHECKINCLUDEFILE_EXISTS)



set(SPEEX_SOURCES 
	"${SPEEX_DIR}/bits.c"
	"${SPEEX_DIR}/buffer.c"
	"${SPEEX_DIR}/cb_search.c"
	"${SPEEX_DIR}/exc_10_16_table.c"
	"${SPEEX_DIR}/exc_10_32_table.c"
	"${SPEEX_DIR}/exc_20_32_table.c"
	"${SPEEX_DIR}/exc_5_256_table.c"
	"${SPEEX_DIR}/exc_5_64_table.c"
	"${SPEEX_DIR}/exc_8_128_table.c"
	"${SPEEX_DIR}/fftwrap.c"
	"${SPEEX_DIR}/filterbank.c"
	"${SPEEX_DIR}/filters.c"
	"${SPEEX_DIR}/gain_table.c"
	"${SPEEX_DIR}/gain_table_lbr.c"
	"${SPEEX_DIR}/hexc_10_32_table.c"
	"${SPEEX_DIR}/hexc_table.c"
	"${SPEEX_DIR}/high_lsp_tables.c"
	"${SPEEX_DIR}/jitter.c"
	"${SPEEX_DIR}/kiss_fft.c"
	"${SPEEX_DIR}/kiss_fftr.c"
	"${SPEEX_DIR}/lpc.c"
	"${SPEEX_DIR}/lsp.c"
	"${SPEEX_DIR}/lsp_tables_nb.c"
	"${SPEEX_DIR}/ltp.c"
	"${SPEEX_DIR}/mdf.c"
	"${SPEEX_DIR}/modes.c"
	"${SPEEX_DIR}/modes_wb.c"
	"${SPEEX_DIR}/nb_celp.c"
	"${SPEEX_DIR}/preprocess.c"
	"${SPEEX_DIR}/quant_lsp.c"
	"${SPEEX_DIR}/resample.c"
	"${SPEEX_DIR}/sb_celp.c"
	"${SPEEX_DIR}/smallft.c"
	"${SPEEX_DIR}/speex.c"
	"${SPEEX_DIR}/speex_callbacks.c"
	"${SPEEX_DIR}/speex_header.c"
	"${SPEEX_DIR}/stereo.c"
#unused
#	"${SPEEX_DIR}/testdenoise.c"
#	"${SPEEX_DIR}/testecho.c"
#	"${SPEEX_DIR}/testenc.c"
#	"${SPEEX_DIR}/testenc_uwb.c"
#	"${SPEEX_DIR}/testenc_wb.c"
	"${SPEEX_DIR}/vbr.c"
	"${SPEEX_DIR}/vq.c"
	"${SPEEX_DIR}/window.c"
)
set(SPEEX_HEADERS
	"${SPEEX_DIR}/_kiss_fft_guts.h"
	"${SPEEX_DIR}/arch.h"
	"${SPEEX_DIR}/cb_search.h"
	"${SPEEX_DIR}/cb_search_arm4.h"
	"${SPEEX_DIR}/cb_search_bfin.h"
	"${SPEEX_DIR}/cb_search_sse.h"
	"${SPEEX_DIR}/config.h"
	"${SPEEX_DIR}/fftwrap.h"
	"${SPEEX_DIR}/filterbank.h"
	"${SPEEX_DIR}/filters.h"
	"${SPEEX_DIR}/filters_arm4.h"
	"${SPEEX_DIR}/filters_bfin.h"
	"${SPEEX_DIR}/filters_sse.h"
	"${SPEEX_DIR}/fixed_arm4.h"
	"${SPEEX_DIR}/fixed_arm5e.h"
	"${SPEEX_DIR}/fixed_bfin.h"
	"${SPEEX_DIR}/fixed_debug.h"
	"${SPEEX_DIR}/fixed_generic.h"
	"${SPEEX_DIR}/kiss_fft.h"
	"${SPEEX_DIR}/kiss_fftr.h"
	"${SPEEX_DIR}/lpc.h"
	"${SPEEX_DIR}/lpc_bfin.h"
	"${SPEEX_DIR}/lsp.h"
	"${SPEEX_DIR}/lsp_bfin.h"
	"${SPEEX_DIR}/ltp.h"
	"${SPEEX_DIR}/ltp_arm4.h"
	"${SPEEX_DIR}/ltp_bfin.h"
	"${SPEEX_DIR}/ltp_sse.h"
	"${SPEEX_DIR}/math_approx.h"
	"${SPEEX_DIR}/misc_bfin.h"
	"${SPEEX_DIR}/modes.h"
	"${SPEEX_DIR}/nb_celp.h"
	"${SPEEX_DIR}/os_support.h"
	"${SPEEX_DIR}/pseudofloat.h"
	"${SPEEX_DIR}/quant_lsp.h"
	"${SPEEX_DIR}/quant_lsp_bfin.h"
	"${SPEEX_DIR}/sb_celp.h"
	"${SPEEX_DIR}/smallft.h"
	"${SPEEX_DIR}/stack_alloc.h"
	"${SPEEX_DIR}/vbr.h"
	"${SPEEX_DIR}/vorbis_psy.h"
	"${SPEEX_DIR}/vq.h"
	"${SPEEX_DIR}/vq_arm4.h"
	"${SPEEX_DIR}/vq_bfin.h"
	"${SPEEX_DIR}/vq_sse.h"

	"${SPEEX_DIR}/include/speex/speex.h"
	"${SPEEX_DIR}/include/speex/speex_bits.h"
	"${SPEEX_DIR}/include/speex/speex_buffer.h"
	"${SPEEX_DIR}/include/speex/speex_callbacks.h"
	"${SPEEX_DIR}/include/speex/speex_config_types.h"
	"${SPEEX_DIR}/include/speex/speex_echo.h"
	"${SPEEX_DIR}/include/speex/speex_header.h"
	"${SPEEX_DIR}/include/speex/speex_jitter.h"
	"${SPEEX_DIR}/include/speex/speex_preprocess.h"
	"${SPEEX_DIR}/include/speex/speex_types.h"
)


set(SPEEX_INCLUDE_DIRS)
set(SPEEX_LIBRARIES)
set(SPEEX_DEFINITIONS)

set(SPEEX_DEFS)
set(SPEEX_CFLAGS)


CHECK_INCLUDE_FILE("malloc.h" HAVE_MALLOC_H)
if(HAVE_MALLOC_H)
	list(APPEND SPEEX_DEFS "-DHAVE_MALLOC_H")
endif(HAVE_MALLOC_H)
CHECK_INCLUDE_FILE("alloca.h" HAVE_ALLOCA_H)
if(HAVE_ALLOCA_H)
	list(APPEND SPEEX_DEFS "-DHAVE_ALLOCA_H")
endif(HAVE_ALLOCA_H)


CHECK_C_SOURCE_COMPILES("#include <alloca.h>\n int main () {int foo=10;int *array = alloca(foo);return 0;}" HAVE_ALLOCA_IN_ALLOCA_H)
CHECK_C_SOURCE_COMPILES("#include <stdlib.h>\n int main () {int foo=10;int *array = alloca(foo);return 0;}" HAVE_ALLOCA_IN_STDLIB_H)
CHECK_C_SOURCE_COMPILES("#include <malloc.h>\n int main () {int foo=10;int *array = alloca(foo);return 0;}" HAVE_ALLOCA_IN_MALLOC_H)
if(HAVE_ALLOCA_IN_ALLOCA_H OR HAVE_ALLOCA_IN_STDLIB_H OR HAVE_ALLOCA_IN_MALLOC_H)
	list(APPEND SPEEX_DEFS "-DUSE_ALLOCA")
endif()


if(MSVC)
	#Optimization, Full /Ox
	list(APPEND SPEEX_CFLAGS "$<$<CONFIG:Release>:/Ox>")
	#Inline Function Expansion, only Suitable /Ob2
	list(APPEND SPEEX_CFLAGS "$<$<CONFIG:Release>:/Ob2>")
	#Enable Intrinsic Functions /Oi
	list(APPEND SPEEX_CFLAGS "$<$<CONFIG:Release>:/Oi>")
	#Favor Size of Speed, Favor Fast Code /Ot
	list(APPEND SPEEX_CFLAGS "$<$<CONFIG:Release>:/Ot>")

	#Enable String Pooling /GF
	list(APPEND SPEEX_CFLAGS "/GF")
	#Buffer Security Check, No /GS-
	list(APPEND SPEEX_CFLAGS "/GS-")
	#Disable specific warnings
	list(APPEND SPEEX_CFLAGS "/wd4244")
	list(APPEND SPEEX_CFLAGS "/wd4305")
	list(APPEND SPEEX_CFLAGS "/wd4311")
	list(APPEND SPEEX_CFLAGS "/wd4100")
	list(APPEND SPEEX_CFLAGS "/wd4127")
	#Compile as, C Code /TC
	list(APPEND SPEEX_CFLAGS "/TC")
	#Enable C++ Exceptions, No /EHa-
	list(APPEND SPEEX_CFLAGS "/EHa-")

	#Character Set, CharacterSet="0", Not Set, ASCII/SBCS (Single Byte Character Set)
#	list(APPEND SPEEX_DEFS "-D_SBCS")

endif(MSVC)

if(CMAKE_COMPILER_IS_GNUCC)

	if(CMAKE_BUILD_TYPE MATCHES "Release")
		set(OFLAGS "-O4" "-O3" "-O2" "-O")
		foreach(OFLAG ${OFLAGS})
			CHECK_C_COMPILER_FLAG("${OFLAG}" COMPILER_HAS_O_FLAG)
			if(COMPILER_HAS_O_FLAG)
				list(APPEND SPEEX_CFLAGS "${OFLAG}")
				break()
			endif(COMPILER_HAS_O_FLAG)
		endforeach()
	endif()

	if(CMAKE_BUILD_TYPE MATCHES "Debug")
		set(FLAGS "-g" "-O0")
		foreach(FLAG ${FLAGS})
			CHECK_C_COMPILER_FLAG("${FLAG}" COMPILER_HAS_DEBUG_FLAG)
			if(COMPILER_HAS_DEBUG_FLAG)
				list(APPEND SPEEX_CFLAGS "${FLAG}")
			endif(COMPILER_HAS_DEBUG_FLAG)
		endforeach()
	endif()

endif(CMAKE_COMPILER_IS_GNUCC)


CHECK_C_SOURCE_COMPILES("inline int foo(int x) {return x;}; int main() {return foo(0);}" HAVE_INLINE_FUNC)
CHECK_C_SOURCE_COMPILES("__inline int foo(int x) {return x;}; int main() {return foo(0);}" HAVE_MSINLINE_FUNC)
if(HAVE_MSINLINE_FUNC AND NOT HAVE_INLINE_FUNC)
	list(APPEND SPEEX_DEFINITIONS "-Dinline=__inline")
endif()


list(APPEND SPEEX_INCLUDE_DIRS "${SPEEX_DIR}/include")

list(APPEND SPEEX_LIBRARIES "${SPEEX_TARGET}")

list(APPEND SPEEX_DEFINITIONS "-DFLOATING_POINT")
#list(APPEND SPEEX_DEFINITIONS "-D_USE_SSE")

if(NOT TARGET "${SPEEX_TARGET}")
	source_group("Source Files" FILES ${SPEEX_SOURCES})
	source_group("Header Files" FILES ${SPEEX_HEADERS})

	add_library("${SPEEX_TARGET}" STATIC ${SPEEX_SOURCES} ${SPEEX_HEADERS})

	target_include_directories("${SPEEX_TARGET}" PRIVATE ${SPEEX_INCLUDE_DIRS})

	target_compile_definitions("${SPEEX_TARGET}" PRIVATE ${SPEEX_DEFINITIONS} ${SPEEX_DEFS})

	target_compile_options("${SPEEX_TARGET}" PRIVATE ${SPEEX_CFLAGS})

endif()
