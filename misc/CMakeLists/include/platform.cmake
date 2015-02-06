
math(EXPR BITS "${CMAKE_SIZEOF_VOID_P} * 8")
if(CMAKE_SYSTEM_PROCESSOR MATCHES "(i.86)|(i86pc)|(x86)|(X86)|(amd64)|(AMD64)")
	if(BITS EQUAL 32)
		set(COMPILE_ARCH "x86")
	elseif(BITS EQUAL 64)
		set(COMPILE_ARCH "x86_64")
	endif()
endif()
if(CMAKE_SYSTEM_PROCESSOR MATCHES "powerpc")
	set(COMPILE_ARCH "ppc")
endif()
if(CMAKE_SYSTEM_PROCESSOR MATCHES "powerpc64")
	set(COMPILE_ARCH "ppc64")
endif()
if(CMAKE_SYSTEM_PROCESSOR MATCHES "axp")
	set(COMPILE_ARCH "alpha")
endif()
if(CMAKE_SYSTEM_PROCESSOR MATCHES "x64")
	set(COMPILE_ARCH "x86_64")
endif()


if(NOT DEFINED COMPILE_ARCH)
	set(COMPILE_ARCH "${CMAKE_SYSTEM_PROCESSOR}")
endif()
string(TOLOWER "${COMPILE_ARCH}" COMPILE_ARCH)
if(NOT DEFINED ARCH)
	set(ARCH "${COMPILE_ARCH}")
endif()
string(TOLOWER "${ARCH}" ARCH)

set(COMPILE_PLATFORM "${CMAKE_SYSTEM_NAME}")
string(TOLOWER "${COMPILE_PLATFORM}" COMPILE_PLATFORM)
if(NOT DEFINED PLATFORM)
	set(PLATFORM "${COMPILE_PLATFORM}")
endif()
string(TOLOWER "${PLATFORM}" PLATFORM)
if(NOT PLATFORM STREQUAL COMPILE_PLATFORM)
	set(CROSS_COMPILING TRUE)
else()
	set(CROSS_COMPILING FALSE)
	if(NOT ARCH STREQUAL COMPILE_ARCH)
		set(CROSS_COMPILING TRUE)
	endif()
endif()



if(NOT DEFINED DEFAULT_BIN_EXT)
	if(ARCH)
		set(DEFAULT_BIN_EXT ".${ARCH}")
	endif(ARCH)
endif()


if(NOT DEFINED DEFAULT_INSTALL_DIR)
	if(PLATFORM MATCHES "sunos")
		set(DEFAULT_INSTALL_DIR "/usr/local/share/games/quake3")
	elseif(PLATFORM MATCHES "windows")
		set(DEFAULT_INSTALL_DIR)
	else()
		set(DEFAULT_INSTALL_DIR "/usr/local/games/quake3")
	endif()
endif()


if(DEFINED USE_GIT_REV AND USE_GIT_REV AND GIT_REV)
	set(PRODUCT_VERSION "${VERSION}_GIT_${GIT_REV}")
else()
	set(PRODUCT_VERSION "${VERSION}")
endif()
