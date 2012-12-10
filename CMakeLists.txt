cmake_minimum_required (VERSION 2.8)
cmake_policy(VERSION 2.8)
project(PluginService)
list(APPEND CMAKE_MODULE_PATH ${CMAKE_SOURCE_DIR}/cmake )
enable_testing()

find_package(Vala REQUIRED)
include(ValaVersion)
include(ValaPrecompile)
ensure_vala_version("0.16.0" MINIMUM)

IF(CMAKE_INSTALL_PREFIX_INITIALIZED_TO_DEFAULT)
    SET(CMAKE_INSTALL_PREFIX "/usr" CACHE PATH "install prefix" FORCE)
ENDIF(CMAKE_INSTALL_PREFIX_INITIALIZED_TO_DEFAULT)

set (BINNAME PluginService)
set (PREFIX ${CMAKE_INSTALL_PREFIX})

INCLUDE(plugins/plugins.cmake)

SET(APP_DEPS_PACKAGES
    gee-1.0
    ambition-0.1
    ${APP_PLUGIN_PKGCONFIG}
)

SET(APP_VALA_PACKAGES
	${APP_DEPS_PACKAGES}
	${APP_PLUGIN_PACKAGES}
	posix
)

find_package(PkgConfig)
pkg_check_modules(APP_DEPS REQUIRED ${APP_DEPS_PACKAGES})

execute_process(
	COMMAND mkdir -p "${CMAKE_SOURCE_DIR}/src/.generated" )

execute_process(
	COMMAND ambition build-actions ${BINNAME} "${CMAKE_SOURCE_DIR}/config" "${CMAKE_SOURCE_DIR}/src/.generated"
	OUTPUT_VARIABLE ACTION_RESULT )
IF( ACTION_RESULT MATCHES "Fatal Error" )
	message( FATAL_ERROR ${ACTION_RESULT} )
ENDIF()

execute_process( 
	COMMAND ambition template-compile ${BINNAME} "${CMAKE_SOURCE_DIR}/src/View/Template" "${CMAKE_SOURCE_DIR}/src/.generated"
	OUTPUT_VARIABLE TEMPLATE_FILES )
IF( TEMPLATE_FILES MATCHES "Fatal Error" )
	message( FATAL_ERROR ${TEMPLATE_FILES} )
ENDIF()

SET(TEMPLATE_FILE_LIST)
FOREACH ( NEXT_ITEM ${TEMPLATE_FILES} )
	STRING( REPLACE "${CMAKE_SOURCE_DIR}/src/" "" NEXT_ITEM ${NEXT_ITEM} )
	LIST( APPEND TEMPLATE_FILE_LIST "${NEXT_ITEM}" )
ENDFOREACH()

add_subdirectory (src)
add_subdirectory (test)
