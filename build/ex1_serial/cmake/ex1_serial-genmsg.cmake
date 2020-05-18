# generated from genmsg/cmake/pkg-genmsg.cmake.em

message(STATUS "ex1_serial: 4 messages, 0 services")

set(MSG_I_FLAGS "-Iex1_serial:/home/rovertx2/HERO_EX1/src/ex1_serial/msg;-Istd_msgs:/opt/ros/melodic/share/std_msgs/cmake/../msg")

# Find all generators
find_package(gencpp REQUIRED)
find_package(geneus REQUIRED)
find_package(genlisp REQUIRED)
find_package(gennodejs REQUIRED)
find_package(genpy REQUIRED)

add_custom_target(ex1_serial_generate_messages ALL)

# verify that message/service dependencies have not changed since configure



get_filename_component(_filename "/home/rovertx2/HERO_EX1/src/ex1_serial/msg/Send.msg" NAME_WE)
add_custom_target(_ex1_serial_generate_messages_check_deps_${_filename}
  COMMAND ${CATKIN_ENV} ${PYTHON_EXECUTABLE} ${GENMSG_CHECK_DEPS_SCRIPT} "ex1_serial" "/home/rovertx2/HERO_EX1/src/ex1_serial/msg/Send.msg" ""
)

get_filename_component(_filename "/home/rovertx2/HERO_EX1/src/ex1_serial/msg/Message.msg" NAME_WE)
add_custom_target(_ex1_serial_generate_messages_check_deps_${_filename}
  COMMAND ${CATKIN_ENV} ${PYTHON_EXECUTABLE} ${GENMSG_CHECK_DEPS_SCRIPT} "ex1_serial" "/home/rovertx2/HERO_EX1/src/ex1_serial/msg/Message.msg" ""
)

get_filename_component(_filename "/home/rovertx2/HERO_EX1/src/ex1_serial/msg/Telemetry.msg" NAME_WE)
add_custom_target(_ex1_serial_generate_messages_check_deps_${_filename}
  COMMAND ${CATKIN_ENV} ${PYTHON_EXECUTABLE} ${GENMSG_CHECK_DEPS_SCRIPT} "ex1_serial" "/home/rovertx2/HERO_EX1/src/ex1_serial/msg/Telemetry.msg" ""
)

get_filename_component(_filename "/home/rovertx2/HERO_EX1/src/ex1_serial/msg/Read.msg" NAME_WE)
add_custom_target(_ex1_serial_generate_messages_check_deps_${_filename}
  COMMAND ${CATKIN_ENV} ${PYTHON_EXECUTABLE} ${GENMSG_CHECK_DEPS_SCRIPT} "ex1_serial" "/home/rovertx2/HERO_EX1/src/ex1_serial/msg/Read.msg" ""
)

#
#  langs = gencpp;geneus;genlisp;gennodejs;genpy
#

### Section generating for lang: gencpp
### Generating Messages
_generate_msg_cpp(ex1_serial
  "/home/rovertx2/HERO_EX1/src/ex1_serial/msg/Message.msg"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/ex1_serial
)
_generate_msg_cpp(ex1_serial
  "/home/rovertx2/HERO_EX1/src/ex1_serial/msg/Read.msg"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/ex1_serial
)
_generate_msg_cpp(ex1_serial
  "/home/rovertx2/HERO_EX1/src/ex1_serial/msg/Telemetry.msg"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/ex1_serial
)
_generate_msg_cpp(ex1_serial
  "/home/rovertx2/HERO_EX1/src/ex1_serial/msg/Send.msg"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/ex1_serial
)

### Generating Services

### Generating Module File
_generate_module_cpp(ex1_serial
  ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/ex1_serial
  "${ALL_GEN_OUTPUT_FILES_cpp}"
)

add_custom_target(ex1_serial_generate_messages_cpp
  DEPENDS ${ALL_GEN_OUTPUT_FILES_cpp}
)
add_dependencies(ex1_serial_generate_messages ex1_serial_generate_messages_cpp)

# add dependencies to all check dependencies targets
get_filename_component(_filename "/home/rovertx2/HERO_EX1/src/ex1_serial/msg/Send.msg" NAME_WE)
add_dependencies(ex1_serial_generate_messages_cpp _ex1_serial_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/rovertx2/HERO_EX1/src/ex1_serial/msg/Message.msg" NAME_WE)
add_dependencies(ex1_serial_generate_messages_cpp _ex1_serial_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/rovertx2/HERO_EX1/src/ex1_serial/msg/Telemetry.msg" NAME_WE)
add_dependencies(ex1_serial_generate_messages_cpp _ex1_serial_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/rovertx2/HERO_EX1/src/ex1_serial/msg/Read.msg" NAME_WE)
add_dependencies(ex1_serial_generate_messages_cpp _ex1_serial_generate_messages_check_deps_${_filename})

# target for backward compatibility
add_custom_target(ex1_serial_gencpp)
add_dependencies(ex1_serial_gencpp ex1_serial_generate_messages_cpp)

# register target for catkin_package(EXPORTED_TARGETS)
list(APPEND ${PROJECT_NAME}_EXPORTED_TARGETS ex1_serial_generate_messages_cpp)

### Section generating for lang: geneus
### Generating Messages
_generate_msg_eus(ex1_serial
  "/home/rovertx2/HERO_EX1/src/ex1_serial/msg/Message.msg"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${geneus_INSTALL_DIR}/ex1_serial
)
_generate_msg_eus(ex1_serial
  "/home/rovertx2/HERO_EX1/src/ex1_serial/msg/Read.msg"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${geneus_INSTALL_DIR}/ex1_serial
)
_generate_msg_eus(ex1_serial
  "/home/rovertx2/HERO_EX1/src/ex1_serial/msg/Telemetry.msg"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${geneus_INSTALL_DIR}/ex1_serial
)
_generate_msg_eus(ex1_serial
  "/home/rovertx2/HERO_EX1/src/ex1_serial/msg/Send.msg"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${geneus_INSTALL_DIR}/ex1_serial
)

### Generating Services

### Generating Module File
_generate_module_eus(ex1_serial
  ${CATKIN_DEVEL_PREFIX}/${geneus_INSTALL_DIR}/ex1_serial
  "${ALL_GEN_OUTPUT_FILES_eus}"
)

add_custom_target(ex1_serial_generate_messages_eus
  DEPENDS ${ALL_GEN_OUTPUT_FILES_eus}
)
add_dependencies(ex1_serial_generate_messages ex1_serial_generate_messages_eus)

# add dependencies to all check dependencies targets
get_filename_component(_filename "/home/rovertx2/HERO_EX1/src/ex1_serial/msg/Send.msg" NAME_WE)
add_dependencies(ex1_serial_generate_messages_eus _ex1_serial_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/rovertx2/HERO_EX1/src/ex1_serial/msg/Message.msg" NAME_WE)
add_dependencies(ex1_serial_generate_messages_eus _ex1_serial_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/rovertx2/HERO_EX1/src/ex1_serial/msg/Telemetry.msg" NAME_WE)
add_dependencies(ex1_serial_generate_messages_eus _ex1_serial_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/rovertx2/HERO_EX1/src/ex1_serial/msg/Read.msg" NAME_WE)
add_dependencies(ex1_serial_generate_messages_eus _ex1_serial_generate_messages_check_deps_${_filename})

# target for backward compatibility
add_custom_target(ex1_serial_geneus)
add_dependencies(ex1_serial_geneus ex1_serial_generate_messages_eus)

# register target for catkin_package(EXPORTED_TARGETS)
list(APPEND ${PROJECT_NAME}_EXPORTED_TARGETS ex1_serial_generate_messages_eus)

### Section generating for lang: genlisp
### Generating Messages
_generate_msg_lisp(ex1_serial
  "/home/rovertx2/HERO_EX1/src/ex1_serial/msg/Message.msg"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/ex1_serial
)
_generate_msg_lisp(ex1_serial
  "/home/rovertx2/HERO_EX1/src/ex1_serial/msg/Read.msg"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/ex1_serial
)
_generate_msg_lisp(ex1_serial
  "/home/rovertx2/HERO_EX1/src/ex1_serial/msg/Telemetry.msg"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/ex1_serial
)
_generate_msg_lisp(ex1_serial
  "/home/rovertx2/HERO_EX1/src/ex1_serial/msg/Send.msg"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/ex1_serial
)

### Generating Services

### Generating Module File
_generate_module_lisp(ex1_serial
  ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/ex1_serial
  "${ALL_GEN_OUTPUT_FILES_lisp}"
)

add_custom_target(ex1_serial_generate_messages_lisp
  DEPENDS ${ALL_GEN_OUTPUT_FILES_lisp}
)
add_dependencies(ex1_serial_generate_messages ex1_serial_generate_messages_lisp)

# add dependencies to all check dependencies targets
get_filename_component(_filename "/home/rovertx2/HERO_EX1/src/ex1_serial/msg/Send.msg" NAME_WE)
add_dependencies(ex1_serial_generate_messages_lisp _ex1_serial_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/rovertx2/HERO_EX1/src/ex1_serial/msg/Message.msg" NAME_WE)
add_dependencies(ex1_serial_generate_messages_lisp _ex1_serial_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/rovertx2/HERO_EX1/src/ex1_serial/msg/Telemetry.msg" NAME_WE)
add_dependencies(ex1_serial_generate_messages_lisp _ex1_serial_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/rovertx2/HERO_EX1/src/ex1_serial/msg/Read.msg" NAME_WE)
add_dependencies(ex1_serial_generate_messages_lisp _ex1_serial_generate_messages_check_deps_${_filename})

# target for backward compatibility
add_custom_target(ex1_serial_genlisp)
add_dependencies(ex1_serial_genlisp ex1_serial_generate_messages_lisp)

# register target for catkin_package(EXPORTED_TARGETS)
list(APPEND ${PROJECT_NAME}_EXPORTED_TARGETS ex1_serial_generate_messages_lisp)

### Section generating for lang: gennodejs
### Generating Messages
_generate_msg_nodejs(ex1_serial
  "/home/rovertx2/HERO_EX1/src/ex1_serial/msg/Message.msg"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${gennodejs_INSTALL_DIR}/ex1_serial
)
_generate_msg_nodejs(ex1_serial
  "/home/rovertx2/HERO_EX1/src/ex1_serial/msg/Read.msg"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${gennodejs_INSTALL_DIR}/ex1_serial
)
_generate_msg_nodejs(ex1_serial
  "/home/rovertx2/HERO_EX1/src/ex1_serial/msg/Telemetry.msg"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${gennodejs_INSTALL_DIR}/ex1_serial
)
_generate_msg_nodejs(ex1_serial
  "/home/rovertx2/HERO_EX1/src/ex1_serial/msg/Send.msg"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${gennodejs_INSTALL_DIR}/ex1_serial
)

### Generating Services

### Generating Module File
_generate_module_nodejs(ex1_serial
  ${CATKIN_DEVEL_PREFIX}/${gennodejs_INSTALL_DIR}/ex1_serial
  "${ALL_GEN_OUTPUT_FILES_nodejs}"
)

add_custom_target(ex1_serial_generate_messages_nodejs
  DEPENDS ${ALL_GEN_OUTPUT_FILES_nodejs}
)
add_dependencies(ex1_serial_generate_messages ex1_serial_generate_messages_nodejs)

# add dependencies to all check dependencies targets
get_filename_component(_filename "/home/rovertx2/HERO_EX1/src/ex1_serial/msg/Send.msg" NAME_WE)
add_dependencies(ex1_serial_generate_messages_nodejs _ex1_serial_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/rovertx2/HERO_EX1/src/ex1_serial/msg/Message.msg" NAME_WE)
add_dependencies(ex1_serial_generate_messages_nodejs _ex1_serial_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/rovertx2/HERO_EX1/src/ex1_serial/msg/Telemetry.msg" NAME_WE)
add_dependencies(ex1_serial_generate_messages_nodejs _ex1_serial_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/rovertx2/HERO_EX1/src/ex1_serial/msg/Read.msg" NAME_WE)
add_dependencies(ex1_serial_generate_messages_nodejs _ex1_serial_generate_messages_check_deps_${_filename})

# target for backward compatibility
add_custom_target(ex1_serial_gennodejs)
add_dependencies(ex1_serial_gennodejs ex1_serial_generate_messages_nodejs)

# register target for catkin_package(EXPORTED_TARGETS)
list(APPEND ${PROJECT_NAME}_EXPORTED_TARGETS ex1_serial_generate_messages_nodejs)

### Section generating for lang: genpy
### Generating Messages
_generate_msg_py(ex1_serial
  "/home/rovertx2/HERO_EX1/src/ex1_serial/msg/Message.msg"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/ex1_serial
)
_generate_msg_py(ex1_serial
  "/home/rovertx2/HERO_EX1/src/ex1_serial/msg/Read.msg"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/ex1_serial
)
_generate_msg_py(ex1_serial
  "/home/rovertx2/HERO_EX1/src/ex1_serial/msg/Telemetry.msg"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/ex1_serial
)
_generate_msg_py(ex1_serial
  "/home/rovertx2/HERO_EX1/src/ex1_serial/msg/Send.msg"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/ex1_serial
)

### Generating Services

### Generating Module File
_generate_module_py(ex1_serial
  ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/ex1_serial
  "${ALL_GEN_OUTPUT_FILES_py}"
)

add_custom_target(ex1_serial_generate_messages_py
  DEPENDS ${ALL_GEN_OUTPUT_FILES_py}
)
add_dependencies(ex1_serial_generate_messages ex1_serial_generate_messages_py)

# add dependencies to all check dependencies targets
get_filename_component(_filename "/home/rovertx2/HERO_EX1/src/ex1_serial/msg/Send.msg" NAME_WE)
add_dependencies(ex1_serial_generate_messages_py _ex1_serial_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/rovertx2/HERO_EX1/src/ex1_serial/msg/Message.msg" NAME_WE)
add_dependencies(ex1_serial_generate_messages_py _ex1_serial_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/rovertx2/HERO_EX1/src/ex1_serial/msg/Telemetry.msg" NAME_WE)
add_dependencies(ex1_serial_generate_messages_py _ex1_serial_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/rovertx2/HERO_EX1/src/ex1_serial/msg/Read.msg" NAME_WE)
add_dependencies(ex1_serial_generate_messages_py _ex1_serial_generate_messages_check_deps_${_filename})

# target for backward compatibility
add_custom_target(ex1_serial_genpy)
add_dependencies(ex1_serial_genpy ex1_serial_generate_messages_py)

# register target for catkin_package(EXPORTED_TARGETS)
list(APPEND ${PROJECT_NAME}_EXPORTED_TARGETS ex1_serial_generate_messages_py)



if(gencpp_INSTALL_DIR AND EXISTS ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/ex1_serial)
  # install generated code
  install(
    DIRECTORY ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/ex1_serial
    DESTINATION ${gencpp_INSTALL_DIR}
  )
endif()
if(TARGET std_msgs_generate_messages_cpp)
  add_dependencies(ex1_serial_generate_messages_cpp std_msgs_generate_messages_cpp)
endif()

if(geneus_INSTALL_DIR AND EXISTS ${CATKIN_DEVEL_PREFIX}/${geneus_INSTALL_DIR}/ex1_serial)
  # install generated code
  install(
    DIRECTORY ${CATKIN_DEVEL_PREFIX}/${geneus_INSTALL_DIR}/ex1_serial
    DESTINATION ${geneus_INSTALL_DIR}
  )
endif()
if(TARGET std_msgs_generate_messages_eus)
  add_dependencies(ex1_serial_generate_messages_eus std_msgs_generate_messages_eus)
endif()

if(genlisp_INSTALL_DIR AND EXISTS ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/ex1_serial)
  # install generated code
  install(
    DIRECTORY ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/ex1_serial
    DESTINATION ${genlisp_INSTALL_DIR}
  )
endif()
if(TARGET std_msgs_generate_messages_lisp)
  add_dependencies(ex1_serial_generate_messages_lisp std_msgs_generate_messages_lisp)
endif()

if(gennodejs_INSTALL_DIR AND EXISTS ${CATKIN_DEVEL_PREFIX}/${gennodejs_INSTALL_DIR}/ex1_serial)
  # install generated code
  install(
    DIRECTORY ${CATKIN_DEVEL_PREFIX}/${gennodejs_INSTALL_DIR}/ex1_serial
    DESTINATION ${gennodejs_INSTALL_DIR}
  )
endif()
if(TARGET std_msgs_generate_messages_nodejs)
  add_dependencies(ex1_serial_generate_messages_nodejs std_msgs_generate_messages_nodejs)
endif()

if(genpy_INSTALL_DIR AND EXISTS ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/ex1_serial)
  install(CODE "execute_process(COMMAND \"/usr/bin/python2\" -m compileall \"${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/ex1_serial\")")
  # install generated code
  install(
    DIRECTORY ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/ex1_serial
    DESTINATION ${genpy_INSTALL_DIR}
  )
endif()
if(TARGET std_msgs_generate_messages_py)
  add_dependencies(ex1_serial_generate_messages_py std_msgs_generate_messages_py)
endif()
