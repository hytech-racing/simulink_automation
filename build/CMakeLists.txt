cmake_minimum_required(VERSION 3.12)
project(gend_libs)

set(CMAKE_EXPORT_COMPILE_COMMANDS ON)
set(CMAKE_POSITION_INDEPENDENT_CODE ON)
set(CMAKE_INCLUDE_HEADERS_IN_COMPILE_COMMANDS ON)

include(GNUInstallDirs)



# Loop over libraries to create shared libraries and set up install rules
add_library(Tire_Model_Codegen SHARED
    Tire_Model_Codegen/src/minimum_5X1FIofZ.cpp Tire_Model_Codegen/src/rt_nonfinite.cpp Tire_Model_Codegen/src/rtGetInf.cpp Tire_Model_Codegen/src/interp1_ctBBGdhl.cpp Tire_Model_Codegen/src/maximum_kQ2v6WLV.cpp Tire_Model_Codegen/src/look1_binlcapw.cpp Tire_Model_Codegen/src/const_params.cpp Tire_Model_Codegen/src/rtGetNaN.cpp Tire_Model_Codegen/src/repelem_u5I1BzYw.cpp Tire_Model_Codegen/src/HT09_Linear_Vehicle_Model.cpp Tire_Model_Codegen/src/HT09_Linear_Vehicle_Model_data.cpp Tire_Model_Codegen/src/Tire_Model_Codegen.cpp Tire_Model_Codegen/src/minimum_5X1FIofZ.cpp Tire_Model_Codegen/src/rt_nonfinite.cpp Tire_Model_Codegen/src/rtGetInf.cpp Tire_Model_Codegen/src/interp1_ctBBGdhl.cpp Tire_Model_Codegen/src/maximum_kQ2v6WLV.cpp Tire_Model_Codegen/src/look1_binlcapw.cpp Tire_Model_Codegen/src/const_params.cpp Tire_Model_Codegen/src/rtGetNaN.cpp Tire_Model_Codegen/src/repelem_u5I1BzYw.cpp Tire_Model_Codegen/src/HT09_Linear_Vehicle_Model.cpp Tire_Model_Codegen/src/HT09_Linear_Vehicle_Model_data.cpp Tire_Model_Codegen/src/Tire_Model_Codegen.cpp Tire_Model_Codegen/src/minimum_5X1FIofZ.cpp Tire_Model_Codegen/src/rt_nonfinite.cpp Tire_Model_Codegen/src/rtGetInf.cpp Tire_Model_Codegen/src/interp1_ctBBGdhl.cpp Tire_Model_Codegen/src/maximum_kQ2v6WLV.cpp Tire_Model_Codegen/src/look1_binlcapw.cpp Tire_Model_Codegen/src/const_params.cpp Tire_Model_Codegen/src/rtGetNaN.cpp Tire_Model_Codegen/src/repelem_u5I1BzYw.cpp Tire_Model_Codegen/src/HT09_Linear_Vehicle_Model.cpp Tire_Model_Codegen/src/HT09_Linear_Vehicle_Model_data.cpp Tire_Model_Codegen/src/Tire_Model_Codegen.cpp Tire_Model_Codegen/src/minimum_5X1FIofZ.cpp Tire_Model_Codegen/src/rt_nonfinite.cpp Tire_Model_Codegen/src/rtGetInf.cpp Tire_Model_Codegen/src/interp1_ctBBGdhl.cpp Tire_Model_Codegen/src/maximum_kQ2v6WLV.cpp Tire_Model_Codegen/src/look1_binlcapw.cpp Tire_Model_Codegen/src/const_params.cpp Tire_Model_Codegen/src/rtGetNaN.cpp Tire_Model_Codegen/src/repelem_u5I1BzYw.cpp Tire_Model_Codegen/src/HT09_Linear_Vehicle_Model.cpp Tire_Model_Codegen/src/HT09_Linear_Vehicle_Model_data.cpp Tire_Model_Codegen/src/Tire_Model_Codegen.cpp Tire_Model_Codegen/src/minimum_5X1FIofZ.cpp Tire_Model_Codegen/src/rt_nonfinite.cpp Tire_Model_Codegen/src/rtGetInf.cpp Tire_Model_Codegen/src/interp1_ctBBGdhl.cpp Tire_Model_Codegen/src/maximum_kQ2v6WLV.cpp Tire_Model_Codegen/src/look1_binlcapw.cpp Tire_Model_Codegen/src/const_params.cpp Tire_Model_Codegen/src/rtGetNaN.cpp Tire_Model_Codegen/src/repelem_u5I1BzYw.cpp Tire_Model_Codegen/src/HT09_Linear_Vehicle_Model.cpp Tire_Model_Codegen/src/HT09_Linear_Vehicle_Model_data.cpp Tire_Model_Codegen/src/Tire_Model_Codegen.cpp Tire_Model_Codegen/src/minimum_5X1FIofZ.cpp Tire_Model_Codegen/src/rt_nonfinite.cpp Tire_Model_Codegen/src/rtGetInf.cpp Tire_Model_Codegen/src/interp1_ctBBGdhl.cpp Tire_Model_Codegen/src/maximum_kQ2v6WLV.cpp Tire_Model_Codegen/src/look1_binlcapw.cpp Tire_Model_Codegen/src/const_params.cpp Tire_Model_Codegen/src/rtGetNaN.cpp Tire_Model_Codegen/src/repelem_u5I1BzYw.cpp Tire_Model_Codegen/src/HT09_Linear_Vehicle_Model.cpp Tire_Model_Codegen/src/HT09_Linear_Vehicle_Model_data.cpp Tire_Model_Codegen/src/Tire_Model_Codegen.cpp Tire_Model_Codegen/src/minimum_5X1FIofZ.cpp Tire_Model_Codegen/src/rt_nonfinite.cpp Tire_Model_Codegen/src/rtGetInf.cpp Tire_Model_Codegen/src/interp1_ctBBGdhl.cpp Tire_Model_Codegen/src/maximum_kQ2v6WLV.cpp Tire_Model_Codegen/src/look1_binlcapw.cpp Tire_Model_Codegen/src/const_params.cpp Tire_Model_Codegen/src/rtGetNaN.cpp Tire_Model_Codegen/src/repelem_u5I1BzYw.cpp Tire_Model_Codegen/src/HT09_Linear_Vehicle_Model.cpp Tire_Model_Codegen/src/HT09_Linear_Vehicle_Model_data.cpp Tire_Model_Codegen/src/Tire_Model_Codegen.cpp Tire_Model_Codegen/src/minimum_5X1FIofZ.cpp Tire_Model_Codegen/src/rt_nonfinite.cpp Tire_Model_Codegen/src/rtGetInf.cpp Tire_Model_Codegen/src/interp1_ctBBGdhl.cpp Tire_Model_Codegen/src/maximum_kQ2v6WLV.cpp Tire_Model_Codegen/src/look1_binlcapw.cpp Tire_Model_Codegen/src/const_params.cpp Tire_Model_Codegen/src/rtGetNaN.cpp Tire_Model_Codegen/src/repelem_u5I1BzYw.cpp Tire_Model_Codegen/src/HT09_Linear_Vehicle_Model.cpp Tire_Model_Codegen/src/HT09_Linear_Vehicle_Model_data.cpp Tire_Model_Codegen/src/Tire_Model_Codegen.cpp
)

target_include_directories(Tire_Model_Codegen PUBLIC
    $<BUILD_INTERFACE:${CMAKE_CURRENT_SOURCE_DIR}/Tire_Model_Codegen/include>
    $<INSTALL_INTERFACE:Tire_Model_Codegen/include>
)


install(
    TARGETS Tire_Model_Codegen
    EXPORT codegenTargets
    LIBRARY DESTINATION ${CMAKE_INSTALL_LIBDIR}
    ARCHIVE DESTINATION ${CMAKE_INSTALL_LIBDIR}
    RUNTIME DESTINATION ${CMAKE_INSTALL_BINDIR}

)

install(
    DIRECTORY Tire_Model_Codegen/include/
    DESTINATION Tire_Model_Codegen/include
)



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
    Tire_Model_Codegen
)

