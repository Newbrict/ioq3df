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

project("missionpack cgame vm")

set(CGAME_TARGET "missionpack_cgame_vm")

set(SOURCE_DIR "${CMAKE_CURRENT_LIST_DIR}/../../../../..")
set(CMAKELIST_DIR "${SOURCE_DIR}/misc/CMakeLists")

include("${CMAKELIST_DIR}/include/directory_constants.cmake")
include("${CMAKELIST_DIR}/include/default_options.cmake")
include("${CMAKELIST_DIR}/include/platform.cmake")

include("${CMAKELIST_DIR}/include/cmake_compatibility.cmake")

option(GENERATE_DEPENDENCIES "Preprocessing: Generate dependencies for make outputting" ${DEFAULT_GENERATE_DEPENDENCIES})
set(MISSIONPACK_VM_INSTALL_DIR "${DEFAULT_MISSIONPACK_VM_INSTALL_DIR}" CACHE PATH "Installation directory")


set(CGAME_SOURCES 
	"${CGAME_DIR}/cg_consolecmds.c"
	"${CGAME_DIR}/cg_draw.c"
	"${CGAME_DIR}/cg_drawtools.c"
	"${CGAME_DIR}/cg_effects.c"
	"${CGAME_DIR}/cg_ents.c"
	"${CGAME_DIR}/cg_event.c"
	"${CGAME_DIR}/cg_info.c"
	"${CGAME_DIR}/cg_localents.c"
	"${CGAME_DIR}/cg_main.c"
	"${CGAME_DIR}/cg_marks.c"
	"${CGAME_DIR}/cg_newdraw.c"
	"${CGAME_DIR}/cg_particles.c"
	"${CGAME_DIR}/cg_players.c"
	"${CGAME_DIR}/cg_playerstate.c"
	"${CGAME_DIR}/cg_predict.c"
	"${CGAME_DIR}/cg_scoreboard.c"
	"${CGAME_DIR}/cg_servercmds.c"
	"${CGAME_DIR}/cg_snapshot.c"
	"${CGAME_DIR}/cg_view.c"
	"${CGAME_DIR}/cg_weapons.c"

	"${CGAME_DIR}/cg_syscalls.c"
)
set(CGAME_HEADERS 
	"${CGAME_DIR}/cg_local.h"
	"${CGAME_DIR}/cg_public.h"
)
set(GAME_SOURCES 
	"${GAME_DIR}/bg_misc.c"
	"${GAME_DIR}/bg_pmove.c"
	"${GAME_DIR}/bg_slidemove.c"
	"${GAME_DIR}/bg_lib.c"
)
set(GAME_HEADERS 
	"${GAME_DIR}/bg_local.h"
	"${GAME_DIR}/bg_public.h"
	"${GAME_DIR}/bg_lib.h"
)
set(UI_SOURCES 
	"${UI_DIR}/ui_shared.c"
)
set(UI_HEADERS 
	"${UI_DIR}/ui_shared.h"
)
set(QCOMMON_SOURCES 
	"${QCOMMON_DIR}/q_math.c"
	"${QCOMMON_DIR}/q_shared.c"
)
set(QCOMMON_HEADERS 
	"${QCOMMON_DIR}/q_shared.h"
)

set(CGAME_DEFINITIONS)
set(CGAME_LIBRARIES)
set(CGAME_INCLUDE_DIRS)
set(CGAME_LDFLAGS)
set(CGAME_CFLAGS)
set(CGAME_C_SOURCES)
set(CGAME_C_HEADERS)


if(MSVC)

	#Character Set, CharacterSet="0", Not Set, ASCII/SBCS (Single Byte Character Set)
	list(APPEND CGAME_DEFINITIONS "-D_SBCS")

	#no warnings about using old functions like strcmp
	list(APPEND CGAME_DEFINITIONS "-D_CRT_SECURE_NO_WARNINGS")

endif(MSVC)

if(MINGW)


endif(MINGW)

if(CMAKE_COMPILER_IS_GNUCC)

	if(GENERATE_DEPENDENCIES)
		list(APPEND CGAME_CFLAGS "-MMD")
	endif(GENERATE_DEPENDENCIES)

endif(CMAKE_COMPILER_IS_GNUCC)


#Add new platforms and compilers above this
###

list(APPEND CGAME_DEFINITIONS "-DCGAME")
list(APPEND CGAME_DEFINITIONS "-DMISSIONPACK")



list(APPEND CGAME_C_SOURCES ${CGAME_SOURCES} ${GAME_SOURCES} ${UI_SOURCES} ${QCOMMON_SOURCES})
list(APPEND CGAME_C_HEADERS ${CGAME_HEADERS} ${GAME_HEADERS} ${UI_HEADERS} ${QCOMMON_HEADERS})

source_group("cgame\\Source Files" FILES ${CGAME_SOURCES})
source_group("cgame\\Header Files" FILES ${CGAME_HEADERS})
source_group("game\\Source Files" FILES ${GAME_SOURCES})
source_group("game\\Header Files" FILES ${GAME_HEADERS})
source_group("ui\\Source Files" FILES ${UI_SOURCES})
source_group("ui\\Header Files" FILES ${UI_HEADERS})
source_group("qcommon\\Source Files" FILES ${QCOMMON_SOURCES})
source_group("qcommon\\Header Files" FILES ${QCOMMON_HEADERS})


add_library("${CGAME_TARGET}" MODULE ${CGAME_C_SOURCES} ${CGAME_C_HEADERS})

set_target_properties("${CGAME_TARGET}" PROPERTIES OUTPUT_NAME "cgame${ARCH}")

target_include_directories("${CGAME_TARGET}" PRIVATE ${CGAME_INCLUDE_DIRS})

target_compile_definitions("${CGAME_TARGET}" PRIVATE ${CGAME_DEFINITIONS})

target_compile_options("${CGAME_TARGET}" PRIVATE ${CGAME_CFLAGS})

target_link_libraries("${CGAME_TARGET}" ${CGAME_LIBRARIES})

string(REPLACE ";" " " CGAME_LDFLAGS_STRING "${CGAME_LDFLAGS}")
set_target_properties("${CGAME_TARGET}" PROPERTIES 	LINK_FLAGS "${CGAME_LDFLAGS_STRING}")

if(MISSIONPACK_VM_INSTALL_DIR)
	install(TARGETS "${CGAME_TARGET}" DESTINATION "${MISSIONPACK_VM_INSTALL_DIR}")
endif(MISSIONPACK_VM_INSTALL_DIR)
