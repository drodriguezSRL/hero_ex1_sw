# CMAKE generated file: DO NOT EDIT!
# Generated by "Unix Makefiles" Generator, CMake Version 3.10

# Delete rule output on recipe failure.
.DELETE_ON_ERROR:


#=============================================================================
# Special targets provided by cmake.

# Disable implicit rules so canonical targets will work.
.SUFFIXES:


# Remove some rules from gmake that .SUFFIXES does not remove.
SUFFIXES =

.SUFFIXES: .hpux_make_needs_suffix_list


# Suppress display of executed commands.
$(VERBOSE).SILENT:


# A target that is always out of date.
cmake_force:

.PHONY : cmake_force

#=============================================================================
# Set environment variables for the build.

# The shell in which to execute make rules.
SHELL = /bin/sh

# The CMake executable.
CMAKE_COMMAND = /usr/bin/cmake

# The command to remove a file.
RM = /usr/bin/cmake -E remove -f

# Escaping for special characters.
EQUALS = =

# The top-level source directory on which CMake was run.
CMAKE_SOURCE_DIR = /home/rovertx2/HERO_EX1/src

# The top-level build directory on which CMake was run.
CMAKE_BINARY_DIR = /home/rovertx2/HERO_EX1/build

# Include any dependencies generated for this target.
include ex1_serial/CMakeFiles/add_crc.dir/depend.make

# Include the progress variables for this target.
include ex1_serial/CMakeFiles/add_crc.dir/progress.make

# Include the compile flags for this target's objects.
include ex1_serial/CMakeFiles/add_crc.dir/flags.make

ex1_serial/CMakeFiles/add_crc.dir/src/add_crc.cpp.o: ex1_serial/CMakeFiles/add_crc.dir/flags.make
ex1_serial/CMakeFiles/add_crc.dir/src/add_crc.cpp.o: /home/rovertx2/HERO_EX1/src/ex1_serial/src/add_crc.cpp
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green --progress-dir=/home/rovertx2/HERO_EX1/build/CMakeFiles --progress-num=$(CMAKE_PROGRESS_1) "Building CXX object ex1_serial/CMakeFiles/add_crc.dir/src/add_crc.cpp.o"
	cd /home/rovertx2/HERO_EX1/build/ex1_serial && /usr/bin/c++  $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -o CMakeFiles/add_crc.dir/src/add_crc.cpp.o -c /home/rovertx2/HERO_EX1/src/ex1_serial/src/add_crc.cpp

ex1_serial/CMakeFiles/add_crc.dir/src/add_crc.cpp.i: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Preprocessing CXX source to CMakeFiles/add_crc.dir/src/add_crc.cpp.i"
	cd /home/rovertx2/HERO_EX1/build/ex1_serial && /usr/bin/c++ $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -E /home/rovertx2/HERO_EX1/src/ex1_serial/src/add_crc.cpp > CMakeFiles/add_crc.dir/src/add_crc.cpp.i

ex1_serial/CMakeFiles/add_crc.dir/src/add_crc.cpp.s: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Compiling CXX source to assembly CMakeFiles/add_crc.dir/src/add_crc.cpp.s"
	cd /home/rovertx2/HERO_EX1/build/ex1_serial && /usr/bin/c++ $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -S /home/rovertx2/HERO_EX1/src/ex1_serial/src/add_crc.cpp -o CMakeFiles/add_crc.dir/src/add_crc.cpp.s

ex1_serial/CMakeFiles/add_crc.dir/src/add_crc.cpp.o.requires:

.PHONY : ex1_serial/CMakeFiles/add_crc.dir/src/add_crc.cpp.o.requires

ex1_serial/CMakeFiles/add_crc.dir/src/add_crc.cpp.o.provides: ex1_serial/CMakeFiles/add_crc.dir/src/add_crc.cpp.o.requires
	$(MAKE) -f ex1_serial/CMakeFiles/add_crc.dir/build.make ex1_serial/CMakeFiles/add_crc.dir/src/add_crc.cpp.o.provides.build
.PHONY : ex1_serial/CMakeFiles/add_crc.dir/src/add_crc.cpp.o.provides

ex1_serial/CMakeFiles/add_crc.dir/src/add_crc.cpp.o.provides.build: ex1_serial/CMakeFiles/add_crc.dir/src/add_crc.cpp.o


# Object files for target add_crc
add_crc_OBJECTS = \
"CMakeFiles/add_crc.dir/src/add_crc.cpp.o"

# External object files for target add_crc
add_crc_EXTERNAL_OBJECTS =

/home/rovertx2/HERO_EX1/devel/lib/ex1_serial/add_crc: ex1_serial/CMakeFiles/add_crc.dir/src/add_crc.cpp.o
/home/rovertx2/HERO_EX1/devel/lib/ex1_serial/add_crc: ex1_serial/CMakeFiles/add_crc.dir/build.make
/home/rovertx2/HERO_EX1/devel/lib/ex1_serial/add_crc: /opt/ros/melodic/lib/libroscpp.so
/home/rovertx2/HERO_EX1/devel/lib/ex1_serial/add_crc: /usr/lib/aarch64-linux-gnu/libboost_filesystem.so
/home/rovertx2/HERO_EX1/devel/lib/ex1_serial/add_crc: /usr/lib/aarch64-linux-gnu/libboost_signals.so
/home/rovertx2/HERO_EX1/devel/lib/ex1_serial/add_crc: /opt/ros/melodic/lib/librosconsole.so
/home/rovertx2/HERO_EX1/devel/lib/ex1_serial/add_crc: /opt/ros/melodic/lib/librosconsole_log4cxx.so
/home/rovertx2/HERO_EX1/devel/lib/ex1_serial/add_crc: /opt/ros/melodic/lib/librosconsole_backend_interface.so
/home/rovertx2/HERO_EX1/devel/lib/ex1_serial/add_crc: /usr/lib/aarch64-linux-gnu/liblog4cxx.so
/home/rovertx2/HERO_EX1/devel/lib/ex1_serial/add_crc: /usr/lib/aarch64-linux-gnu/libboost_regex.so
/home/rovertx2/HERO_EX1/devel/lib/ex1_serial/add_crc: /opt/ros/melodic/lib/libxmlrpcpp.so
/home/rovertx2/HERO_EX1/devel/lib/ex1_serial/add_crc: /opt/ros/melodic/lib/libroscpp_serialization.so
/home/rovertx2/HERO_EX1/devel/lib/ex1_serial/add_crc: /opt/ros/melodic/lib/librostime.so
/home/rovertx2/HERO_EX1/devel/lib/ex1_serial/add_crc: /opt/ros/melodic/lib/libcpp_common.so
/home/rovertx2/HERO_EX1/devel/lib/ex1_serial/add_crc: /usr/lib/aarch64-linux-gnu/libboost_system.so
/home/rovertx2/HERO_EX1/devel/lib/ex1_serial/add_crc: /usr/lib/aarch64-linux-gnu/libboost_thread.so
/home/rovertx2/HERO_EX1/devel/lib/ex1_serial/add_crc: /usr/lib/aarch64-linux-gnu/libboost_chrono.so
/home/rovertx2/HERO_EX1/devel/lib/ex1_serial/add_crc: /usr/lib/aarch64-linux-gnu/libboost_date_time.so
/home/rovertx2/HERO_EX1/devel/lib/ex1_serial/add_crc: /usr/lib/aarch64-linux-gnu/libboost_atomic.so
/home/rovertx2/HERO_EX1/devel/lib/ex1_serial/add_crc: /usr/lib/aarch64-linux-gnu/libpthread.so
/home/rovertx2/HERO_EX1/devel/lib/ex1_serial/add_crc: /usr/lib/aarch64-linux-gnu/libconsole_bridge.so.0.4
/home/rovertx2/HERO_EX1/devel/lib/ex1_serial/add_crc: /opt/ros/melodic/lib/libserial.so
/home/rovertx2/HERO_EX1/devel/lib/ex1_serial/add_crc: ex1_serial/CMakeFiles/add_crc.dir/link.txt
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green --bold --progress-dir=/home/rovertx2/HERO_EX1/build/CMakeFiles --progress-num=$(CMAKE_PROGRESS_2) "Linking CXX executable /home/rovertx2/HERO_EX1/devel/lib/ex1_serial/add_crc"
	cd /home/rovertx2/HERO_EX1/build/ex1_serial && $(CMAKE_COMMAND) -E cmake_link_script CMakeFiles/add_crc.dir/link.txt --verbose=$(VERBOSE)

# Rule to build all files generated by this target.
ex1_serial/CMakeFiles/add_crc.dir/build: /home/rovertx2/HERO_EX1/devel/lib/ex1_serial/add_crc

.PHONY : ex1_serial/CMakeFiles/add_crc.dir/build

ex1_serial/CMakeFiles/add_crc.dir/requires: ex1_serial/CMakeFiles/add_crc.dir/src/add_crc.cpp.o.requires

.PHONY : ex1_serial/CMakeFiles/add_crc.dir/requires

ex1_serial/CMakeFiles/add_crc.dir/clean:
	cd /home/rovertx2/HERO_EX1/build/ex1_serial && $(CMAKE_COMMAND) -P CMakeFiles/add_crc.dir/cmake_clean.cmake
.PHONY : ex1_serial/CMakeFiles/add_crc.dir/clean

ex1_serial/CMakeFiles/add_crc.dir/depend:
	cd /home/rovertx2/HERO_EX1/build && $(CMAKE_COMMAND) -E cmake_depends "Unix Makefiles" /home/rovertx2/HERO_EX1/src /home/rovertx2/HERO_EX1/src/ex1_serial /home/rovertx2/HERO_EX1/build /home/rovertx2/HERO_EX1/build/ex1_serial /home/rovertx2/HERO_EX1/build/ex1_serial/CMakeFiles/add_crc.dir/DependInfo.cmake --color=$(COLOR)
.PHONY : ex1_serial/CMakeFiles/add_crc.dir/depend

