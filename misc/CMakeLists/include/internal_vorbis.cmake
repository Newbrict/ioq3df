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

set(VORBIS_TARGET "internal_vorbis")


set(VORBIS_SOURCES 
	"${VORBIS_DIR}/lib/analysis.c"
	"${VORBIS_DIR}/lib/bitrate.c"
	"${VORBIS_DIR}/lib/block.c"
	"${VORBIS_DIR}/lib/codebook.c"
	"${VORBIS_DIR}/lib/envelope.c"
	"${VORBIS_DIR}/lib/floor0.c"
	"${VORBIS_DIR}/lib/floor1.c"
	"${VORBIS_DIR}/lib/info.c"
	"${VORBIS_DIR}/lib/lookup.c"
	"${VORBIS_DIR}/lib/lpc.c"
	"${VORBIS_DIR}/lib/lsp.c"
	"${VORBIS_DIR}/lib/mapping0.c"
	"${VORBIS_DIR}/lib/mdct.c"
	"${VORBIS_DIR}/lib/psy.c"
	"${VORBIS_DIR}/lib/registry.c"
	"${VORBIS_DIR}/lib/res0.c"
	"${VORBIS_DIR}/lib/smallft.c"
	"${VORBIS_DIR}/lib/sharedbook.c"
	"${VORBIS_DIR}/lib/synthesis.c"
	"${VORBIS_DIR}/lib/vorbisfile.c"
	"${VORBIS_DIR}/lib/window.c"
)
set(VORBIS_HEADERS 
	"${VORBIS_DIR}/include/vorbis/codec.h"
	"${VORBIS_DIR}/include/vorbis/vorbisenc.h"
	"${VORBIS_DIR}/include/vorbis/vorbisfile.h"

	"${VORBIS_DIR}/lib/backends.h"
	"${VORBIS_DIR}/lib/bitrate.h"
	"${VORBIS_DIR}/lib/codebook.h"
	"${VORBIS_DIR}/lib/codec_internal.h"
	"${VORBIS_DIR}/lib/envelope.h"
	"${VORBIS_DIR}/lib/highlevel.h"
	"${VORBIS_DIR}/lib/lookup.h"
	"${VORBIS_DIR}/lib/lookup_data.h"
	"${VORBIS_DIR}/lib/lpc.h"
	"${VORBIS_DIR}/lib/lsp.h"
	"${VORBIS_DIR}/lib/masking.h"
	"${VORBIS_DIR}/lib/mdct.h"
	"${VORBIS_DIR}/lib/misc.h"
	"${VORBIS_DIR}/lib/os.h"
	"${VORBIS_DIR}/lib/psy.h"
	"${VORBIS_DIR}/lib/registry.h"
	"${VORBIS_DIR}/lib/scales.h"
	"${VORBIS_DIR}/lib/smallft.h"
	"${VORBIS_DIR}/lib/window.h"

)

set(VORBIS_INCLUDE_DIRS)
set(VORBIS_LIBRARIES)
set(VORBIS_DEFINITIONS)

set(VORBIS_DEFS)
set(VORBIS_CFLAGS)
set(VORBIS_RELEASE_CFLAGS)
set(VORBIS_DEBUG_CFLAGS)
set(VORBIS_RELEASE_DEFINITIONS)
set(VORBIS_DEBUG_DEFINITIONS)

if(MSVC)
	#Optimization, Full /Ox
	list(APPEND VORBIS_CFLAGS "$<$<CONFIG:Release>:/Ox>")
	#Inline Function Expansion, only Suitable /Ob2
	list(APPEND VORBIS_CFLAGS "$<$<CONFIG:Release>:/Ob2>")
	#Enable Intrinsic Functions /Oi
	list(APPEND VORBIS_CFLAGS "$<$<CONFIG:Release>:/Oi>")
	#Favor Size of Speed, Favor Fast Code /Ot
	list(APPEND VORBIS_CFLAGS "$<$<CONFIG:Release>:/Ot>")

	#Enable String Pooling /GF
	list(APPEND VORBIS_CFLAGS "/GF")
	#Buffer Security Check, No /GS-
	list(APPEND VORBIS_CFLAGS "/GS-")

	#Calling Convention, __cdecl /Gd
	list(APPEND VORBIS_CFLAGS "/Gd")
	#Compile as, C Code /TC
	list(APPEND VORBIS_CFLAGS "/TC")
	#Disable specific warnings
	list(APPEND VORBIS_CFLAGS "/wd4244")
	list(APPEND VORBIS_CFLAGS "/wd4100")
	list(APPEND VORBIS_CFLAGS "/wd4267")
	list(APPEND VORBIS_CFLAGS "/wd4189")

	list(APPEND VORBIS_CFLAGS "/wd4189")
	list(APPEND VORBIS_CFLAGS "/wd4305")
	list(APPEND VORBIS_CFLAGS "/wd4127")
	list(APPEND VORBIS_CFLAGS "/wd4706")

endif(MSVC)


if(CMAKE_COMPILER_IS_GNUCC)

	if(PLATFORM MATCHES "linux*spe")
		list(APPEND VORBIS_RELEASE_CFLAGS "-Wall" "-Wextra" "-ffast-math" "-O3" "-mfused-madd")
		list(APPEND VORBIS_RELEASE_DEFINITIONS "-D_REENTRANT")
		list(APPEND VORBIS_DEBUG_CFLAGS "-Wall" "-Wextra" "-g")
		list(APPEND VORBIS_DEBUG_DEFINITIONS "-D_REENTRANT" "-D__NO_MATH_INLINES")
	elseif(PLATFORM MATCHES "linux")
		if(ARCH MATCHES "powerpc")
			list(APPEND VORBIS_RELEASE_CFLAGS "-Wall" "-Wextra" "-ffast-math" "-O3" "-mfused-madd" "-mcpu=750")
			list(APPEND VORBIS_RELEASE_DEFINITIONS "-D_REENTRANT")
			list(APPEND VORBIS_DEBUG_CFLAGS "-Wall" "-Wextra" "-g")
			list(APPEND VORBIS_DEBUG_DEFINITIONS "-D_REENTRANT" "-D__NO_MATH_INLINES")
		elsef(ARCH STREQUAL "x86")
			list(APPEND VORBIS_RELEASE_CFLAGS "-fsigned-char" "-O20" "-ffast-math" "-mno-ieee-fp")
			list(APPEND VORBIS_RELEASE_DEFINITIONS "-D_REENTRANT")
			list(APPEND VORBIS_DEBUG_CFLAGS "-fsigned-char" "-g" "-Wall" "-Wextra")
			list(APPEND VORBIS_DEBUG_DEFINITIONS "-D_REENTRANT" "-D__NO_MATH_INLINES")
		else()
			list(APPEND VORBIS_RELEASE_CFLAGS "-fsigned-char" "-Wall" "-Wextra" "-O20" "-ffast-math")
			list(APPEND VORBIS_RELEASE_DEFINITIONS "-D_REENTRANT")
			list(APPEND VORBIS_DEBUG_CFLAGS "-fsigned-char" "-Wall" "-Wextra" "-g")
			list(APPEND VORBIS_DEBUG_DEFINITIONS "-D_REENTRANT" "-D__NO_MATH_INLINES")
		endif()
	elseif(PLATFORM MATCHES "darwin")
		list(APPEND VORBIS_DEFINITIONS "-DDARWIN")

		list(APPEND VORBIS_RELEASE_CFLAGS "-fno-common" "-force_cpusubtype_ALL" "-g" "-Wall" "-fsigned-char" "-ffast-math" "-O4")
		list(APPEND VORBIS_DEBUG_CFLAGS "-fno-common" "-force_cpusubtype_ALL" "-g" "-Wall" "-fsigned-char" "-O0")
	elseif(PLATFORM MATCHES "os2")
		# Use -W instead of -Wextra because gcc on OS/2 is an old version.
		list(APPEND VORBIS_RELEASE_CFLAGS "-Wall" "-W" "-fsigned-char" "-ffast-math" "-O20")
		list(APPEND VORBIS_RELEASE_DEFINITIONS "-D_REENTRANT")
		list(APPEND VORBIS_DEBUG_CFLAGS "-Wall" "-W" "-fsigned-char" "-g")
		list(APPEND VORBIS_DEBUG_DEFINITIONS "-D_REENTRANT" "-D__NO_MATH_INLINES")
	elseif(ARCH STREQUAL "sparc")
		list(APPEND VORBIS_RELEASE_CFLAGS "-Wall" "-Wextra" "-fsigned-char" "-ffast-math" "-O20")
		list(APPEND VORBIS_DEBUG_CFLAGS "-Wall" "-Wextra" "-fsigned-char" "-g")
		list(APPEND VORBIS_DEBUG_DEFINITIONS "-D__NO_MATH_INLINES")
	else()
		list(APPEND VORBIS_DEFINITIONS "-D__NO_MATH_INLINES")

		list(APPEND VORBIS_RELEASE_CFLAGS "-Wall" "-Wextra" "-fsigned-char" "-O20")
		list(APPEND VORBIS_DEBUG_CFLAGS "-Wall" "-Wextra" "-fsigned-char" "-g")
	endif()

endif(CMAKE_COMPILER_IS_GNUCC)



if(CMAKE_BUILD_TYPE MATCHES "Release")
	list(APPEND VORBIS_CFLAGS ${VORBIS_RELEASE_CFLAGS})
	list(APPEND VORBIS_DEFS ${VORBIS_RELEASE_DEFINITIONS})
elseif(CMAKE_BUILD_TYPE MATCHES "Debug")
	list(APPEND VORBIS_CFLAGS ${VORBIS_DEBUG_CFLAGS})
	list(APPEND VORBIS_DEFS ${VORBIS_DEBUG_DEFINITIONS})
endif()


list(APPEND VORBIS_INCLUDE_DIRS "${VORBIS_DIR}/include")
list(APPEND VORBIS_INCLUDE_DIRS "${VORBIS_DIR}/lib")

list(APPEND VORBIS_LIBRARIES "${VORBIS_TARGET}")

if(NOT TARGET "${VORBIS_TARGET}")
	source_group("Source Files" FILES ${VORBIS_SOURCES})
	source_group("Header Files" FILES ${VORBIS_HEADERS})

	add_library("${VORBIS_TARGET}" STATIC ${VORBIS_SOURCES} ${VORBIS_HEADERS})

	target_include_directories("${VORBIS_TARGET}" PRIVATE ${VORBIS_INCLUDE_DIRS})

	target_compile_definitions("${VORBIS_TARGET}" PRIVATE ${VORBIS_DEFINITIONS} ${VORBIS_DEFS})

	target_compile_options("${VORBIS_TARGET}" PRIVATE ${VORBIS_CFLAGS})

endif()
