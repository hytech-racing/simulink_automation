cmake_minimum_required(VERSION 3.12)
project(gend_libs)

set(CMAKE_EXPORT_COMPILE_COMMANDS ON)
set(CMAKE_POSITION_INDEPENDENT_CODE ON)
set(CMAKE_INCLUDE_HEADERS_IN_COMPILE_COMMANDS ON)

find_package(drivebrain_core REQUIRED)

include(GNUInstallDirs)
<%!
def format_sources(sources):
    return " ".join(sources)
%>
<%!
def format_libraries(libraries):
    library_names = []
    for library in libraries:
      library_names.append(library['name'])
    return " ".join(library_names)
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
    DIRECTORY ${library['name']}/include/
    DESTINATION ${library['name']}/include
)
% endfor

# State estimation header library
add_library(matlab_model SHARED
% for library in libraries:
    matlab_model/src/${library['name']}_MatlabModel.cpp
% endfor
)

target_include_directories(matlab_model PUBLIC 
  <%text>$<BUILD_INTERFACE:${CMAKE_CURRENT_SOURCE_DIR}/</%text>matlab_model/include>
  <%text>$<INSTALL_INTERFACE</%text>:matlab_model/include>)

target_link_libraries(matlab_model PUBLIC
    % for library in libraries: 
    ${library['name']}
    %endfor
    drivebrain_core::drivebrain_core
)

install(
    TARGETS ${format_libraries(libraries)} matlab_model
<%text>    EXPORT codegenTargets
    LIBRARY DESTINATION ${CMAKE_INSTALL_LIBDIR}
    ARCHIVE DESTINATION ${CMAKE_INSTALL_LIBDIR}
    RUNTIME DESTINATION ${CMAKE_INSTALL_BINDIR}</%text>
)

install(
    DIRECTORY matlab_model/include/
    DESTINATION matlab_model/include
)

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

