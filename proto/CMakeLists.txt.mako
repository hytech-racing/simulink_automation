<%text> 
set(PROTO_BINARY_DIR ${CMAKE_CURRENT_BINARY_DIR}/generated/)
set(LIBRARY simulink_automation_msgs_proto_cpp)
set(OBJECT_LIBRARY simulink_automation_msgs_proto_cpp_object)

find_package(Protobuf REQUIRED CONFIG)

file(MAKE_DIRECTORY ${PROTO_BINARY_DIR})

add_library(${OBJECT_LIBRARY} OBJECT 
</%text> 
    % for name in all_model_names: 
    proto/${name}_estimation_msgs.proto
    % endfor
<%text>
)

target_include_directories(${OBJECT_LIBRARY} 
    PUBLIC $<BUILD_INTERFACE:${PROTO_BINARY_DIR}>)

target_link_libraries(${OBJECT_LIBRARY} 
    PUBLIC protobuf::libprotobuf)

protobuf_generate(TARGET ${OBJECT_LIBRARY} IMPORT_DIRS proto
                PROTOC_OUT_DIR "${PROTO_BINARY_DIR}")

add_library(${LIBRARY} $<TARGET_OBJECTS:${OBJECT_LIBRARY}>)

target_include_directories(
        ${LIBRARY} PUBLIC $<BUILD_INTERFACE:${PROTO_BINARY_DIR}>
                        $<INSTALL_INTERFACE:${CMAKE_INSTALL_INCLUDEDIR}>)

target_link_libraries(${LIBRARY} PUBLIC ${DEPS} protobuf::libprotobuf)

install(
    DIRECTORY ${PROTO_BINARY_DIR}
    DESTINATION ${CMAKE_INSTALL_INCLUDEDIR}
    FILES_MATCHING
    PATTERN "*.pb.h"
)
</%text>