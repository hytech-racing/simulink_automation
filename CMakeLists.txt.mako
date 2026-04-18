cmake_minimum_required(VERSION 3.12)
project(gend_libs)

set(CMAKE_EXPORT_COMPILE_COMMANDS ON)
set(CMAKE_POSITION_INDEPENDENT_CODE ON)
set(CMAKE_INCLUDE_HEADERS_IN_COMPILE_COMMANDS ON)

find_package(Protobuf REQUIRED)

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

% for library in libraries:
add_library(${library['name']} 
    ${format_sources(library['sources'])}
)

target_include_directories(${library['name']} PUBLIC
    <%text>$<BUILD_INTERFACE:${CMAKE_CURRENT_SOURCE_DIR}/</%text>${library['name']}/include>
    <%text>$<INSTALL_INTERFACE</%text>:${library['name']}/include>
)
% endfor

# State estimation header library
add_library(matlab_model
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
    drivebrain_core
    protobuf::libprotobuf
    simulink_automation_msgs_proto_cpp
)