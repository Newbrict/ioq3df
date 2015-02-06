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

project("server")

set(SERVER_TARGET "server")

set(SOURCE_DIR "${CMAKE_CURRENT_LIST_DIR}/../../..")
set(CMAKELIST_DIR "${SOURCE_DIR}/misc/CMakeLists")

include("${CMAKELIST_DIR}/include/directory_constants.cmake")
include("${CMAKELIST_DIR}/include/default_options.cmake")
include("${CMAKELIST_DIR}/include/platform.cmake")
include(CheckCCompilerFlag RESULT_VARIABLE MODULE_CHECKCCOMPILERFLAG_EXISTS)
include(CheckCSourceCompiles RESULT_VARIABLE MODULE_CHECKCSOURCECOMPILES_EXISTS)
include(CheckIncludeFile RESULT_VARIABLE MODULE_CHECKINCLUDEFILE_EXISTS)
include("${CMAKELIST_DIR}/include/cmake_compatibility.cmake")


#cmake does append any extensions
set(SERVER_BIN "${DEFAULT_SERVER_BIN}" CACHE STRING "binary/executable name")

#Note: options and build directories get cached
option(USE_INTERNAL_LIBS "Use internal libraries (zlib)" ${DEFAULT_USE_INTERNAL_LIBS})
option(USE_INTERNAL_ZLIB "Use internal zlib" ${USE_INTERNAL_LIBS})
option(USE_LOCAL_HEADERS "Use local headers" ${USE_INTERNAL_LIBS})

option(USE_ICON "Use window icon" ${DEFAULT_USE_ICON})

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

set(ASM_C_SOURCES 
	"${ASM_DIR}/ftola.c"
	"${ASM_DIR}/snapvector.c"
)

set(ASM_MASM_SOURCES 
	"${ASM_DIR}/ftola.asm"
	"${ASM_DIR}/snapvector.asm"
#	"${ASM_DIR}/vm_x86_64.asm"
)

set(ASM_S_SOURCES 
	"${ASM_DIR}/matha.s"
#	"${ASM_DIR}/snd_mixa.s"
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
set(NULL_SOURCES 
	"${NULL_DIR}/null_client.c"
	"${NULL_DIR}/null_input.c"
	"${NULL_DIR}/null_snddma.c"
)
set(NULL_HEADERS 
)
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


CHECK_INCLUDE_FILE("dlfcn.h" HAVE_DLFCN_H)
if(HAVE_DLFCN_H)
	list(APPEND SERVER_DEFINITIONS "-DHAVE_DLFCN_H")
endif(HAVE_DLFCN_H)

set(CMAKE_REQUIRED_LIBRARIES ${CMAKE_DL_LIBS})
CHECK_C_SOURCE_COMPILES("#include <dlfcn.h>\n int main () {void *dl = dlopen(\"libm.so\", RTLD_NOW);return 0;}" HAVE_DLOPEN_IN_DLFCN_H)
set(CMAKE_REQUIRED_LIBRARIES)
if(HAVE_DLOPEN_IN_DLFCN_H)
	list(APPEND SERVER_DEFINITIONS "-DHAVE_DLOPEN")
	list(APPEND SERVER_LIBRARIES ${CMAKE_DL_LIBS})
endif(HAVE_DLOPEN_IN_DLFCN_H)


if(MSVC)
	#time functions winmm.lib
	#EnumProcesses function psapi.lib
	#windows socket functions ws2_32.lib
	list(APPEND SERVER_LIBRARIES "winmm" "psapi" "ws2_32")

	#Enable String Pooling /GF
	list(APPEND SERVER_CFLAGS "/GF")
	#Enable Function-Level Linking /Gy
	list(APPEND SERVER_CFLAGS "/Gy")
	#Warning Level /W4
	list(APPEND SERVER_CFLAGS "/W4")
	#Floating Point Model /fp:fast
	list(APPEND SERVER_CFLAGS "/fp:fast")
	#Compile as, C Code /TC
	list(APPEND SERVER_CFLAGS "/TC")
	#Enable C++ Exceptions, No /EHa-
	list(APPEND SERVER_CFLAGS "/EHa-")
	#Whole program optimization, no /GL-
	list(APPEND SERVER_CFLAGS "/GL-")

	#Subsystem /SUBSYSTEM:CONSOLE
	list(APPEND SERVER_LDFLAGS "/SUBSYSTEM:CONSOLE")
	#Stack Reserve Size /STACK:8388608
	list(APPEND SERVER_LDFLAGS "/STACK:8388608")
	#Randomized Base Address /DYNAMICBASE:NO
	list(APPEND SERVER_LDFLAGS "/DYNAMICBASE:NO")
	#Data Execution Prevenbtion (DEP) /NXCOMPAT:NO
	list(APPEND SERVER_LDFLAGS "/NXCOMPAT:NO")
	#Image Has Safe Exception Handlers, is no longer default no in msvc 2013 /SAFESEH:NO
	list(APPEND SERVER_LDFLAGS "/SAFESEH:NO")
	#Disable specific warnings
#TODO
	#list(APPEND SERVER_CFLAGS "/wd4244")

	#Character Set, CharacterSet="0", Not Set, ASCII/SBCS (Single Byte Character Set)
	list(APPEND SERVER_DEFINITIONS "-D_SBCS")

	#no warnings about using old functions like strcmp
	list(APPEND SERVER_DEFINITIONS "-D_CRT_SECURE_NO_WARNINGS")

endif(MSVC)

if(MINGW)
	#need misc/../ for misc/quake3.ico in win_resource.rc
	list(APPEND SERVER_INCLUDE_DIRS "${SOURCE_DIR}")

	#need to link mingw before SDL
	list(APPEND SERVER_LIBRARIES "mingw32")

	#time functions winmm.lib
	#EnumProcesses function psapi.lib
	#socket functions ws2_32.lib
	#ImmGetIMEFileName imm32.lib
	#GetFileVersionInfoSize Version.lib
	list(APPEND SERVER_LIBRARIES "imm32" "Version" "winmm" "psapi" "ws2_32")


	list(APPEND BASE_CFLAGS "-Wall" "-fno-strict-aliasing" "-Wimplicit" "-Wstrict-prototypes")


	if(NOT DEFINED WINVER)
		if(${CMAKE_SYSTEM_VERSION} VERSION_EQUAL "5" OR ${CMAKE_SYSTEM_VERSION} VERSION_GREATER "5")
			list(APPEND SERVER_DEFINITIONS "-DWINVER=0x0501")
			set(WINVER_WARNING "Using Windows XP: -DWINVER=0x0501")
		endif()
		message(WARNING "WINVER not set for the target OS, related to the Platform Toolset in MSVC.\n"
			"0x0501 for Windows XP, 0x0502 for Windows Server 2003, 0x0600 for Windows Vista, 0x0601 for Windows 7, 0x0602 for Windows 8 and 0x603 for Windows 8.1.\n"
			"${WINVER_WARNING}")
	endif()

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
	list(APPEND SERVER_DEFINITIONS "-DMACOS_X")

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

	#matha.s
	set(USE_ASM TRUE)
#TODO
	list(APPEND SERVER_S_CFLAGS ${OPTIMIZE})
	list(APPEND SERVER_S_CFLAGS "-x" "assembler-with-cpp")
	#ftola.c snapvector.c
#	list(APPEND SERVER_INLINE_ASM_CFLAGS "-msse2")
#	list(APPEND SERVER_INLINE_ASM_CFLAGS "-msse")
	list(APPEND SERVER_INLINE_ASM_CFLAGS "-march=k8")


#TODO
	list(APPEND BASE_CFLAGS "-Wformat=2")
	list(APPEND BASE_CFLAGS "-Wno-format-zero-length")
	list(APPEND BASE_CFLAGS "-Wformat-security")
	list(APPEND BASE_CFLAGS "-Wno-format-nonliteral")
	list(APPEND BASE_CFLAGS "-Wstrict-aliasing=2")
	list(APPEND BASE_CFLAGS "-Wmissing-format-attribute")
	list(APPEND BASE_CFLAGS "-Wdisabled-optimization")
	list(APPEND BASE_CFLAGS "-Werror-implicit-function-declaration")

	if(GENERATE_DEPENDENCIES)
		list(APPEND SERVER_CFLAGS "-MMD")
	endif(GENERATE_DEPENDENCIES)

	list(APPEND SERVER_CFLAGS ${BASE_CFLAGS})

	if(CMAKE_BUILD_TYPE MATCHES "Release")
		list(APPEND SERVER_CFLAGS ${OPTIMIZE})
	elseif(CMAKE_BUILD_TYPE MATCHES "Debug")
		list(APPEND SERVER_DEFINITIONS "-DNDEBUG")
	endif()

endif(CMAKE_COMPILER_IS_GNUCC)


if(CMAKE_C_COMPILER_ID MATCHES "Clang")
	list(APPEND SERVER_CFLAGS "-Qunused-arguments")
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
list(APPEND SERVER_INCLUDE_DIRS "${SOURCE_DIR}/misc/msvc")

if(PRODUCT_VERSION)
	list(APPEND SERVER_DEFINITIONS "-DPRODUCT_VERSION=\"${PRODUCT_VERSION}\"")
endif(PRODUCT_VERSION)

if(USE_INTERNAL_ZLIB)
	include("${CMAKELIST_DIR}/include/internal_zlib.cmake")
else()
	find_package(ZLIB REQUIRED)
endif(USE_INTERNAL_ZLIB)

list(APPEND SERVER_INCLUDE_DIRS ${ZLIB_INCLUDE_DIRS})
list(APPEND SERVER_LIBRARIES ${ZLIB_LIBRARIES})
list(APPEND SERVER_DEFINITIONS ${ZLIB_DEFINITIONS})

if(USE_FREETYPE)
	find_package(Freetype 2 REQUIRED)
	list(APPEND SERVER_INCLUDE_DIRS ${FREETYPE_INCLUDE_DIRS})
	list(APPEND SERVER_LIBRARIES ${FREETYPE_LIBRARIES})
	list(APPEND SERVER_DEFINITIONS ${FREETYPE_DEFINITIONS})

	list(APPEND SERVER_DEFINITIONS "-DBUILD_FREETYPE")
endif(USE_FREETYPE)

list(APPEND SERVER_DEFINITIONS "-DBOTLIB")
list(APPEND SERVER_DEFINITIONS "-DDEDICATED")

if(USE_ICON)
	list(APPEND SERVER_DEFINITIONS "-DUSE_ICON")
endif(USE_ICON)

if(USE_LOCAL_HEADERS)
	list(APPEND SERVER_DEFINITIONS "-DUSE_LOCAL_HEADERS")
endif(USE_LOCAL_HEADERS)

if(BUILD_STANDALONE)
	list(APPEND SERVER_DEFINITIONS "-DSTANDALONE")
endif(BUILD_STANDALONE)


enable_language(ASM_MASM)

set(MASM_SUBDIR "${CMAKELIST_DIR}/server/internal_masm")

if(NOT DEFINED HAVE_MASM_COMPILER)
	try_compile(HAVE_MASM_COMPILER "${CMAKE_CURRENT_BINARY_DIR}/try_masm" "${MASM_SUBDIR}" "internal_server_masm")
endif()

message("HAVE_MASM_COMPILER=${HAVE_MASM_COMPILER}")

if(HAVE_MASM_COMPILER AND (ARCH STREQUAL "x86" OR ARCH STREQUAL "x86_64"))
	include("${CMAKELIST_DIR}/include/internal_masm.cmake")
#	add_subdirectory("${MASM_SUBDIR}")
	list(APPEND SERVER_LIBRARIES "${MASM_TARGET}")
else()
	set(INLINE_ASM_SUBDIR "${CMAKELIST_DIR}/server/internal_inline_asm")

	if(NOT DEFINED HAVE_INLINE_ASM_COMPILER)
		try_compile(HAVE_INLINE_ASM_COMPILER "${CMAKE_CURRENT_BINARY_DIR}/try_inline_asm" "${INLINE_ASM_SUBDIR}" "internal_inline_asm")
	endif()

	message("HAVE_INLINE_ASM_COMPILER=${HAVE_INLINE_ASM_COMPILER}")

	if(HAVE_INLINE_ASM_COMPILER)
		include("${CMAKELIST_DIR}/include/internal_inline_asm.cmake")
#		add_subdirectory("${INLINE_ASM_SUBDIR}")
		list(APPEND SERVER_LIBRARIES "${INLINE_ASM_TARGET}")
	endif()
endif()


list(APPEND SERVER_C_SOURCES ${NULL_SOURCES} ${ASM_SOURCES} ${SERVER_SOURCES} ${BOTLIB_SOURCES} ${QCOMMON_SOURCES} ${SYS_SOURCES})

list(APPEND SERVER_C_HEADERS ${NULL_HEADERS} ${ASM_HEADERS} ${SERVER_HEADERS} ${BOTLIB_HEADERS} ${QCOMMON_HEADERS} ${SYS_HEADERS})

#IDE grouping
source_group("asm\\Source Files" FILES ${ASM_SOURCES})
source_group("asm\\Header Files" FILES ${ASM_HEADERS})
source_group("botlib\\Source Files" FILES ${BOTLIB_SOURCES})
source_group("botlib\\Header Files" FILES ${BOTLIB_HEADERS})
source_group("qcommon\\Source Files" FILES ${QCOMMON_SOURCES})
source_group("qcommon\\Header Files" FILES ${QCOMMON_HEADERS})
source_group("server\\Source Files" FILES ${SERVER_SOURCES})
source_group("server\\Header Files" FILES ${SERVER_HEADERS})
source_group("sys\\Source Files" FILES ${SYS_SOURCES} ${SYS_RC_SOURCES})
source_group("sys\\Header Files" FILES ${SYS_HEADERS})

add_executable("${SERVER_TARGET}" ${SERVER_C_SOURCES} ${SERVER_C_HEADERS} ${SYS_RC_SOURCES})

set_target_properties("${SERVER_TARGET}" PROPERTIES OUTPUT_NAME "${SERVER_BIN}${BIN_EXT}")

target_include_directories("${SERVER_TARGET}" PRIVATE ${SERVER_INCLUDE_DIRS})

target_compile_definitions("${SERVER_TARGET}" PRIVATE ${SERVER_DEFINITIONS})

target_compile_options("${SERVER_TARGET}" PRIVATE ${SERVER_CFLAGS})

target_link_libraries("${SERVER_TARGET}" ${SERVER_LIBRARIES})

string(REPLACE ";" " " SERVER_LDFLAGS_STRING "${SERVER_LDFLAGS}")
set_target_properties("${SERVER_TARGET}" PROPERTIES LINK_FLAGS "${SERVER_LDFLAGS_STRING}")

if(INSTALL_DIR)
	install(TARGETS "${SERVER_TARGET}" DESTINATION "${INSTALL_DIR}")
endif(INSTALL_DIR)
