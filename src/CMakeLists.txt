SET( APP_VALA_FILES
    Controller/Root.vala
    Controller/Plugins.vala
    Controller/Service/Plugin.vala
    Controller/Service/Search.vala

    Form/PluginGet.vala

    Model/PSMarkdown.vala
    Model/DB/AlmannaLoader.vala
    Model/DB/Author.vala
    Model/DB/Plugin.vala
    Model/DB/PluginDocumentation.vala
    Model/DB/PluginHistory.vala
    Model/DB/PluginInstall.vala

    View/JsonView.vala
    View/JSON/Search.vala
)

SET( APP_AM_VALA_FILES
    Application.vala
    .generated/Actions.vala
    ${TEMPLATE_FILE_LIST}
    ${APP_VALA_FILES}
)
vala_precompile(APPLIB_VALA_C 
    ${APP_AM_VALA_FILES}
PACKAGES
    ${APP_VALA_PACKAGES}
OPTIONS
    --thread
    --enable-experimental
    ${APP_PLUGIN_VAPI_LIST}
    -g
GENERATE_VAPI
    ${APPNAME}
GENERATE_HEADER
    ${APPNAME})

vala_precompile(APPBIN_VALA_C
    Main.vala
PACKAGES
    ${APP_VALA_PACKAGES}
    ${APPNAME}
OPTIONS
    --thread
    --enable-experimental
    --vapidir=.
    ${APP_PLUGIN_VAPI_LIST}
    --debug)

set(APP_CFLAGS
    ${APP_DEPS_CFLAGS}
    ${APP_DEPS_CFLAGS_OTHER}
    ${APP_PLUGIN_INCLUDE_LIST}
)
set(APP_LIB_PATHS
    ${APP_DEPS_LIBRARY_DIRS}
    ${APP_PLUGIN_LIBRARY_DIRS}
)
set(APP_DEPS_LIBRARIES ${APP_DEPS_LIBRARIES})
add_definitions(${APP_CFLAGS})

link_directories( ${APP_LIB_PATHS} )
add_library(${APPNAME} SHARED ${APPLIB_VALA_C})
add_executable(${BINNAME} ${APPBIN_VALA_C})
target_link_libraries(${APPNAME} ${APP_DEPS_LIBRARIES} ${APP_PLUGIN_PACKAGES} markdown gthread-2.0)
target_link_libraries(${BINNAME} ${APPNAME} gthread-2.0)

install (TARGETS ${APPNAME} DESTINATION ${CMAKE_INSTALL_PREFIX}/bin/)
install (TARGETS ${BINNAME} DESTINATION ${CMAKE_INSTALL_PREFIX}/bin/)

