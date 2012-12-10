SET( APP_VALA_FILES
    Controller/Root.vala
    Controller/Plugin.vala
    Controller/Search.vala

    Form/PluginGet.vala

    View/JsonView.vala
    View/JSON/Search.vala
)

vala_precompile(APP_VALA_C 
    Application.vala
    .generated/Actions.vala
    ${TEMPLATE_FILE_LIST}
    ${APP_VALA_FILES}
PACKAGES
    ${APP_VALA_PACKAGES}
OPTIONS
	--thread
    ${APP_PLUGIN_VAPI_LIST}
	--enable-experimental)

set(APP_CFLAGS
    ${APP_DEPS_CFLAGS}
    ${APP_DEPS_CFLAGS_OTHER}
)
set(APP_LIB_PATHS
    ${APP_DEPS_LIBRARY_DIRS}
    ${APP_PLUGIN_LIBRARY_DIRS}
)
add_definitions(${APP_CFLAGS})

link_directories( ${APP_PLUGIN_LIBRARY_DIRS} )
add_executable(${BINNAME} ${APP_VALA_C})
target_link_libraries(${BINNAME} ${APP_DEPS_LIBRARIES} ${APP_PLUGIN_PACKAGES} gthread-2.0)

install (TARGETS ${BINNAME} DESTINATION ${CMAKE_INSTALL_PREFIX}/bin/)
