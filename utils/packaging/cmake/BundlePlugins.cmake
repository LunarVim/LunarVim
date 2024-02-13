set(XDG_ROOT "${CMAKE_BINARY_DIR}/xdg_root")
set(ENV{XDG_DATA_HOME} "${XDG_ROOT}/share")
set(ENV{XDG_CONFIG_HOME} "${XDG_ROOT}/.config")
set(ENV{XDG_CACHE_HOME} "${XDG_ROOT}/.cache")
set(ENV{LUNARVIM_RUNTIME_DIR} "$ENV{XDG_DATA_HOME}/lunarvim")
set(ENV{LUNARVIM_CONFIG_DIR} "$ENV{XDG_CONFIG_HOME}/lvim")
set(ENV{LUNARVIM_CACHE_DIR} "$ENV{XDG_CACHE_HOME}/lvim")
set(ENV{LUNARVIM_BASE_DIR} "${CMAKE_SOURCE_DIR}")
set(ENV{LVIM_TEST_ENV} "true")

set(INIT_LUA_PATH "$ENV{LUNARVIM_BASE_DIR}/init.lua")

file(REMOVE_RECURSE ${XDG_ROOT} ${CMAKE_BINARY_DIR}/plugins)

set(DOWNLOAD_PLUGINS_CMD "nvim" "-u" "${INIT_LUA_PATH}" "--headless" "-c" "quitall")
message("downloading plugins...")
message("${DOWNLOAD_PLUGINS_CMD}")

set(BUNDLE_PLUGINS_TIMEOUT 240 CACHE STRING "")
execute_process( 
  COMMAND ${DOWNLOAD_PLUGINS_CMD}
  TIMEOUT ${BUNDLE_PLUGINS_TIMEOUT}
  RESULT_VARIABLE exit_code
  OUTPUT_VARIABLE output
  ERROR_VARIABLE stderr
  OUTPUT_STRIP_TRAILING_WHITESPACE)

if(NOT exit_code EQUAL 0 )
  message(FATAL_ERROR "${exit_code} ${output} ${stderr}")
else()
  message("${output} ${stderr}")
  install(DIRECTORY 
    "$ENV{LUNARVIM_RUNTIME_DIR}/site/pack/lazy/opt/"
    DESTINATION ${CMAKE_INSTALL_DATAROOTDIR}/lunarvim/plugins/)
endif()
