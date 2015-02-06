#target_compile_options(), target_compile_definitions() require cmake version 2.8.12
if(CMAKE_VERSION VERSION_LESS "2.8.12")
	function("target_compile_definitions" arg1 arg2)
		add_definitions(${ARGN})
	endfunction()
	function("target_compile_options" arg1 arg2)
		string(REPLACE ";" " " OPT_STRING "${ARGN}")
		set_target_properties("${arg1}" PROPERTIES COMPILE_FLAGS "${OPT_STRING}")
	endfunction()
	function("target_include_directories" arg1 arg2)
		foreach(INCLUDE_STRING ${ARGN})
			include_directories("${INCLUDE_STRING}")
		endforeach()
	endfunction()

endif()


if(DEFINED MODULE_CHECKCCOMPILERFLAG_EXISTS AND NOT MODULE_CHECKCCOMPILERFLAG_EXISTS)
	message(WARNING "Module CheckCCompilerFlag for CHECK_C_COMPILER_FLAG() not found.")
	function("CHECK_C_COMPILER_FLAG")

	endfunction()

endif()

if(DEFINED MODULE_CHECKCSOURCECOMPILES_EXISTS AND NOT MODULE_CHECKCSOURCECOMPILES_EXISTS)
	message(WARNING "Module CheckCSourceCompiles for CHECK_C_SOURCE_COMPILES() not found.")
	function("CHECK_C_SOURCE_COMPILES")

	endfunction()

endif()

if(DEFINED MODULE_CHECKINCLUDEFILE_EXISTS AND NOT MODULE_CHECKINCLUDEFILE_EXISTS)
	message(WARNING "Module CheckIncludeFile for CHECK_INCLUDE_FILE() not found.")
	function("CHECK_INCLUDE_FILE")

	endfunction()

endif()

if(DEFINED MODULE_TESTBIGENDIAN_EXISTS AND NOT MODULE_TESTBIGENDIAN_EXISTS)
	message(WARNING "Module TestBigEndian for TEST_BIG_ENDIAN() not found.")
	function("TEST_BIG_ENDIAN")

	endfunction()

endif()

