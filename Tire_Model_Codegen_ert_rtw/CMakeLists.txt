###########################################################################
# CMakeLists.txt generated for component Tire_Model_Codegen
# Product type: executable
###########################################################################
cmake_minimum_required(VERSION 3.12)
project(Tire_Model_Codegen)

# Propagate the CMAKE_EXPORT_COMPILE_COMMANDS variable from the 
# environment if it is defined as an environment variable, but not as a 
# CMake variable. This is to work around a bug in CMake 3.19 when the 
# "NMake Makefiles" generator is selected.
if(DEFINED ENV{CMAKE_EXPORT_COMPILE_COMMANDS} AND NOT DEFINED CMAKE_EXPORT_COMPILE_COMMANDS)
    set(CMAKE_EXPORT_COMPILE_COMMANDS $ENV{CMAKE_EXPORT_COMPILE_COMMANDS})
endif()


# Set directory properties.
set_property(DIRECTORY PROPERTY VS_STARTUP_PROJECT Tire_Model_Codegen)

###########################################################################
## Path variables
###########################################################################
# Derive an absolute path to the code generation anchor folder.
get_filename_component(START_DIR .. ABSOLUTE)

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
if(NOT TARGET HT09_Linear_Vehicle_Model_rtwlib)
    add_subdirectory(../slprj/ert/HT09_Linear_Vehicle_Model ${BINARY_START_DIR}/slprj/ert/HT09_Linear_Vehicle_Model)
endif()
if(NOT TARGET rtwshared)
    add_subdirectory(../slprj/ert/_sharedutils ${BINARY_START_DIR}/slprj/ert/_sharedutils)
endif()

# Definition of target "Tire_Model_Codegen".
add_executable(Tire_Model_Codegen  ${START_DIR}/Tire_Model_Codegen_ert_rtw/Tire_Model_Codegen.cpp
    ${START_DIR}/Tire_Model_Codegen_ert_rtw/ert_main.cpp)

# Set properties for target "Tire_Model_Codegen".
set_target_properties(Tire_Model_Codegen PROPERTIES PREFIX ""
    POSITION_INDEPENDENT_CODE ON
    RUNTIME_OUTPUT_DIRECTORY "${BINARY_START_DIR}/./$<0:>"
    LIBRARY_OUTPUT_DIRECTORY "${BINARY_START_DIR}/./$<0:>"
    ARCHIVE_OUTPUT_DIRECTORY "${BINARY_START_DIR}/./$<0:>")

# Specify language features required for target "Tire_Model_Codegen".
target_compile_features(Tire_Model_Codegen PUBLIC cxx_std_11)

# Specify compiler preprocessor definitions for target 
# "Tire_Model_Codegen".
target_compile_definitions(Tire_Model_Codegen PRIVATE -DMODEL=Tire_Model_Codegen
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

# Specify include directories for target "Tire_Model_Codegen".
target_include_directories(Tire_Model_Codegen PRIVATE ${START_DIR}/slprj/ert/HT09_Linear_Vehicle_Model
    ${START_DIR}
    ${START_DIR}/Tire_Model_Codegen_ert_rtw
    ${MATLAB_ROOT}/extern/include
    ${MATLAB_ROOT}/simulink/include
    ${MATLAB_ROOT}/rtw/c/src
    ${MATLAB_ROOT}/rtw/c/src/ext_mode/common
    ${MATLAB_ROOT}/rtw/c/ert
    ${START_DIR}/slprj/ert/_sharedutils)

# Specify library link dependencies for target "Tire_Model_Codegen". CMake 
# generator expressions are used to create a CMakeLists.txt file that 
# supports multiple platforms with differently named system library 
# dependencies.
target_link_libraries(Tire_Model_Codegen PRIVATE HT09_Linear_Vehicle_Model_rtwlib
    rtwshared
    $<$<BOOL:${FOUND_LIBM}>:m>
    $<$<BOOL:${WIN32}>:kernel32>
    $<$<BOOL:${WIN32}>:ws2_32>
    $<$<BOOL:${WIN32}>:mswsock>
    $<$<BOOL:${WIN32}>:advapi32>)

# Extract DWARF debug symbols into a separate file when building 
# executable programs for Apple platforms.
if(APPLE AND (CMAKE_C_COMPILER_ID STREQUAL "AppleClang"))
    string(APPEND _dsymutilcmd "$<IF:$<CONFIG:DEBUG,RELWITHDEBINFO>,"
                "xcrun;dsymutil;$<TARGET_FILE:Tire_Model_Codegen>;--flat,"
                "true"
        >)
    add_custom_command(TARGET Tire_Model_Codegen
            POST_BUILD
            COMMAND "${_dsymutilcmd}"
            COMMAND_EXPAND_LISTS
            BYPRODUCTS Tire_Model_Codegen.dwarf)
endif()


###########################################################################
## Build success message
###########################################################################
add_custom_command(TARGET Tire_Model_Codegen POST_BUILD
     COMMAND ${CMAKE_COMMAND} -E cmake_echo_color --cyan "\\#\\#\\# Created executable: $<TARGET_FILE:Tire_Model_Codegen>")

###########################################################################
## Call toolchain hook function if defined
###########################################################################
if(COMMAND toolchain_target_hook)
    toolchain_target_hook(Tire_Model_Codegen)
endif()
