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

project("missionpack game vm")

set(GAME_TARGET "missionpack_game_vm")

set(SOURCE_DIR "${CMAKE_CURRENT_LIST_DIR}/../../../../..")
set(CMAKELIST_DIR "${SOURCE_DIR}/misc/CMakeLists")

include("${CMAKELIST_DIR}/include/directory_constants.cmake")
include("${CMAKELIST_DIR}/include/default_options.cmake")
include("${CMAKELIST_DIR}/include/platform.cmake")

include("${CMAKELIST_DIR}/include/cmake_compatibility.cmake")

option(GENERATE_DEPENDENCIES "Preprocessing: Generate dependencies for make outputting" ${DEFAULT_GENERATE_DEPENDENCIES})
set(MISSIONPACK_VM_INSTALL_DIR "${DEFAULT_MISSIONPACK_VM_INSTALL_DIR}" CACHE PATH "Installation directory")


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
set(GAME_SOURCES 
	"${GAME_DIR}/ai_chat.c"
	"${GAME_DIR}/ai_cmd.c"
	"${GAME_DIR}/ai_dmnet.c"
	"${GAME_DIR}/ai_dmq3.c"
	"${GAME_DIR}/ai_main.c"
	"${GAME_DIR}/ai_team.c"
	"${GAME_DIR}/ai_vcmd.c"

	"${GAME_DIR}/bg_misc.c"
	"${GAME_DIR}/bg_pmove.c"
	"${GAME_DIR}/bg_slidemove.c"
	"${GAME_DIR}/bg_lib.c"

	"${GAME_DIR}/g_active.c"
	"${GAME_DIR}/g_arenas.c"
	"${GAME_DIR}/g_bot.c"
	"${GAME_DIR}/g_client.c"
	"${GAME_DIR}/g_cmds.c"
	"${GAME_DIR}/g_combat.c"
	"${GAME_DIR}/g_items.c"
	"${GAME_DIR}/g_main.c"
	"${GAME_DIR}/g_mem.c"
	"${GAME_DIR}/g_misc.c"
	"${GAME_DIR}/g_missile.c"
	"${GAME_DIR}/g_mover.c"
	"${GAME_DIR}/g_session.c"
	"${GAME_DIR}/g_spawn.c"
	"${GAME_DIR}/g_svcmds.c"
	"${GAME_DIR}/g_target.c"
	"${GAME_DIR}/g_team.c"
	"${GAME_DIR}/g_trigger.c"
	"${GAME_DIR}/g_utils.c"
	"${GAME_DIR}/g_weapon.c"

	"${GAME_DIR}/g_syscalls.c"
)
set(GAME_HEADERS 
	"${GAME_DIR}/ai_chat.h"
	"${GAME_DIR}/ai_cmd.h"
	"${GAME_DIR}/ai_dmnet.h"
	"${GAME_DIR}/ai_dmq3.h"
	"${GAME_DIR}/ai_main.h"
	"${GAME_DIR}/ai_team.h"
	"${GAME_DIR}/ai_vcmd.h"
	"${GAME_DIR}/chars.h"
	"${GAME_DIR}/inv.h"
	"${GAME_DIR}/match.h"
	"${GAME_DIR}/syn.h"

	"${GAME_DIR}/bg_local.h"
	"${GAME_DIR}/bg_public.h"
	"${GAME_DIR}/bg_lib.h"

	"${GAME_DIR}/g_local.h"
	"${GAME_DIR}/g_public.h"

	"${GAME_DIR}/g_team.h"

)
set(QCOMMON_SOURCES 
	"${QCOMMON_DIR}/q_math.c"
	"${QCOMMON_DIR}/q_shared.c"
)
set(QCOMMON_HEADERS 
	"${QCOMMON_DIR}/q_shared.h"
)

set(GAME_DEFINITIONS)
set(GAME_LIBRARIES)
set(GAME_INCLUDE_DIRS)
set(GAME_LDFLAGS)
set(GAME_CFLAGS)
set(GAME_C_SOURCES)
set(GAME_C_HEADERS)


if(MSVC)

	#Character Set, CharacterSet="0", Not Set, ASCII/SBCS (Single Byte Character Set)
	list(APPEND GAME_DEFINITIONS "-D_SBCS")

	#no warnings about using old functions like strcmp
	list(APPEND GAME_DEFINITIONS "-D_CRT_SECURE_NO_WARNINGS")

endif(MSVC)

if(MINGW)


endif(MINGW)

if(CMAKE_COMPILER_IS_GNUCC)

	if(GENERATE_DEPENDENCIES)
		list(APPEND GAME_CFLAGS "-MMD")
	endif(GENERATE_DEPENDENCIES)

endif(CMAKE_COMPILER_IS_GNUCC)


#Add new platforms and compilers above this
###

list(APPEND GAME_DEFINITIONS "-DQAGAME")
list(APPEND GAME_DEFINITIONS "-DMISSIONPACK")



list(APPEND GAME_C_SOURCES ${GAME_SOURCES} ${QCOMMON_SOURCES})
list(APPEND GAME_C_HEADERS ${GAME_HEADERS} ${QCOMMON_HEADERS} ${BOTLIB_HEADERS})

source_group("botlib\\Header Files" FILES ${BOTLIB_HEADERS})
source_group("game\\Source Files" FILES ${GAME_SOURCES})
source_group("game\\Header Files" FILES ${GAME_HEADERS})
source_group("qcommon\\Source Files" FILES ${QCOMMON_SOURCES})
source_group("qcommon\\Header Files" FILES ${QCOMMON_HEADERS})

add_library("${GAME_TARGET}" MODULE ${GAME_C_SOURCES} ${GAME_C_HEADERS})

set_target_properties("${GAME_TARGET}" PROPERTIES OUTPUT_NAME "qagame${ARCH}")

target_include_directories("${GAME_TARGET}" PRIVATE ${GAME_INCLUDE_DIRS})

target_compile_definitions("${GAME_TARGET}" PRIVATE ${GAME_DEFINITIONS})

target_compile_options("${GAME_TARGET}" PRIVATE ${GAME_CFLAGS})

target_link_libraries("${GAME_TARGET}" ${GAME_LIBRARIES})

string(REPLACE ";" " " GAME_LDFLAGS_STRING "${GAME_LDFLAGS}")
set_target_properties("${GAME_TARGET}" PROPERTIES LINK_FLAGS "${GAME_LDFLAGS_STRING}")

if(MISSIONPACK_VM_INSTALL_DIR)
	install(TARGETS "${GAME_TARGET}" DESTINATION "${MISSIONPACK_VM_INSTALL_DIR}")
endif(MISSIONPACK_VM_INSTALL_DIR)
