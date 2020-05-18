# HERO Explorer 1 Rover - Software

The following contains the high-level control system and full catkin workspace required to run the EX1 rover main computer (NVIDIA Jetson TX2). 
EX1 operates under Robot Operating System (ROS) Melodic release framework.

## Getting Started

These instructions will get you a copy of the project up and running on your local machine for development and testing purposes. 

### Prerequisites

* [NVIDA Jetson TX2 L4T 32.2.0](https://developer.nvidia.com/embedded/linux-tegra)
* [Ubuntu 18.04](http://releases.ubuntu.com/18.04/)
* [ROS Melodic Morenia](http://wiki.ros.org/melodic)
* [Serial Port Library in C++](https://github.com/wjwwood/serial)
* [ROS driver for a generic joystick](http://wiki.ros.org/joy)

### Installing

First, create a new folder where your workspace will be hosted and clone this repository into your local machine. 

```
$ mkdir HERO_EX1
$ cd HERO_EX1
$ git clone https://davidrodriguezSRL@bitbucket.org/hero_team/hero_ex1_sw.git
```

Make sure to source your ROS environment setup file as well as the rover workspace setup file by adding the following two lines at the end of the .bashrc file. Adding these two lines to the .bashrc script avoids having to source the setup file everytime a  new terminal is open.

```
source /opt/ros/melodic/setup.bash
source HERO_EX1/devel/setup.bash
``` 

Finally, make the catkin workspace using the following command. 

```
#In HERO_EX1 workspace
$ catkin_make
```

Make sure all dependencies are solved before moving on. 

## Running the tests

To make sure the workspace has being successfully built launch the wake_up launch file. This launch file will automatically launch all the required nodes to teleoperate the rover. 

```
$ roslaunch ex1_startup wake_up.launch
```

## Recording telemetry

In order to start the rover up while recording telemetry from motors rotational encoders, driving motors current sensors, rocker sensors, and IMU sensor, telemetry has to be activated. To do that, pass the following argument when calling roslaunch from the command line.

```
$ roslaunch ex1_startup wake_up.launch telemetry:=true
``` 
Telemetry is switched off by default. This can be changed in the wake_up.launch file.

## Versioning

High-speed Exploration Rover Team, Explorer 1 Operating System Version 1. Rev. 0. 

## Authors

* **David Rodriguez** - *PI, High-level developer*
* **Alan Allart** - *Low-level developer*

See also a list of contributors

* **Kazuki Nakagoshi** - *Manufacturing & international relationships*
* **Tristan Lecocq** - *Power system developer*
* **Sayo Sugimori** - *Secretary*
* **Kazuya Yoshida** - *Professor, Space Robotics Lab*

## License
MIT

## References

NVIDIA JETSON TX2 Product Design Guide: 
https://usermanual.wiki/Pdf/jetsontx2oemproductdesignguide.2134990230/view

NVIDIA JETSON TX2 Auto power-on: 
https://devtalk.nvidia.com/default/topic/999406/jetson-tx2/auto-power-on-implementation-based-on-oem-product-design-guide/


