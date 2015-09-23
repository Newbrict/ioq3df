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

project("client")

set(CLIENT_TARGET "client")

set(SOURCE_DIR "${CMAKE_CURRENT_LIST_DIR}/../../..")
set(CMAKELIST_DIR "${SOURCE_DIR}/misc/CMakeLists")

include("${CMAKELIST_DIR}/include/directory_constants.cmake")
include("${CMAKELIST_DIR}/include/default_options.cmake")
include("${CMAKELIST_DIR}/include/platform.cmake")
include(CheckCCompilerFlag RESULT_VARIABLE MODULE_CHECKCCOMPILERFLAG_EXISTS)
include(CheckCSourceCompiles RESULT_VARIABLE MODULE_CHECKCSOURCECOMPILES_EXISTS)
include(CheckIncludeFile RESULT_VARIABLE MODULE_CHECKINCLUDEFILE_EXISTS)
include(TestBigEndian RESULT_VARIABLE MODULE_TESTBIGENDIAN_EXISTS)
include("${CMAKELIST_DIR}/include/cmake_compatibility.cmake")

#cmake does append any extensions
set(CLIENT_BIN "${DEFAULT_CLIENT_BIN}" CACHE STRING "binary/executable name")

#Note: options and build directories get cached
option(USE_INTERNAL_LIBS "Use internal libraries (Speex,Ogg,Vorbis,Opus,zlib,JPEG,...)" ${DEFAULT_USE_INTERNAL_LIBS})
option(USE_INTERNAL_SPEEX "Use internal Speex library" ${USE_INTERNAL_LIBS})
option(USE_INTERNAL_OGG "Use internal Ogg" ${USE_INTERNAL_LIBS})
option(USE_INTERNAL_VORBIS "Use internal Vorbis" ${USE_INTERNAL_LIBS})
option(USE_INTERNAL_OPUS "Use internal Opus" ${USE_INTERNAL_LIBS})
option(USE_INTERNAL_ZLIB "Use internal zlib" ${USE_INTERNAL_LIBS})
option(USE_LOCAL_HEADERS "Use local headers" ${USE_INTERNAL_LIBS})

option(USE_CURL "Use cURL" ${DEFAULT_USE_CURL})
option(USE_CURL_DLOPEN "Use cURL dynamic library opening" ${DEFAULT_USE_CURL_DLOPEN})
option(USE_ICON "Use window icon" ${DEFAULT_USE_ICON})
option(USE_OPENAL "Use OpenAL" ${DEFAULT_USE_OPENAL})
option(USE_OPENAL_DLOPEN "Use OpenAL dynamic library opening" ${DEFAULT_USE_OPENAL_DLOPEN})
option(USE_RENDERER_DLOPEN "Use renderer dynamic library opening" ${DEFAULT_USE_RENDERER_DLOPEN})
option(USE_VOIP "Use VOIP" ${DEFAULT_USE_VOIP})
option(USE_MUMBLE "Use Mumble support" ${DEFAULT_USE_MUMBLE})
option(USE_CODEC_OPUS "Use Opus support" ${DEFAULT_USE_CODEC_OPUS})
option(USE_CODEC_VORBIS "Use Vorbis support" ${DEFAULT_USE_CODEC_VORBIS})
option(USE_FREETYPE "Use Freetype2 support" ${DEFAULT_USE_FREETYPE})

option(USE_RENDERER_DLOPEN "Use renderer dynamic library opening" ${DEFAULT_USE_RENDERER_DLOPEN})
option(BUILD_STANDALONE "Standalone" ${DEFAULT_BUILD_STANDALONE})

option(GENERATE_DEPENDENCIES "Preprocessing: Generate dependencies for make outputting" ${DEFAULT_GENERATE_DEPENDENCIES})

set(VERSION "${DEFAULT_VERSION}" CACHE STRING "Verson number")

set(BIN_EXT "${DEFAULT_BIN_EXT}" CACHE STRING "Binary/executable extension")

set(INSTALL_DIR "${DEFAULT_INSTALL_DIR}" CACHE PATH "Installation directory")


set(ASM_SOURCES 
#no unused files and files for platforms/compilers
#	"${ASM_DIR}/ftola.c"
#	"${ASM_DIR}/snapvector.c"
)

set(ASM_HEADERS 
#	"${ASM_DIR}/qasm.h"
#	"${ASM_DIR}/qasm-inline.h"
)

set(BOTLIB_SOURCES 
	"${BOTLIB_DIR}/be_aas_bspq3.c"
	"${BOTLIB_DIR}/be_aas_cluster.c"
	"${BOTLIB_DIR}/be_aas_debug.c"
	"${BOTLIB_DIR}/be_aas_entity.c"
	"${BOTLIB_DIR}/be_aas_file.c"
	"${BOTLIB_DIR}/be_aas_main.c"
	"${BOTLIB_DIR}/be_aas_move.c"
	"${BOTLIB_DIR}/be_aas_optimize.c"
	"${BOTLIB_DIR}/be_aas_reach.c"
	"${BOTLIB_DIR}/be_aas_route.c"
	"${BOTLIB_DIR}/be_aas_routealt.c"
	"${BOTLIB_DIR}/be_aas_sample.c"
	"${BOTLIB_DIR}/be_ai_char.c"
	"${BOTLIB_DIR}/be_ai_chat.c"
	"${BOTLIB_DIR}/be_ai_gen.c"
	"${BOTLIB_DIR}/be_ai_goal.c"
	"${BOTLIB_DIR}/be_ai_move.c"
	"${BOTLIB_DIR}/be_ai_weap.c"
	"${BOTLIB_DIR}/be_ai_weight.c"
	"${BOTLIB_DIR}/be_ea.c"
	"${BOTLIB_DIR}/be_interface.c"
	"${BOTLIB_DIR}/l_crc.c"
	"${BOTLIB_DIR}/l_libvar.c"
	"${BOTLIB_DIR}/l_log.c"
	"${BOTLIB_DIR}/l_memory.c"
	"${BOTLIB_DIR}/l_precomp.c"
	"${BOTLIB_DIR}/l_script.c"
	"${BOTLIB_DIR}/l_struct.c"
)
set(BOTLIB_HEADERS 
	"${BOTLIB_DIR}/aasfile.h"
	"${BOTLIB_DIR}/be_aas.h"
	"${BOTLIB_DIR}/be_aas_bsp.h"
	"${BOTLIB_DIR}/be_aas_cluster.h"
	"${BOTLIB_DIR}/be_aas_debug.h"
	"${BOTLIB_DIR}/be_aas_def.h"
	"${BOTLIB_DIR}/be_aas_entity.h"
	"${BOTLIB_DIR}/be_aas_file.h"
	"${BOTLIB_DIR}/be_aas_funcs.h"
	"${BOTLIB_DIR}/be_aas_main.h"
	"${BOTLIB_DIR}/be_aas_move.h"
	"${BOTLIB_DIR}/be_aas_optimize.h"
	"${BOTLIB_DIR}/be_aas_reach.h"
	"${BOTLIB_DIR}/be_aas_route.h"
	"${BOTLIB_DIR}/be_aas_routealt.h"
	"${BOTLIB_DIR}/be_aas_sample.h"
	"${BOTLIB_DIR}/be_ai_char.h"
	"${BOTLIB_DIR}/be_ai_chat.h"
	"${BOTLIB_DIR}/be_ai_gen.h"
	"${BOTLIB_DIR}/be_ai_goal.h"
	"${BOTLIB_DIR}/be_ai_move.h"
	"${BOTLIB_DIR}/be_ai_weap.h"
	"${BOTLIB_DIR}/be_ai_weight.h"
	"${BOTLIB_DIR}/be_ea.h"
	"${BOTLIB_DIR}/be_interface.h"
	"${BOTLIB_DIR}/botlib.h"
	"${BOTLIB_DIR}/l_crc.h"
	"${BOTLIB_DIR}/l_libvar.h"
	"${BOTLIB_DIR}/l_log.h"
	"${BOTLIB_DIR}/l_memory.h"
	"${BOTLIB_DIR}/l_precomp.h"
	"${BOTLIB_DIR}/l_script.h"
	"${BOTLIB_DIR}/l_struct.h"
	"${BOTLIB_DIR}/l_utils.h"
)
set(CLIENT_SOURCES 
	"${CLIENT_DIR}/cl_avi.c"
	"${CLIENT_DIR}/cl_cgame.c"
	"${CLIENT_DIR}/cl_cin.c"
	"${CLIENT_DIR}/cl_console.c"
	"${CLIENT_DIR}/cl_curl.c"
	"${CLIENT_DIR}/cl_curl.h"
	"${CLIENT_DIR}/cl_input.c"
	"${CLIENT_DIR}/cl_keys.c"
	"${CLIENT_DIR}/cl_main.c"
	"${CLIENT_DIR}/cl_net_chan.c"
	"${CLIENT_DIR}/cl_parse.c"
	"${CLIENT_DIR}/cl_scrn.c"
	"${CLIENT_DIR}/cl_ui.c"
#	"${CLIENT_DIR}/libmumblelink.c"
	"${CLIENT_DIR}/qal.c"
	"${CLIENT_DIR}/snd_adpcm.c"
	"${CLIENT_DIR}/snd_codec.c"
	"${CLIENT_DIR}/snd_codec_ogg.c"
	"${CLIENT_DIR}/snd_codec_opus.c"
	"${CLIENT_DIR}/snd_codec_wav.c"
	"${CLIENT_DIR}/snd_dma.c"
	"${CLIENT_DIR}/snd_main.c"
	"${CLIENT_DIR}/snd_mem.c"
	"${CLIENT_DIR}/snd_mix.c"
	"${CLIENT_DIR}/snd_openal.c"
	"${CLIENT_DIR}/snd_wavelet.c"
)
set(CLIENT_HEADERS 
	"${CLIENT_DIR}/cl_curl.h"
	"${CLIENT_DIR}/client.h"
	"${CLIENT_DIR}/keycodes.h"
	"${CLIENT_DIR}/keys.h"
	"${CLIENT_DIR}/libmumblelink.h"
	"${CLIENT_DIR}/qal.h"
	"${CLIENT_DIR}/snd_codec.h"
	"${CLIENT_DIR}/snd_local.h"
	"${CLIENT_DIR}/snd_public.h"
)
set(CLIENT_MUMBLE_SOURCES 
	"${CLIENT_DIR}/libmumblelink.c"
)

include("${CMAKELIST_DIR}/include/libsdl_headers.cmake")

set(QCOMMON_SOURCES 
	"${QCOMMON_DIR}/cm_load.c"
	"${QCOMMON_DIR}/cm_patch.c"
	"${QCOMMON_DIR}/cm_polylib.c"
	"${QCOMMON_DIR}/cm_test.c"
	"${QCOMMON_DIR}/cm_trace.c"
	"${QCOMMON_DIR}/cmd.c"
	"${QCOMMON_DIR}/common.c"
	"${QCOMMON_DIR}/cvar.c"
	"${QCOMMON_DIR}/files.c"
	"${QCOMMON_DIR}/huffman.c"
	"${QCOMMON_DIR}/ioapi.c"
	"${QCOMMON_DIR}/md4.c"
	"${QCOMMON_DIR}/md5.c"
	"${QCOMMON_DIR}/msg.c"
	"${QCOMMON_DIR}/net_chan.c"
	"${QCOMMON_DIR}/net_ip.c"
	"${QCOMMON_DIR}/puff.c"
	"${QCOMMON_DIR}/q_math.c"
	"${QCOMMON_DIR}/q_shared.c"
	"${QCOMMON_DIR}/unzip.c"
	"${QCOMMON_DIR}/vm.c"
	"${QCOMMON_DIR}/vm_interpreted.c"
#	"${QCOMMON_DIR}/vm_none.c"
#	"${QCOMMON_DIR}/vm_powerpc.c"
#	"${QCOMMON_DIR}/vm_powerpc_asm.c"
#	"${QCOMMON_DIR}/vm_sparc.c"
#	"${QCOMMON_DIR}/vm_x86.c"
)
set(QCOMMON_HEADERS 
	"${QCOMMON_DIR}/cm_local.h"
	"${QCOMMON_DIR}/cm_patch.h"
	"${QCOMMON_DIR}/cm_polylib.h"
	"${QCOMMON_DIR}/cm_public.h"
	"${QCOMMON_DIR}/ioapi.h"
	"${QCOMMON_DIR}/puff.h"
	"${QCOMMON_DIR}/q_platform.h"
	"${QCOMMON_DIR}/q_shared.h"
	"${QCOMMON_DIR}/qcommon.h"
	"${QCOMMON_DIR}/qfiles.h"
	"${QCOMMON_DIR}/surfaceflags.h"
	"${QCOMMON_DIR}/unzip.h"
	"${QCOMMON_DIR}/vm_local.h"
#	"${QCOMMON_DIR}/vm_powerpc_asm.h"
#	"${QCOMMON_DIR}/vm_sparc.h"
)
list(APPEND QCOMMON_X86_SOURCES 
	"${QCOMMON_DIR}/vm_x86.c"
)
list(APPEND QCOMMON_PPC_SOURCES 
	"${QCOMMON_DIR}/vm_powerpc.c"
	"${QCOMMON_DIR}/vm_powerpc_asm.c"
)
list(APPEND QCOMMON_SPARC_SOURCES 
	"${QCOMMON_DIR}/vm_sparc.c"
)

set(SDL_SOURCES 
#	"${SDL_DIR}/sdl_gamma.c"
#	"${SDL_DIR}/sdl_glimp.c"
	"${SDL_DIR}/sdl_input.c"
	"${SDL_DIR}/sdl_snd.c"
)
set(SDL_HEADERS 
	"${SDL_DIR}/sdl_icon.h"
)


set(SERVER_SOURCES 
	"${SERVER_DIR}/sv_bot.c"
	"${SERVER_DIR}/sv_ccmds.c"
	"${SERVER_DIR}/sv_client.c"
	"${SERVER_DIR}/sv_game.c"
	"${SERVER_DIR}/sv_init.c"
	"${SERVER_DIR}/sv_main.c"
	"${SERVER_DIR}/sv_net_chan.c"
#	"${SERVER_DIR}/sv_rankings.c"
	"${SERVER_DIR}/sv_snapshot.c"
	"${SERVER_DIR}/sv_world.c"
)
set(SERVER_HEADERS
	"${SERVER_DIR}/server.h"
)

set(SYS_SOURCES 
	"${SYS_DIR}/con_log.c"
#	"${SYS_DIR}/con_passive.c"
#	"${SYS_DIR}/con_tty.c"
#	"${SYS_DIR}/con_win32.c"
	"${SYS_DIR}/sys_main.c"
#	"${SYS_DIR}/sys_unix.c"
#	"${SYS_DIR}/sys_win32.c"
)
set(SYS_HEADERS 
	"${SYS_DIR}/sys_loadlib.h"
	"${SYS_DIR}/sys_local.h"
	"${SYS_DIR}/win_resource.h"
)
list(APPEND SYS_RC_SOURCES 
	"${SYS_DIR}/win_resource.rc"
)
list(APPEND SYS_WIN_SOURCES 
	"${SYS_DIR}/con_passive.c"
	"${SYS_DIR}/sys_win32.c"
#	"${SYS_DIR}/con_win32.c"
)
list(APPEND SYS_UNIX_SOURCES 
#	"${SYS_DIR}/con_unix.c"
	"${SYS_DIR}/con_tty.c"
	"${SYS_DIR}/sys_unix.c"
)
list(APPEND SYS_OSX_SOURCES 
	"${SYS_DIR}/sys_osx.c"
)




if(NOT SDL_FOUND)
	find_package(SDL 2 QUIET)
	#find_package sets *_FOUND *_INCLUDE_DIR(S) *_LIBRAR(Y)IES
endif(NOT SDL_FOUND)

if(USE_CURL_DLOPEN AND USE_LOCAL_HEADERS)
	set(CURL_FOUND TRUE)
endif()


if(MSVC)
	if(NOT SDL_FOUND)
		list(APPEND CLIENT_C_HEADERS ${LIBSDL_HEADERS})
		list(APPEND SDL_INCLUDE_DIRS "${LIBSDL_DIR}/include")

		math(EXPR BITS "${CMAKE_SIZEOF_VOID_P} * 8")
		list(APPEND SDL_LIBRARIES 
			"${LIBS_DIR}/win${BITS}/SDL2.lib" 
			"${LIBS_DIR}/win${BITS}/SDL2main.lib"
		)
		set(SDL_FOUND TRUE)

		foreach(FILEPATH ${SDL_LIBRARIES})
			if(NOT EXISTS "${FILEPATH}")
				get_filename_component(FILE "${FILEPATH}" NAME)
				message(WARNING "Did not find ${FILE} for MSVC, asuming: ${FILEPATH}\n")
			endif()
		endforeach(FILEPATH)
	endif()

	if(NOT USE_CURL_DLOPEN)
		if(USE_LOCAL_HEADERS)
			list(APPEND CURL_DEFINITIONS "-DCURL_STATICLIB")
			if(ARCH STREQUAL "x86_64")
				list(APPEND CURL_LIBRARIES "${LIBS_DIR}/win64/curl.lib")
			else()
				list(APPEND CURL_LIBRARIES "${LIBS_DIR}/win32/curl.lib")
			endif()
			set(CURL_FOUND TRUE)

			foreach(FILEPATH ${CURL_LIBRARIES})
				if(NOT EXISTS "${FILEPATH}")
					get_filename_component(FILE "${FILEPATH}" NAME)
					message(WARNING "Did not find ${FILE} for MSVC, asuming: ${FILEPATH}\n")
				endif()
			endforeach(FILEPATH)
		endif(USE_LOCAL_HEADERS)
	endif(NOT USE_CURL_DLOPEN)

	#time functions winmm.lib
	#EnumProcesses function psapi.lib
	#windows socket functions ws2_32.lib
	list(APPEND CLIENT_LIBRARIES "winmm" "psapi" "ws2_32")

	#Whole program optimization, no /GL-
	list(APPEND CLIENT_CFLAGS "/GL-")

	#Warning Level /W4
	list(APPEND CLIENT_CFLAGS "/W4")

	#Enable String Pooling /GF
	list(APPEND CLIENT_CFLAGS "/GF")
	#Enable C++ Exceptions, No /EHa-
	list(APPEND CLIENT_CFLAGS "/EHa-")
	#Enable Function-Level Linking /Gy
	list(APPEND CLIENT_CFLAGS "/Gy")
	#Floating Point Model /fp:fast
	list(APPEND CLIENT_CFLAGS "/fp:fast")

	#Compile as, C Code /TC
	list(APPEND CLIENT_CFLAGS "/TC")

	#Subsystem /SUBSYSTEM:WINDOWS
	list(APPEND CLIENT_LDFLAGS "/SUBSYSTEM:WINDOWS")
	#Stack Reserve Size /STACK:8388608
	list(APPEND CLIENT_LDFLAGS "/STACK:8388608")
	#Randomized Base Address /DYNAMICBASE:NO
	list(APPEND CLIENT_LDFLAGS "/DYNAMICBASE:NO")
	#Data Execution Prevenbtion (DEP) /NXCOMPAT:NO
	list(APPEND CLIENT_LDFLAGS "/NXCOMPAT:NO")
	#Image Has Safe Exception Handlers, is no longer default no in msvc 2013, /SAFESEH:NO
	list(APPEND CLIENT_LDFLAGS "/SAFESEH:NO")

	#Disable specific warnings
	#warning C4706: assignment within conditional expression
	list(APPEND CLIENT_CFLAGS "/wd4706")
	#warning C4389: '!=' : signed/unsigned mismatch
	list(APPEND CLIENT_CFLAGS "/wd4389")
	#warning C4100: 'opaque' : unreferenced formal parameter
	list(APPEND CLIENT_CFLAGS "/wd4100")
	#warning C4131: 'fill_fopen_filefunc' : uses old-style declarator
	list(APPEND CLIENT_CFLAGS "/wd4131")
	#warning C4245: 'return' : conversion from 'int' to 'uLong', signed/unsigned mismatch
	list(APPEND CLIENT_CFLAGS "/wd4245")

	#Character Set, CharacterSet="0", Not Set, ASCII/SBCS (Single Byte Character Set)
	list(APPEND CLIENT_DEFINITIONS "-D_SBCS")

	#no warnings about using old functions like strcmp
	list(APPEND CLIENT_DEFINITIONS "-D_CRT_SECURE_NO_WARNINGS")

endif(MSVC)

if(MINGW)
	#need misc/../ for misc/quake3.ico in win_resource.rc.obj
	list(APPEND CLIENT_INCLUDE_DIRS "${SOURCE_DIR}")

	if(NOT SDL_FOUND)
		list(APPEND CLIENT_C_HEADERS ${LIBSDL_HEADERS})
		list(APPEND SDL_INCLUDE_DIRS "${LIBSDL_DIR}/include")

		math(EXPR BITS "${CMAKE_SIZEOF_VOID_P} * 8")
		list(APPEND SDL_LIBRARIES 
			"${LIBS_DIR}/win${BITS}/libSDL2.dll.a" 
#			"${LIBS_DIR}/win${BITS}/libSDL2main.a"
		)
		set(SDL_FOUND TRUE)
	endif()

	if(NOT USE_CURL_DLOPEN)
		if(USE_LOCAL_HEADERS)
			list(APPEND CURL_DEFINITIONS "-DCURL_STATICLIB")
			if(ARCH STREQUAL "x86_64")
				list(APPEND CURL_LIBRARIES "${LIBS_DIR}/win64/libcurl.a")
			else()
				list(APPEND CURL_LIBRARIES "${LIBS_DIR}/win32/libcurl.a")
			endif()
			set(CURL_FOUND TRUE)
		endif(USE_LOCAL_HEADERS)
	endif(NOT USE_CURL_DLOPEN)

	#need to link mingw before SDL
	list(APPEND CLIENT_LIBRARIES "mingw32")

	#time functions winmm.lib
	#EnumProcesses function psapi.lib
	#socket functions ws2_32.lib
	#ImmGetIMEFileName imm32.lib
	#GetFileVersionInfoSize Version.lib
	list(APPEND CLIENT_LIBRARIES "imm32" "Version" "winmm" "psapi" "ws2_32")

	if(NOT DEFINED WINVER)
		if(${CMAKE_SYSTEM_VERSION} VERSION_EQUAL "5" OR ${CMAKE_SYSTEM_VERSION} VERSION_GREATER "5")
			list(APPEND CLIENT_DEFINITIONS "-DWINVER=0x0501")
			set(WINVER_WARNING "Using Windows XP: -DWINVER=0x0501")
		endif()
		message(WARNING "WINVER not set for the target OS, related to the Platform Toolset in MSVC.\n"
			"0x0501 for Windows XP, 0x0502 for Windows Server 2003, 0x0600 for Windows Vista, 0x0601 for Windows 7, 0x0602 for Windows 8 and 0x603 for Windows 8.1.\n"
			"${WINVER_WARNING}")
	endif()

	#No WinMain function for SDL
	list(APPEND CLIENT_DEFINITIONS "-DSDL_MAIN_HANDLED")

endif(MINGW)


if(MSVC OR MINGW)
	list(APPEND SYS_SOURCES ${SYS_WIN_SOURCES})
else()
	list(APPEND SYS_SOURCES ${SYS_UNIX_SOURCES})
endif()

#TODO: just darwin or osx/apple?
if(PLATFORM STREQUAL "darwin")
	list(APPEND SYS_SOURCES ${SYS_OSX_SOURCES})
endif()

if(APPLE)
	list(APPEND CLIENT_DEFINITIONS "-DMACOS_X")

	if(NOT SDL_FOUND)
		list(APPEND CLIENT_C_HEADERS ${LIBSDL_HEADERS})
		list(APPEND SDL_INCLUDE_DIRS "${LIBSDL_DIR}/include")

		list(APPEND SDL_LIBRARIES 
			"${LIBS_DIR}/macosx/libSDL2-2.0.0.dylib" 
			"${LIBS_DIR}/macosx/libSDL2main.a"
		)
		set(SDL_FOUND TRUE)
	endif()
endif(APPLE)

if(CMAKE_COMPILER_IS_GNUCC)

	if(ARCH STREQUAL "x86_64")
		list(APPEND OPTIMIZEVM "-O3")
		list(APPEND OPTIMIZEVM "-fno-omit-frame-pointer")
		list(APPEND OPTIMIZEVM "-funroll-loops")
		list(APPEND OPTIMIZEVM "-falign-functions=2")
		list(APPEND OPTIMIZEVM "-fstrength-reduce")
		list(APPEND OPTIMIZE ${OPTIMIZEVM})
		list(APPEND OPTIMIZE "-ffast-math")
	elseif(ARCH STREQUAL "x86")
		list(APPEND OPTIMIZEVM "-O3")
		list(APPEND OPTIMIZEVM "-march=i586")
		list(APPEND OPTIMIZEVM "-fno-omit-frame-pointer")
		list(APPEND OPTIMIZEVM "-funroll-loops")
		list(APPEND OPTIMIZEVM "-falign-functions=2")
		list(APPEND OPTIMIZEVM "-fstrength-reduce")
		list(APPEND OPTIMIZE ${OPTIMIZEVM})
		list(APPEND OPTIMIZE "-ffast-math")
	endif()

	set(USE_ASM TRUE)
	list(APPEND CLIENT_INLINE_ASM_CFLAGS "-msse2")


	set(WARNING_CFLAGS)

	list(APPEND WARNING_CFLAGS "-Wall")
	list(APPEND WARNING_CFLAGS "-Wimplicit")
	list(APPEND WARNING_CFLAGS "-Wstrict-prototypes")

	list(APPEND WARNING_CFLAGS "-Wformat=2")
	list(APPEND WARNING_CFLAGS "-Wno-format-zero-length")
	list(APPEND WARNING_CFLAGS "-Wformat-security")
	list(APPEND WARNING_CFLAGS "-Wno-format-nonliteral")
	list(APPEND WARNING_CFLAGS "-Wstrict-aliasing=2")
	list(APPEND WARNING_CFLAGS "-Wmissing-format-attribute")
	list(APPEND WARNING_CFLAGS "-Wdisabled-optimization")
	list(APPEND WARNING_CFLAGS "-Werror-implicit-function-declaration")

	if(GENERATE_DEPENDENCIES)
		list(APPEND CLIENT_CFLAGS "-MMD")
	endif(GENERATE_DEPENDENCIES)

	list(APPEND CLIENT_CFLAGS "-fno-strict-aliasing")

	list(APPEND CLIENT_CFLAGS ${BASE_CFLAGS})
	list(APPEND CLIENT_CFLAGS ${WARNING_CFLAGS})

	if(CMAKE_BUILD_TYPE MATCHES "Release")
		list(APPEND CLIENT_CFLAGS ${OPTIMIZE})
	elseif(CMAKE_BUILD_TYPE MATCHES "Debug")
		set(DEBUG_CFLAGS)
		list(APPEND DEBUG_CFLAGS "-g")
		list(APPEND DEBUG_CFLAGS "-O0")
		list(APPEND CLIENT_CFLAGS ${DEBUG_CFLAGS})

		list(APPEND CLIENT_DEFINITIONS "-DNDEBUG")
	endif()

	CHECK_C_SOURCE_COMPILES("int foo(const char *str, ...) __attribute__((format(printf, 1, 2))); int main() {return 0;}" HAVE_GCC_FORMAT)
	if(HAVE_GCC_FORMAT)
		list(APPEND CLIENT_DEFINITIONS "-DHAVE_GCC_FORMAT")
	endif(HAVE_GCC_FORMAT)

endif(CMAKE_COMPILER_IS_GNUCC)


if(CMAKE_C_COMPILER_ID MATCHES "Clang")
	list(APPEND CLIENT_CFLAGS "-Qunused-arguments")
endif()

if(ARCH STREQUAL "x86" OR ARCH STREQUAL "x86_64")
	list(APPEND QCOMMON_SOURCES ${QCOMMON_X86_SOURCES})
endif()
if(ARCH STREQUAL "ppc" OR ARCH STREQUAL "ppc64")
	list(APPEND QCOMMON_SOURCES ${QCOMMON_PPC_SOURCES})
endif()
if(ARCH STREQUAL "sparc")
	list(APPEND QCOMMON_SOURCES ${QCOMMON_SPARC_SOURCES})
endif()


#add new platform and compiler options above this
###

#need misc/msvc for ../quake3.ico in win_resource.rc
list(APPEND CLIENT_INCLUDE_DIRS "${SOURCE_DIR}/misc/msvc")

if(PRODUCT_VERSION)
	list(APPEND CLIENT_DEFINITIONS "-DPRODUCT_VERSION=\"${PRODUCT_VERSION}\"")
endif(PRODUCT_VERSION)

if(NOT SDL_FOUND)
	find_package(SDL 2 REQUIRED)
endif(NOT SDL_FOUND)

if(SDL_INCLUDE_DIR)
	list(APPEND CLIENT_INCLUDE_DIRS "${SDL_INCLUDE_DIR}")
endif(SDL_INCLUDE_DIR)
list(APPEND CLIENT_INCLUDE_DIRS ${SDL_INCLUDE_DIRS})
if(SDL_LIBRARY)
	list(APPEND CLIENT_LIBRARIES "${SDL_LIBRARY}")
endif(SDL_LIBRARY)
list(APPEND CLIENT_LIBRARIES ${SDL_LIBRARIES})
list(APPEND CLIENT_DEFINITIONS ${SDL_DEFINITIONS})

if(USE_INTERNAL_ZLIB)
	include("${CMAKELIST_DIR}/include/internal_zlib.cmake")
else()
	find_package(ZLIB REQUIRED)
endif(USE_INTERNAL_ZLIB)
list(APPEND CLIENT_INCLUDE_DIRS ${ZLIB_INCLUDE_DIRS})
list(APPEND CLIENT_LIBRARIES ${ZLIB_LIBRARIES})
list(APPEND CLIENT_DEFINITIONS ${ZLIB_DEFINITIONS})

if(USE_CODEC_OPUS)
	if(USE_INTERNAL_OPUS)
		include("${CMAKELIST_DIR}/include/internal_opusfile.cmake")
		include("${CMAKELIST_DIR}/include/internal_opus.cmake")
	else()
		find_package(OPUSFILE REQUIRED)
		find_package(OPUS REQUIRED)
	endif(USE_INTERNAL_OPUS)
	if(OPUSFILE_INCLUDE_DIR)
		list(APPEND CLIENT_INCLUDE_DIRS "${OPUSFILE_INCLUDE_DIR}")
	endif(OPUSFILE_INCLUDE_DIR)
	list(APPEND CLIENT_INCLUDE_DIRS ${OPUSFILE_INCLUDE_DIRS})
	if(OPUSFILE_LIBRARY)
		list(APPEND CLIENT_LIBRARIES "${OPUSFILE_LIBRARY}")
	endif(OPUSFILE_LIBRARY)
	list(APPEND CLIENT_LIBRARIES ${OPUSFILE_LIBRARIES})
	list(APPEND CLIENT_DEFINITIONS ${OPUSFILE_DEFINITIONS})

	if(OPUS_INCLUDE_DIR)
		list(APPEND CLIENT_INCLUDE_DIRS "${OPUS_INCLUDE_DIR}")
	endif(OPUS_INCLUDE_DIR)
	list(APPEND CLIENT_INCLUDE_DIRS ${OPUS_INCLUDE_DIRS})
	if(OPUS_LIBRARY)
		list(APPEND CLIENT_LIBRARIES "${OPUS_LIBRARY}")
	endif(OPUS_LIBRARY)
	list(APPEND CLIENT_LIBRARIES ${OPUS_LIBRARIES})
	list(APPEND CLIENT_DEFINITIONS ${OPUS_DEFINITIONS})

	list(APPEND CLIENT_DEFINITIONS "-DUSE_CODEC_OPUS")

	set(NEED_OGG TRUE)
endif(USE_CODEC_OPUS)

if(USE_CODEC_VORBIS)
	if(USE_INTERNAL_VORBIS)
		include("${CMAKELIST_DIR}/include/internal_vorbis.cmake")
	else()
		find_package(VORBIS REQUIRED)
	endif(USE_INTERNAL_VORBIS)
	if(VORBIS_INCLUDE_DIR)
		list(APPEND CLIENT_INCLUDE_DIRS "${VORBIS_INCLUDE_DIR}")
	endif(VORBIS_INCLUDE_DIR)
	list(APPEND CLIENT_INCLUDE_DIRS ${VORBIS_INCLUDE_DIRS})
	if(VORBIS_LIBRARY)
		list(APPEND CLIENT_LIBRARIES "${VORBIS_LIBRARY}")
	endif(VORBIS_LIBRARY)
	list(APPEND CLIENT_LIBRARIES ${VORBIS_LIBRARIES})
	list(APPEND CLIENT_DEFINITIONS ${VORBIS_DEFINITIONS})

	list(APPEND CLIENT_DEFINITIONS "-DUSE_CODEC_VORBIS")
	set(NEED_OGG TRUE)
endif(USE_CODEC_VORBIS)

if(NEED_OGG)
	if(USE_INTERNAL_OGG)
		include("${CMAKELIST_DIR}/include/internal_ogg.cmake")
	else()
		find_package(OGG REQUIRED)
	endif(USE_INTERNAL_OGG)
	if(OGG_INCLUDE_DIR)
		list(APPEND CLIENT_INCLUDE_DIRS "${OGG_INCLUDE_DIR}")
	endif(OGG_INCLUDE_DIR)
	list(APPEND CLIENT_INCLUDE_DIRS ${OGG_INCLUDE_DIRS})
	if(OGG_LIBRARY)
		list(APPEND CLIENT_LIBRARIES "${OGG_LIBRARY}")
	endif(OGG_LIBRARY)
	list(APPEND CLIENT_LIBRARIES ${OGG_LIBRARIES})
	list(APPEND CLIENT_DEFINITIONS ${OGG_DEFINITIONS})

	list(APPEND CLIENT_DEFINITIONS "-DUSE_CODEC_OGG")
endif(NEED_OGG)

if(USE_MUMBLE)
	CHECK_INCLUDE_FILE("unistd.h" HAVE_UNISTD_H)
	if(HAVE_UNISTD_H)
		list(APPEND CLIENT_DEFINITIONS "-DHAVE_UNISTD_H")
	endif(HAVE_UNISTD_H)

	CHECK_INCLUDE_FILE("sys/mman.h" HAVE_SYS_MMAN_H)
	if(HAVE_SYS_MMAN_H)
		list(APPEND CLIENT_DEFINITIONS "-DHAVE_SYS_MMAN_H")
	endif(HAVE_SYS_MMAN_H)

	#For mode constants
	CHECK_INCLUDE_FILE("sys/stat.h" HAVE_SYS_STAT_H)
	if(HAVE_SYS_STAT_H)
		list(APPEND CLIENT_DEFINITIONS "-DHAVE_SYS_STAT_H")
	endif(HAVE_SYS_STAT_H)

	#For O_* constants
	CHECK_INCLUDE_FILE("fcntl.h" HAVE_FCNTL_H)
	if(HAVE_FCNTL_H)
		list(APPEND CLIENT_DEFINITIONS "-DHAVE_FCNTL_H")
	endif(HAVE_FCNTL_H)

	CHECK_C_SOURCE_COMPILES("#include <sys/mman.h>\n int main () {int shmfd;shmfd = shm_open(\"\", 0, 0);return 0;}" HAVE_SHM_OPEN)
	if(HAVE_SHM_OPEN)
		list(APPEND CLIENT_DEFINITIONS "-DHAVE_SHM_OPEN")
	endif(HAVE_SHM_OPEN)

	set(CMAKE_REQUIRED_LIBRARIES "rt")
	CHECK_C_SOURCE_COMPILES("#include <sys/mman.h>\n int main () {int shmfd;shmfd = shm_open(\"\", 0, 0);return 0;}" HAVE_SHM_OPEN_IN_RT)
	set(CMAKE_REQUIRED_LIBRARIES)
	if(HAVE_SHM_OPEN_IN_RT)
		list(APPEND CLIENT_DEFINITIONS "-DHAVE_SHM_OPEN")
		list(APPEND CLIENT_LIBRARIES "rt")
	endif(HAVE_SHM_OPEN_IN_RT)

	CHECK_INCLUDE_FILE("stdint.h" HAVE_STDINT_H)
	if( HAVE_STDINT_H)
		list(APPEND CLIENT_DEFINITIONS "-DHAVE_STDINT_H")
	endif( HAVE_STDINT_H)


	list(APPEND CLIENT_C_SOURCES ${CLIENT_MUMBLE_SOURCES})
	list(APPEND CLIENT_DEFINITIONS "-DUSE_MUMBLE")

endif(USE_MUMBLE)

if(USE_VOIP)
	if(USE_INTERNAL_SPEEX)
		include("${CMAKELIST_DIR}/include/internal_speex.cmake")
	else()
		find_package(SPEEX REQUIRED)
	endif(USE_INTERNAL_SPEEX)
	if(SPEEX_INCLUDE_DIR)
		list(APPEND CLIENT_INCLUDE_DIRS "${SPEEX_INCLUDE_DIR}")
	endif(SPEEX_INCLUDE_DIR)
	list(APPEND CLIENT_INCLUDE_DIRS ${SPEEX_INCLUDE_DIRS})
	if(SPEEX_LIBRARY)
		list(APPEND CLIENT_LIBRARIES "${SPEEX_LIBRARY}")
	endif(SPEEX_LIBRARY)
	list(APPEND CLIENT_LIBRARIES ${SPEEX_LIBRARIES})
	list(APPEND CLIENT_DEFINITIONS ${SPEEX_DEFINITIONS})

	list(APPEND CLIENT_DEFINITIONS "-DUSE_VOIP")
endif(USE_VOIP)

if(USE_FREETYPE)
	find_package(Freetype 2 REQUIRED)
	list(APPEND CLIENT_INCLUDE_DIRS ${FREETYPE_INCLUDE_DIRS})
	list(APPEND CLIENT_LIBRARIES ${FREETYPE_LIBRARIES})
	list(APPEND CLIENT_DEFINITIONS ${FREETYPE_DEFINITIONS})

	list(APPEND CLIENT_DEFINITIONS "-DBUILD_FREETYPE")
endif(USE_FREETYPE)

#required for l_precomp.c and l_script.c
list(APPEND CLIENT_DEFINITIONS "-DBOTLIB")

if(USE_CURL)
	if(USE_LOCAL_HEADERS AND CURL_FOUND)
		list(APPEND CURL_INCLUDE_DIRS "${CURL_DIR}")
	endif()

	if(NOT CURL_FOUND)
		find_package(CURL REQUIRED)
	endif(NOT CURL_FOUND)

	list(APPEND CLIENT_INCLUDE_DIRS ${CURL_INCLUDE_DIRS})
	list(APPEND CLIENT_LIBRARIES ${CURL_LIBRARIES})
	list(APPEND CLIENT_DEFINITIONS ${CURL_DEFINITIONS})

	list(APPEND CLIENT_DEFINITIONS "-DUSE_CURL")
	if(USE_CURL_DLOPEN)
		list(APPEND CLIENT_DEFINITIONS "-DUSE_CURL_DLOPEN")
	endif(USE_CURL_DLOPEN)
endif(USE_CURL)

if(USE_ICON)
	list(APPEND CLIENT_DEFINITIONS "-DUSE_ICON")
endif(USE_ICON)

if(USE_LOCAL_HEADERS)
	list(APPEND CLIENT_DEFINITIONS "-DUSE_LOCAL_HEADERS")
endif(USE_LOCAL_HEADERS)

if(USE_OPENAL)
	list(APPEND CLIENT_DEFINITIONS "-DUSE_OPENAL")
	if(USE_OPENAL_DLOPEN)
		list(APPEND CLIENT_DEFINITIONS "-DUSE_OPENAL_DLOPEN")
	endif(USE_OPENAL_DLOPEN)
endif(USE_OPENAL)

if(USE_RENDERER_DLOPEN)
	list(APPEND CLIENT_DEFINITIONS "-DUSE_RENDERER_DLOPEN")
endif(USE_RENDERER_DLOPEN)

if(BUILD_STANDALONE)
	list(APPEND CLIENT_DEFINITIONS "-DSTANDALONE")
endif(BUILD_STANDALONE)


enable_language(ASM)
enable_language(ASM_MASM)

set(MASM_SUBDIR "${CMAKELIST_DIR}/client/internal_masm")

if(NOT DEFINED HAVE_MASM_COMPILER)
	try_compile(HAVE_MASM_COMPILER "${CMAKE_CURRENT_BINARY_DIR}/try_masm" "${MASM_SUBDIR}" "internal_client_masm")
endif()

if(NOT BUILD_CLIENT)
	message("HAVE_MASM_COMPILER=${HAVE_MASM_COMPILER}")
endif()

if(HAVE_MASM_COMPILER AND (ARCH STREQUAL "x86" OR ARCH STREQUAL "x86_64"))
	include("${CMAKELIST_DIR}/include/internal_masm.cmake")
#	add_subdirectory("${MASM_SUBDIR}")
	list(APPEND CLIENT_LIBRARIES "${MASM_TARGET}")
else()
	set(INLINE_ASM_SUBDIR "${CMAKELIST_DIR}/client/internal_inline_asm")

	if(NOT DEFINED HAVE_INLINE_ASM_COMPILER)
		try_compile(HAVE_INLINE_ASM_COMPILER "${CMAKE_CURRENT_BINARY_DIR}/try_inline_asm" "${INLINE_ASM_SUBDIR}" "internal_inline_asm")
	endif()

	if(NOT BUILD_CLIENT)
		message("HAVE_INLINE_ASM_COMPILER=${HAVE_INLINE_ASM_COMPILER}")
	endif()

	if(HAVE_INLINE_ASM_COMPILER)
		include("${CMAKELIST_DIR}/include/internal_inline_asm.cmake")
#		add_subdirectory("${INLINE_ASM_SUBDIR}")
		list(APPEND CLIENT_LIBRARIES "${INLINE_ASM_TARGET}")
	endif()

endif()

set(CLIENT_ASM_SUBDIR "${CMAKELIST_DIR}/client/internal_asm")

if(NOT DEFINED HAVE_ASM_COMPILER)
	try_compile(HAVE_ASM_COMPILER "${CMAKE_CURRENT_BINARY_DIR}/try_client_asm" "${CLIENT_ASM_SUBDIR}" "internal_client_asm")
endif()

message("HAVE_ASM_COMPILER=${HAVE_ASM_COMPILER}")

if(HAVE_ASM_COMPILER AND ARCH STREQUAL "x86") #not for x86_64
	include("${CMAKELIST_DIR}/include/internal_client_asm.cmake")
#	add_subdirectory("${CLIENT_ASM_SUBDIR}")
	list(APPEND CLIENT_LIBRARIES "${CLIENT_ASM_TARGET}")
else()

endif()


#TODO: let cmake handle this for q_platform.h

math(EXPR BITS "${CMAKE_SIZEOF_VOID_P} * 8")
if(MSVC)
#	list(APPEND CLIENT_DEFINITIONS "-DOS_STRING=\"win_msvc${BITS}\"")
elseif(MINGW)
#	list(APPEND CLIENT_DEFINITIONS "-DOS_STRING=\"win_mingw${BITS}\"")
else()
#	list(APPEND CLIENT_DEFINITIONS "-DOS_STRING=\"${CMAKE_SYSTEM_NAME}\"")
endif()

TEST_BIG_ENDIAN(BIG_ENDIAN)
if(BIG_ENDIAN)
#	list(APPEND CLIENT_DEFINITIONS "-DQ3_BIG_ENDIAN")
else()
#	list(APPEND CLIENT_DEFINITIONS "-DQ3_LITTLE_ENDIAN")
endif()
#	list(APPEND CLIENT_DEFINITIONS "-DARCH_STRING=\"${ARCH}\"")

CHECK_C_SOURCE_COMPILES("int __cdecl foo(int x) {return x;}; int main() {return foo(0);}" HAVE_CDECL)
if(HAVE_CDECL)
#	list(APPEND CLIENT_DEFINITIONS "-DQDECL=__cdecl")
endif(HAVE_CDECL)

CHECK_C_SOURCE_COMPILES("int __stdcall foo(int x) {return x;}; int main() {return foo(0);}" HAVE_STDCALL)
if(HAVE_STDCALL)
#	list(APPEND CLIENT_DEFINITIONS "-DQCALL=__stdcall")
endif(HAVE_STDCALL)

#list(APPEND CLIENT_DEFINITIONS "-DDLL_EXT=\"${CMAKE_SHARED_LIBRARY_SUFFIX}\"")
#message("DLL_EXT=CMAKE_SHARED_LIBRARY_SUFFIX=${CMAKE_SHARED_LIBRARY_SUFFIX}")

CHECK_C_SOURCE_COMPILES("inline int foo(int x) {return x;}; int main() {return foo(0);}" HAVE_INLINE_FUNC)
if(HAVE_INLINE_FUNC)
#	list(APPEND CLIENT_DEFINITIONS "-DID_INLINE=inline")
endif(HAVE_INLINE_FUNC)

CHECK_C_SOURCE_COMPILES("__inline int foo(int x) {return x;}; int main() {return foo(0);}" HAVE_MSINLINE_FUNC)
if(HAVE_MSINLINE_FUNC AND NOT HAVE_INLINE_FUNC)
#	list(APPEND CLIENT_DEFINITIONS "-DID_INLINE=__inline")
endif()

file(TO_NATIVE_PATH "/" PATH_SEP)
#list(APPEND CLIENT_DEFINITIONS "-DPATH_SEP='${PATH_SEP}'")


list(APPEND CLIENT_C_SOURCES ${SDL_SOURCES} ${ASM_SOURCES} ${SERVER_SOURCES} ${BOTLIB_SOURCES} ${QCOMMON_SOURCES} ${CLIENT_SOURCES} ${SYS_SOURCES})

list(APPEND CLIENT_C_HEADERS ${SDL_HEADERS} ${ASM_HEADERS} ${SERVER_HEADERS} ${BOTLIB_HEADERS} ${QCOMMON_HEADERS} ${CLIENT_HEADERS} ${SYS_HEADERS})

#IDE grouping
source_group("asm\\Source Files" FILES ${ASM_SOURCES})
source_group("asm\\Header Files" FILES ${ASM_HEADERS})
source_group("botlib\\Source Files" FILES ${BOTLIB_SOURCES})
source_group("botlib\\Header Files" FILES ${BOTLIB_HEADERS})
source_group("client\\Source Files" FILES ${CLIENT_SOURCES})
source_group("client\\Header Files" FILES ${CLIENT_HEADERS})
source_group("libsdl\\Header Files" FILES ${LIBSDL_HEADERS})
source_group("mumble" FILES ${CLIENT_MUMBLE_SOURCES})
source_group("qcommon\\Source Files" FILES ${QCOMMON_SOURCES})
source_group("qcommon\\Header Files" FILES ${QCOMMON_HEADERS})
source_group("server\\Source Files" FILES ${SERVER_SOURCES})
source_group("server\\Header Files" FILES ${SERVER_HEADERS})
source_group("sys\\Source Files" FILES ${SYS_SOURCES} ${SYS_RC_SOURCES})
source_group("sys\\Header Files" FILES ${SYS_HEADERS})
source_group("sdl\\Source Files" FILES ${SDL_SOURCES})
source_group("sdl\\Header Files" FILES ${SDL_HEADERS})

add_executable("${CLIENT_TARGET}" ${CLIENT_C_SOURCES} ${CLIENT_C_HEADERS} ${SYS_RC_SOURCES})

set_target_properties("${CLIENT_TARGET}" PROPERTIES OUTPUT_NAME "${CLIENT_BIN}${BIN_EXT}")

target_include_directories("${CLIENT_TARGET}" PRIVATE ${CLIENT_INCLUDE_DIRS})

target_compile_definitions("${CLIENT_TARGET}" PRIVATE ${CLIENT_DEFINITIONS})

target_compile_options("${CLIENT_TARGET}" PRIVATE ${CLIENT_CFLAGS})

target_link_libraries("${CLIENT_TARGET}" ${CLIENT_LIBRARIES})

#TODO: use target_link_options? doesn't exist yet
#use LINK_OPTIONS instead of LINK_FLAGS for lists when its available and supports targets
string(REPLACE ";" " " CLIENT_LDFLAGS_STRING "${CLIENT_LDFLAGS}")
set_target_properties("${CLIENT_TARGET}" PROPERTIES LINK_FLAGS "${CLIENT_LDFLAGS_STRING}")

set(RENDERERGL1_SUBDIR "${CMAKELIST_DIR}/renderergl1")
if(NOT EXISTS "${RENDERERGL1_SUBDIR}/CMakeLists.txt")
	message(WARNING "Could not find renderergl1 in: ${RENDERERGL1_SUBDIR}")
endif()
if(NOT USE_RENDERER_DLOPEN)
	add_subdirectory("${RENDERERGL1_SUBDIR}" "${CMAKE_CURRENT_BINARY_DIR}/renderergl1")
endif()

if(INSTALL_DIR)
	install(TARGETS "${CLIENT_TARGET}" DESTINATION "${INSTALL_DIR}")
endif(INSTALL_DIR)
