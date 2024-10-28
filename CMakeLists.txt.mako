cmake_minimum_required(VERSION 3.12)
project(gend_libs)

set(CMAKE_EXPORT_COMPILE_COMMANDS ON)
set(CMAKE_POSITION_INDEPENDENT_CODE ON)
set(CMAKE_INCLUDE_HEADERS_IN_COMPILE_COMMANDS ON)

include(GNUInstallDirs)

<%!
def format_sources(sources):
    return " ".join(sources)
%>

# Loop over libraries to create shared libraries and set up install rules
% for library in libraries:
add_library(${library['name']} SHARED
    ${format_sources(library['sources'])}
)

target_include_directories(${library['name']} PUBLIC
    <%text>$<BUILD_INTERFACE:${CMAKE_CURRENT_SOURCE_DIR}/</%text>${library['name']}/include>
    <%text>$<INSTALL_INTERFACE</%text>:${library['name']}/include>
)


install(
    TARGETS ${library['name']}
<%text>    EXPORT codegenTargets
    LIBRARY DESTINATION ${CMAKE_INSTALL_LIBDIR}
    ARCHIVE DESTINATION ${CMAKE_INSTALL_LIBDIR}
    RUNTIME DESTINATION ${CMAKE_INSTALL_BINDIR}
</%text>
)

install(
    DIRECTORY ${library['name']}/include/
    DESTINATION ${library['name']}/include
)

% endfor

<%text>
# Install target export
install(EXPORT codegenTargets
  FILE codegenTargets.cmake
  NAMESPACE codegen::  
  DESTINATION ${CMAKE_INSTALL_LIBDIR}/cmake/codegen
)

# Configure package configuration file
include(CMakePackageConfigHelpers)
configure_package_config_file(${CMAKE_CURRENT_LIST_DIR}/cmake/codegenConfig.cmake.in
  "${CMAKE_CURRENT_BINARY_DIR}/codegenConfig.cmake"
  INSTALL_DESTINATION ${CMAKE_INSTALL_LIBDIR}/cmake/codegen
)

install(FILES
  "${CMAKE_CURRENT_BINARY_DIR}/codegenConfig.cmake"
  DESTINATION ${CMAKE_INSTALL_LIBDIR}/cmake/codegen
)
</%text>

# State estiation header library

<%!
def format_libs(sources):
    result = ""
    for lib in libraries: 
      result += " ".join(lib['name'])
    return result
%>

add_library(State_Estimation INTERFACE)

target_include_directories(State_Estimation INTERFACE State_Estimation/include/)

target_link_libraries(State_Estimation INTERFACE 
    ${format_libs(libraries['name'])})

