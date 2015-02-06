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

project("missionpack game qvm")

set(GAME_TARGET "missionpack_game_qvm")

set(SOURCE_DIR "${CMAKE_CURRENT_LIST_DIR}/../../../../..")
set(CMAKELIST_DIR "${SOURCE_DIR}/misc/CMakeLists")

include("${CMAKELIST_DIR}/include/directory_constants.cmake")
include("${CMAKELIST_DIR}/include/default_options.cmake")
include("${CMAKELIST_DIR}/include/qvm_tools.cmake")
include("${CMAKELIST_DIR}/include/qvm_options.cmake")

include("${CMAKELIST_DIR}/include/cmake_compatibility.cmake")


set(MISSIONPACK_QVM_INSTALL_DIR "${DEFAULT_MISSIONPACK_QVM_INSTALL_DIR}" CACHE PATH "Installation directory")


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
	"${GAME_DIR}/g_main.c"

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

#	"${GAME_DIR}/g_syscalls.c"
)
set(GAME_ASM_SOURCES 
	"${GAME_DIR}/g_syscalls.asm"
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


list(APPEND GAME_DEFINITIONS "-DQAGAME")
list(APPEND GAME_DEFINITIONS "-DQ3_VM")
list(APPEND GAME_DEFINITIONS "-DMISSIONPACK")

list(APPEND GAME_C_SOURCES ${GAME_SOURCES} ${QCOMMON_SOURCES})
list(APPEND GAME_C_HEADERS ${GAME_HEADERS} ${QCOMMON_HEADERS} ${BOTLIB_HEADERS})

source_group("botlib\\Header Files" FILES ${BOTLIB_HEADERS})
source_group("game\\Source Files" FILES ${GAME_SOURCES})
source_group("game\\Header Files" FILES ${GAME_HEADERS})
source_group("game" FILES ${GAME_ASM_SOURCES})
source_group("qcommon\\Source Files" FILES ${QCOMMON_SOURCES})
source_group("qcommon\\Header Files" FILES ${QCOMMON_HEADERS})


set(QVM_FILENAME "${CMAKE_CURRENT_BINARY_DIR}/qagame.qvm")

add_library("${GAME_TARGET}" STATIC ${GAME_C_SOURCES} ${GAME_C_HEADERS} ${GAME_ASM_SOURCES} "${QVM_FILENAME}")

set(ASM_DIRNAME "asm${CMAKE_BUILD_TYPE}")
file(MAKE_DIRECTORY "${CMAKE_CURRENT_BINARY_DIR}/${ASM_DIRNAME}")

set(GAME_ASM_FILES)

foreach(SOURCE ${GAME_C_SOURCES})
	get_filename_component(BASE_FILENAME "${SOURCE}" NAME_WE)
	set(ASM_FILENAME "${CMAKE_CURRENT_BINARY_DIR}/${ASM_DIRNAME}/${BASE_FILENAME}.asm")

	add_custom_command(OUTPUT "${ASM_FILENAME}"
		COMMAND "$<TARGET_FILE:${Q3LCC_TARGET}>" ARGS ${Q3LCC_OPTIIONS} ${Q3LCC_VERBOSE_OPTION} ${GAME_DEFINITIONS} -o "${ASM_FILENAME}" "${SOURCE}" -Wo-lrccdir=$<TARGET_FILE_DIR:${Q3RCC_TARGET}> -Wo-lcppdir=$<TARGET_FILE_DIR:${Q3CPP_TARGET}> -I${GAME_DIR} -I${GAME_DIR} -I${QCOMMON_DIR}
		DEPENDS "${SOURCE}"
	)
	list(APPEND GAME_ASM_FILES "${ASM_FILENAME}")
	set_source_files_properties("${SOURCE}" PROPERTIES HEADER_FILE_ONLY TRUE)
endforeach()

foreach(SOURCE ${GAME_ASM_SOURCES})
	set_source_files_properties("${SOURCE}" PROPERTIES HEADER_FILE_ONLY TRUE)
endforeach()

set(SOURCES ${GAME_ASM_FILES} ${GAME_ASM_SOURCES})

add_custom_command(OUTPUT "${QVM_FILENAME}"
	COMMAND "$<TARGET_FILE:${Q3ASM_TARGET}>" ${Q3CPP_OPTIIONS} ${Q3CPP_VERBOSE_OPTION} ${VQ3_OPTION} -o "${QVM_FILENAME}" ${SOURCES}
	DEPENDS ${SOURCES}
)

if(MISSIONPACK_QVM_INSTALL_DIR)
	install(FILES "${QVM_FILENAME}" DESTINATION "${MISSIONPACK_QVM_INSTALL_DIR}")
endif(MISSIONPACK_QVM_INSTALL_DIR)
