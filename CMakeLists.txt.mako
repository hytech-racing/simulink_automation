cmake_minimum_required(VERSION 3.12)
project(gend_libs)

set(CMAKE_EXPORT_COMPILE_COMMANDS ON)
set(CMAKE_POSITION_INDEPENDENT_CODE ON)
set(CMAKE_INCLUDE_HEADERS_IN_COMPILE_COMMANDS ON)

include(GNUInstallDirs)

# Loop over libraries to create shared libraries and set up install rules
% for library in libraries:
add_library(${library['name']} SHARED
    % for source in library['sources']
    ${source}
    % end for
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

# State estimation header library
add_library(matlab_model INTERFACE)

target_include_directories(matlab_model INTERFACE 
    <%text>$<BUILD_INTERFACE:${CMAKE_CURRENT_SOURCE_DIR}/</%text>matlab_model/include>
    <%text>$<INSTALL_INTERFACE</%text>:matlab_model/include>
)

target_link_libraries(matlab_model INTERFACE 
    % for library in libraries: 
    ${library['name']}
    %endfor
)

install(
    TARGETS matlab_model
    EXPORT matlab_modelTargets
    LIBRARY DESTINATION ${CMAKE_INSTALL_LIBDIR}
    ARCHIVE DESTINATION ${CMAKE_INSTALL_LIBDIR}
    RUNTIME DESTINATION ${CMAKE_INSTALL_BINDIR}

)

install(
    DIRECTORY matlab_model/include/
    DESTINATION matlab_model/include
)



