cmake_minimum_required(VERSION 3.12)
project(gend_libs)

set(CMAKE_EXPORT_COMPILE_COMMANDS ON)
set(CMAKE_POSITION_INDEPENDENT_CODE ON)
set(CMAKE_INCLUDE_HEADERS_IN_COMPILE_COMMANDS ON)

include(GNUInstallDirs)



# Loop over libraries to create shared libraries and set up install rules


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


# State estimation header library

add_library(State_Estimation INTERFACE)

target_include_directories(State_Estimation INTERFACE State_Estimation/include/)

target_link_libraries(State_Estimation INTERFACE 


