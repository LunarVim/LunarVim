# If not in a git repo (e.g., a tarball) these tokens define the complete
# version string, else they are combined with the result of `git describe`.
set(LVIM_VERSION_MAJOR 1)
set(LVIM_VERSION_MINOR 4)
set(LVIM_VERSION_PATCH 0)
set(LVIM_VERSION_PRERELEASE "-dev")

set(LVIM_VERSION "${LVIM_VERSION_MAJOR}.${LVIM_VERSION_MINOR}.${LVIM_VERSION_PATCH}${LVIM_VERSION_PRERELEASE}")

execute_process(
  COMMAND git --no-pager log --pretty=format:%h -1
  WORKING_DIRECTORY "${CMAKE_SOURCE_DIR}"
  OUTPUT_VARIABLE COMMIT_SHA
  OUTPUT_STRIP_TRAILING_WHITESPACE
  RESULT_VARIABLE EXIT_CODE)

if(EXIT_CODE EQUAL 0 )
  if(LVIM_VERSION_PRERELEASE)
    set(LVIM_VERSION "${LVIM_VERSION}+${COMMIT_SHA}")
  endif()
endif()

file(WRITE "${CMAKE_BINARY_DIR}/version.txt" "${LVIM_VERSION}")

message(STATUS "Using LVIM_VERSION: ${LVIM_VERSION}")
