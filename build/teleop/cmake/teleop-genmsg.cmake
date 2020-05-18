# generated from genmsg/cmake/pkg-genmsg.cmake.em

message(STATUS "teleop: 1 messages, 0 services")

set(MSG_I_FLAGS "-Iteleop:/home/rovertx2/HERO_EX1/src/teleop/msg;-Istd_msgs:/opt/ros/melodic/share/std_msgs/cmake/../msg")

# Find all generators
find_package(gencpp REQUIRED)
find_package(geneus REQUIRED)
find_package(genlisp REQUIRED)
find_package(gennodejs REQUIRED)
find_package(genpy REQUIRED)

add_custom_target(teleop_generate_messages ALL)

# verify that message/service dependencies have not changed since configure



get_filename_component(_filename "/home/rovertx2/HERO_EX1/src/teleop/msg/Command.msg" NAME_WE)
add_custom_target(_teleop_generate_messages_check_deps_${_filename}
  COMMAND ${CATKIN_ENV} ${PYTHON_EXECUTABLE} ${GENMSG_CHECK_DEPS_SCRIPT} "teleop" "/home/rovertx2/HERO_EX1/src/teleop/msg/Command.msg" ""
)

#
#  langs = gencpp;geneus;genlisp;gennodejs;genpy
#

### Section generating for lang: gencpp
### Generating Messages
_generate_msg_cpp(teleop
  "/home/rovertx2/HERO_EX1/src/teleop/msg/Command.msg"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/teleop
)

### Generating Services

### Generating Module File
_generate_module_cpp(teleop
  ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/teleop
  "${ALL_GEN_OUTPUT_FILES_cpp}"
)

add_custom_target(teleop_generate_messages_cpp
  DEPENDS ${ALL_GEN_OUTPUT_FILES_cpp}
)
add_dependencies(teleop_generate_messages teleop_generate_messages_cpp)

# add dependencies to all check dependencies targets
get_filename_component(_filename "/home/rovertx2/HERO_EX1/src/teleop/msg/Command.msg" NAME_WE)
add_dependencies(teleop_generate_messages_cpp _teleop_generate_messages_check_deps_${_filename})

# target for backward compatibility
add_custom_target(teleop_gencpp)
add_dependencies(teleop_gencpp teleop_generate_messages_cpp)

# register target for catkin_package(EXPORTED_TARGETS)
list(APPEND ${PROJECT_NAME}_EXPORTED_TARGETS teleop_generate_messages_cpp)

### Section generating for lang: geneus
### Generating Messages
_generate_msg_eus(teleop
  "/home/rovertx2/HERO_EX1/src/teleop/msg/Command.msg"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${geneus_INSTALL_DIR}/teleop
)

### Generating Services

### Generating Module File
_generate_module_eus(teleop
  ${CATKIN_DEVEL_PREFIX}/${geneus_INSTALL_DIR}/teleop
  "${ALL_GEN_OUTPUT_FILES_eus}"
)

add_custom_target(teleop_generate_messages_eus
  DEPENDS ${ALL_GEN_OUTPUT_FILES_eus}
)
add_dependencies(teleop_generate_messages teleop_generate_messages_eus)

# add dependencies to all check dependencies targets
get_filename_component(_filename "/home/rovertx2/HERO_EX1/src/teleop/msg/Command.msg" NAME_WE)
add_dependencies(teleop_generate_messages_eus _teleop_generate_messages_check_deps_${_filename})

# target for backward compatibility
add_custom_target(teleop_geneus)
add_dependencies(teleop_geneus teleop_generate_messages_eus)

# register target for catkin_package(EXPORTED_TARGETS)
list(APPEND ${PROJECT_NAME}_EXPORTED_TARGETS teleop_generate_messages_eus)

### Section generating for lang: genlisp
### Generating Messages
_generate_msg_lisp(teleop
  "/home/rovertx2/HERO_EX1/src/teleop/msg/Command.msg"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/teleop
)

### Generating Services

### Generating Module File
_generate_module_lisp(teleop
  ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/teleop
  "${ALL_GEN_OUTPUT_FILES_lisp}"
)

add_custom_target(teleop_generate_messages_lisp
  DEPENDS ${ALL_GEN_OUTPUT_FILES_lisp}
)
add_dependencies(teleop_generate_messages teleop_generate_messages_lisp)

# add dependencies to all check dependencies targets
get_filename_component(_filename "/home/rovertx2/HERO_EX1/src/teleop/msg/Command.msg" NAME_WE)
add_dependencies(teleop_generate_messages_lisp _teleop_generate_messages_check_deps_${_filename})

# target for backward compatibility
add_custom_target(teleop_genlisp)
add_dependencies(teleop_genlisp teleop_generate_messages_lisp)

# register target for catkin_package(EXPORTED_TARGETS)
list(APPEND ${PROJECT_NAME}_EXPORTED_TARGETS teleop_generate_messages_lisp)

### Section generating for lang: gennodejs
### Generating Messages
_generate_msg_nodejs(teleop
  "/home/rovertx2/HERO_EX1/src/teleop/msg/Command.msg"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${gennodejs_INSTALL_DIR}/teleop
)

### Generating Services

### Generating Module File
_generate_module_nodejs(teleop
  ${CATKIN_DEVEL_PREFIX}/${gennodejs_INSTALL_DIR}/teleop
  "${ALL_GEN_OUTPUT_FILES_nodejs}"
)

add_custom_target(teleop_generate_messages_nodejs
  DEPENDS ${ALL_GEN_OUTPUT_FILES_nodejs}
)
add_dependencies(teleop_generate_messages teleop_generate_messages_nodejs)

# add dependencies to all check dependencies targets
get_filename_component(_filename "/home/rovertx2/HERO_EX1/src/teleop/msg/Command.msg" NAME_WE)
add_dependencies(teleop_generate_messages_nodejs _teleop_generate_messages_check_deps_${_filename})

# target for backward compatibility
add_custom_target(teleop_gennodejs)
add_dependencies(teleop_gennodejs teleop_generate_messages_nodejs)

# register target for catkin_package(EXPORTED_TARGETS)
list(APPEND ${PROJECT_NAME}_EXPORTED_TARGETS teleop_generate_messages_nodejs)

### Section generating for lang: genpy
### Generating Messages
_generate_msg_py(teleop
  "/home/rovertx2/HERO_EX1/src/teleop/msg/Command.msg"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/teleop
)

### Generating Services

### Generating Module File
_generate_module_py(teleop
  ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/teleop
  "${ALL_GEN_OUTPUT_FILES_py}"
)

add_custom_target(teleop_generate_messages_py
  DEPENDS ${ALL_GEN_OUTPUT_FILES_py}
)
add_dependencies(teleop_generate_messages teleop_generate_messages_py)

# add dependencies to all check dependencies targets
get_filename_component(_filename "/home/rovertx2/HERO_EX1/src/teleop/msg/Command.msg" NAME_WE)
add_dependencies(teleop_generate_messages_py _teleop_generate_messages_check_deps_${_filename})

# target for backward compatibility
add_custom_target(teleop_genpy)
add_dependencies(teleop_genpy teleop_generate_messages_py)

# register target for catkin_package(EXPORTED_TARGETS)
list(APPEND ${PROJECT_NAME}_EXPORTED_TARGETS teleop_generate_messages_py)



if(gencpp_INSTALL_DIR AND EXISTS ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/teleop)
  # install generated code
  install(
    DIRECTORY ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/teleop
    DESTINATION ${gencpp_INSTALL_DIR}
  )
endif()
if(TARGET std_msgs_generate_messages_cpp)
  add_dependencies(teleop_generate_messages_cpp std_msgs_generate_messages_cpp)
endif()

if(geneus_INSTALL_DIR AND EXISTS ${CATKIN_DEVEL_PREFIX}/${geneus_INSTALL_DIR}/teleop)
  # install generated code
  install(
    DIRECTORY ${CATKIN_DEVEL_PREFIX}/${geneus_INSTALL_DIR}/teleop
    DESTINATION ${geneus_INSTALL_DIR}
  )
endif()
if(TARGET std_msgs_generate_messages_eus)
  add_dependencies(teleop_generate_messages_eus std_msgs_generate_messages_eus)
endif()

if(genlisp_INSTALL_DIR AND EXISTS ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/teleop)
  # install generated code
  install(
    DIRECTORY ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/teleop
    DESTINATION ${genlisp_INSTALL_DIR}
  )
endif()
if(TARGET std_msgs_generate_messages_lisp)
  add_dependencies(teleop_generate_messages_lisp std_msgs_generate_messages_lisp)
endif()

if(gennodejs_INSTALL_DIR AND EXISTS ${CATKIN_DEVEL_PREFIX}/${gennodejs_INSTALL_DIR}/teleop)
  # install generated code
  install(
    DIRECTORY ${CATKIN_DEVEL_PREFIX}/${gennodejs_INSTALL_DIR}/teleop
    DESTINATION ${gennodejs_INSTALL_DIR}
  )
endif()
if(TARGET std_msgs_generate_messages_nodejs)
  add_dependencies(teleop_generate_messages_nodejs std_msgs_generate_messages_nodejs)
endif()

if(genpy_INSTALL_DIR AND EXISTS ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/teleop)
  install(CODE "execute_process(COMMAND \"/usr/bin/python2\" -m compileall \"${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/teleop\")")
  # install generated code
  install(
    DIRECTORY ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/teleop
    DESTINATION ${genpy_INSTALL_DIR}
  )
endif()
if(TARGET std_msgs_generate_messages_py)
  add_dependencies(teleop_generate_messages_py std_msgs_generate_messages_py)
endif()
