###########################################################################
# CMakeLists.txt generated for component HT09_Linear_Vehicle_Model_rtwlib
# Product type: STATIC library
###########################################################################
cmake_minimum_required(VERSION 3.12)
project(HT09_Linear_Vehicle_Model_rtwlib)

# Propagate the CMAKE_EXPORT_COMPILE_COMMANDS variable from the 
# environment if it is defined as an environment variable, but not as a 
# CMake variable. This is to work around a bug in CMake 3.19 when the 
# "NMake Makefiles" generator is selected.
if(DEFINED ENV{CMAKE_EXPORT_COMPILE_COMMANDS} AND NOT DEFINED CMAKE_EXPORT_COMPILE_COMMANDS)
    set(CMAKE_EXPORT_COMPILE_COMMANDS $ENV{CMAKE_EXPORT_COMPILE_COMMANDS})
endif()


###########################################################################
## Path variables
###########################################################################
# Derive an absolute path to the code generation anchor folder.
get_filename_component(START_DIR ../../.. ABSOLUTE)

# Special directories defined by using CACHE variables can be overridden 
# by setting the variable from the command line, e.g.,
# 
# 	cmake . -DMATLAB_ROOT=/path/to/another/matlab/root
set(MATLAB_ROOT /usr/local/MATLAB/R2024b CACHE PATH "")

# Additional variables that are defined conditionally.
if("${CMAKE_CURRENT_BINARY_DIR}" STREQUAL "${CMAKE_CURRENT_SOURCE_DIR}")
    set(BINARY_START_DIR "${START_DIR}")
else()
    set(BINARY_START_DIR "${CMAKE_BINARY_DIR}")
endif()

###########################################################################
## System Libraries
###########################################################################
find_library(FOUND_LIBM m NO_SYSTEM_ENVIRONMENT_PATH PATHS ${CMAKE_C_IMPLICIT_LINK_DIRECTORIES} ${CMAKE_CXX_IMPLICIT_LINK_DIRECTORIES})

###########################################################################
## Target definition and commands
###########################################################################

# Include upstream components that need to be built as part of the current 
# project using the add_subdirectory command.
if(NOT TARGET rtwshared)
    add_subdirectory(../../../slprj/ert/_sharedutils ${BINARY_START_DIR}/slprj/ert/_sharedutils)
endif()

# Definition of target "HT09_Linear_Vehicle_Model_rtwlib".
add_library(HT09_Linear_Vehicle_Model_rtwlib STATIC ${START_DIR}/slprj/ert/HT09_Linear_Vehicle_Model/HT09_Linear_Vehicle_Model.cpp
    ${START_DIR}/slprj/ert/HT09_Linear_Vehicle_Model/HT09_Linear_Vehicle_Model_data.cpp)

# Set properties for target "HT09_Linear_Vehicle_Model_rtwlib".
set_target_properties(HT09_Linear_Vehicle_Model_rtwlib PROPERTIES PREFIX ""
    POSITION_INDEPENDENT_CODE ON
    RUNTIME_OUTPUT_DIRECTORY "${BINARY_START_DIR}/slprj/ert/HT09_Linear_Vehicle_Model/$<0:>"
    LIBRARY_OUTPUT_DIRECTORY "${BINARY_START_DIR}/slprj/ert/HT09_Linear_Vehicle_Model/$<0:>"
    ARCHIVE_OUTPUT_DIRECTORY "${BINARY_START_DIR}/slprj/ert/HT09_Linear_Vehicle_Model/$<0:>")

# Specify language features required for target 
# "HT09_Linear_Vehicle_Model_rtwlib".
target_compile_features(HT09_Linear_Vehicle_Model_rtwlib PUBLIC cxx_std_11)

# Specify compiler preprocessor definitions for target 
# "HT09_Linear_Vehicle_Model_rtwlib".
target_compile_definitions(HT09_Linear_Vehicle_Model_rtwlib PRIVATE -DMODEL=HT09_Linear_Vehicle_Model
    -DNUMST=1
    -DNCSTATES=0
    -DHAVESTDIO
    -DMODEL_HAS_DYNAMICALLY_LOADED_SFCNS=0
    -DCLASSIC_INTERFACE=0
    -DALLOCATIONFCN=0
    -DTID01EQ=0
    -DTERMFCN=1
    -DONESTEPFCN=1
    -DMAT_FILE=0
    -DMULTI_INSTANCE_CODE=1
    -DINTEGER_CODE=0
    -DMT=0)

# Specify include directories for target 
# "HT09_Linear_Vehicle_Model_rtwlib".
target_include_directories(HT09_Linear_Vehicle_Model_rtwlib PUBLIC $<BUILD_INTERFACE:${START_DIR}>
    $<INSTALL_INTERFACE:$<INSTALL_PREFIX>>
    $<BUILD_INTERFACE:${START_DIR}/slprj/ert/HT09_Linear_Vehicle_Model>
    $<INSTALL_INTERFACE:$<INSTALL_PREFIX>/slprj/ert/HT09_Linear_Vehicle_Model>
    $<BUILD_INTERFACE:${MATLAB_ROOT}/extern/include>
    $<BUILD_INTERFACE:${MATLAB_ROOT}/simulink/include>
    $<BUILD_INTERFACE:${MATLAB_ROOT}/rtw/c/src>
    $<BUILD_INTERFACE:${MATLAB_ROOT}/rtw/c/src/ext_mode/common>
    $<BUILD_INTERFACE:${MATLAB_ROOT}/rtw/c/ert>
    $<BUILD_INTERFACE:${START_DIR}/slprj/ert/_sharedutils>
    $<INSTALL_INTERFACE:$<INSTALL_PREFIX>/slprj/ert/_sharedutils>)

# Specify library link dependencies for target 
# "HT09_Linear_Vehicle_Model_rtwlib". CMake generator expressions are used 
# to create a CMakeLists.txt file that supports multiple platforms with 
# differently named system library dependencies.
target_link_libraries(HT09_Linear_Vehicle_Model_rtwlib PUBLIC $<$<BOOL:${FOUND_LIBM}>:m>)
target_link_libraries(HT09_Linear_Vehicle_Model_rtwlib INTERFACE rtwshared)


###########################################################################
## Build success message
###########################################################################
add_custom_command(TARGET HT09_Linear_Vehicle_Model_rtwlib POST_BUILD
     COMMAND ${CMAKE_COMMAND} -E cmake_echo_color --cyan "\\#\\#\\# Created STATIC library: $<TARGET_FILE:HT09_Linear_Vehicle_Model_rtwlib>")

###########################################################################
## Call toolchain hook function if defined
###########################################################################
if(COMMAND toolchain_target_hook)
    toolchain_target_hook(HT09_Linear_Vehicle_Model_rtwlib)
endif()
