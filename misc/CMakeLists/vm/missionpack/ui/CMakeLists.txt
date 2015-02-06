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

project("missionpack ui vm")

set(UI_TARGET "missionpack_ui_vm")

set(SOURCE_DIR "${CMAKE_CURRENT_LIST_DIR}/../../../../..")
set(CMAKELIST_DIR "${SOURCE_DIR}/misc/CMakeLists")

include("${CMAKELIST_DIR}/include/directory_constants.cmake")
include("${CMAKELIST_DIR}/include/default_options.cmake")
include("${CMAKELIST_DIR}/include/platform.cmake")

include("${CMAKELIST_DIR}/include/cmake_compatibility.cmake")

option(GENERATE_DEPENDENCIES "Preprocessing: Generate dependencies for make outputting" ${DEFAULT_GENERATE_DEPENDENCIES})
set(MISSIONPACK_VM_INSTALL_DIR "${DEFAULT_MISSIONPACK_VM_INSTALL_DIR}" CACHE PATH "Installation directory")


set(GAME_SOURCES 
	"${GAME_DIR}/bg_misc.c"
	"${GAME_DIR}/bg_lib.c"
)
set(GAME_HEADERS 
	"${GAME_DIR}/bg_local.h"
	"${GAME_DIR}/bg_public.h"
	"${GAME_DIR}/bg_lib.h"
)
set(UI_SOURCES 
	"${UI_DIR}/ui_atoms.c"
	"${UI_DIR}/ui_main.c"
	"${UI_DIR}/ui_gameinfo.c"
	"${UI_DIR}/ui_players.c"
	"${UI_DIR}/ui_shared.c"

	"${UI_DIR}/ui_syscalls.c"
)
set(UI_HEADERS 
	"${UI_DIR}/ui_local.h"
	"${UI_DIR}/ui_public.h"

	"${UI_DIR}/ui_shared.h"

)
set(QCOMMON_SOURCES 
	"${QCOMMON_DIR}/q_math.c"
	"${QCOMMON_DIR}/q_shared.c"
)
set(QCOMMON_HEADERS 
	"${QCOMMON_DIR}/q_shared.h"
)

set(UI_DEFINITIONS)
set(UI_LIBRARIES)
set(UI_INCLUDE_DIRS)
set(UI_LDFLAGS)
set(UI_CFLAGS)
set(UI_C_SOURCES)
set(UI_C_HEADERS)


if(MSVC)

	#Character Set, CharacterSet="0", Not Set, ASCII/SBCS (Single Byte Character Set)
	list(APPEND UI_DEFINITIONS "-D_SBCS")

	#no warnings about using old functions like strcmp
	list(APPEND UI_DEFINITIONS "-D_CRT_SECURE_NO_WARNINGS")

endif(MSVC)

if(MINGW)


endif(MINGW)

if(CMAKE_COMPILER_IS_GNUCC)

	if(GENERATE_DEPENDENCIES)
		list(APPEND UI_CFLAGS "-MMD")
	endif(GENERATE_DEPENDENCIES)

endif(CMAKE_COMPILER_IS_GNUCC)


#Add new platforms and compilers above this
###

list(APPEND GAME_DEFINITIONS "-DUI")
list(APPEND UI_DEFINITIONS "-DMISSIONPACK")



list(APPEND UI_C_SOURCES ${UI_SOURCES} ${GAME_SOURCES} ${QCOMMON_SOURCES})
list(APPEND UI_C_HEADERS ${UI_HEADERS} ${GAME_HEADERS} ${QCOMMON_HEADERS})

source_group("game\\Source Files" FILES ${GAME_SOURCES})
source_group("game\\Header Files" FILES ${GAME_HEADERS})
source_group("ui\\Source Files" FILES ${UI_SOURCES})
source_group("ui\\Header Files" FILES ${UI_HEADERS})
source_group("qcommon\\Source Files" FILES ${QCOMMON_SOURCES})
source_group("qcommon\\Header Files" FILES ${QCOMMON_HEADERS})

add_library("${UI_TARGET}" MODULE ${UI_C_SOURCES} ${UI_C_HEADERS})

set_target_properties("${UI_TARGET}" PROPERTIES OUTPUT_NAME "ui${ARCH}")

target_include_directories("${UI_TARGET}" PRIVATE ${UI_INCLUDE_DIRS})

target_compile_definitions("${UI_TARGET}" PRIVATE ${UI_DEFINITIONS})

target_compile_options("${UI_TARGET}" PRIVATE ${UI_CFLAGS})

target_link_libraries("${UI_TARGET}" ${UI_LIBRARIES})

string(REPLACE ";" " " UI_LDFLAGS_STRING "${UI_LDFLAGS}")
set_target_properties("${UI_TARGET}" PROPERTIES LINK_FLAGS "${UI_LDFLAGS_STRING}")

if(MISSIONPACK_VM_INSTALL_DIR)
	install(TARGETS "${UI_TARGET}" DESTINATION "${MISSIONPACK_VM_INSTALL_DIR}")
endif(MISSIONPACK_VM_INSTALL_DIR)
