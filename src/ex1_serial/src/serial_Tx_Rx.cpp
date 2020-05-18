/*
Content: This script creates a node that subscribes to the send topic and send the message through USB. This node also reads telemetry streamed bytes from the same USB.
Two MCUs are used to control the motors. One for the left rocker wheels, and another for the right rocker wheels. Therefore, two signals, each through different USB ports are sent.  
Created by: David Rodriguez (davidrm@dc.tohoku.ac.jp)
Last update: Nov. 23, 2019
Updated by: David Rodriguez (davidrm@dc.tohoku.ac.jp)
*/

//Includes
#include <ros/ros.h>
#include <string>
//Message types necessary
#include <serial/serial.h>
#include <ex1_serial/Send.h>
#include <ex1_serial/Read.h>

//Classes & global variables
serial::Serial usb;
serial::Timeout to = serial::Timeout::simpleTimeout(200);
std::string port_left, port_right;
int baudrate, rocker_id;

//Functions
void cobsMessageReceived(const ex1_serial::Send& snd){
	ROS_DEBUG_STREAM("Writing to serial port.");
	usb.write((uint8_t*)(&(snd.data[0])), snd.size);
}

//Main 
int main(int argc, char** argv){
	
	ros::init(argc, argv, "usb");
	ros::NodeHandle p_nh("~");	
	ros::NodeHandle nh;

	//We fetch node id.
	p_nh.getParam("rocker_id", rocker_id);

	//We fetch buttons&axes map from the parameter server (defined in teleop.launch). 
	nh.getParam("port_left", port_left);
	nh.getParam("port_right", port_right);
	nh.getParam("baudrate", baudrate);

	ros::Subscriber sub;
	ros::Publisher pub;

	//Subscribe to different topics based on the rocker_id of the node. (see ex1_serial.launch)
	if(rocker_id == 1)//left rocker
	{
		sub = nh.subscribe("send_left", 200, &cobsMessageReceived);
	}else if(rocker_id == 2) // right rocker
	{
		sub = nh.subscribe("send_right", 200, &cobsMessageReceived);
	}else {
		ROS_INFO_STREAM("WARNING #2 - No rocker_id found.");
	}
	
	//Publish on different topics based on the rocker_id of the node. (see ex1_serial.launch)
	if(rocker_id == 1)//left rocker
	{
		pub = nh.advertise<ex1_serial::Read>("read_left", 200);
	}else if(rocker_id == 2) // right rocker
	{
		pub = nh.advertise<ex1_serial::Read>("read_right", 200);
	}else {
		ROS_INFO_STREAM("WARNING #2 - No rocker_id found.");
	}	

	//Establish communication
	try
	{
		//First, set port based on rocker_id.
		if(rocker_id == 1)//left rocker
		{
			usb.setPort(port_left);
		}else if(rocker_id == 2) // right rocker
		{
			usb.setPort(port_right);
		}
		//Set internal communication parameters and open communication. 
		usb.setBaudrate((uint32_t)baudrate);
		usb.setTimeout(to);		
		usb.open();
	}
	catch (serial::IOException& e)
	{
		if(rocker_id == 1)//left rocker
		{
			ROS_ERROR_STREAM("ERROR #1 - Unable to open port: " << port_left);
		}else if(rocker_id == 2) // right rocker
		{
			ROS_ERROR_STREAM("ERROR #1 - Unable to open port: " << port_right);
		}		
		return -1;
	}

	if(usb.isOpen()){
		ROS_DEBUG_STREAM("Serial Port Initialized.");}
	else{
		return -1;
	}

	ros::Rate loop_rate(1000);
	while(ros::ok()){

		ros::spinOnce();
		
		//Read from the byte streams of telemetry data coming from USB.
		if(usb.available()){
			ROS_DEBUG_STREAM("Reading from serial port.");
			ex1_serial::Read tmt;
			uint8_t buffer[200]; 
			usb.read(buffer,1);
			tmt.data = buffer[0];
			pub.publish(tmt);
		}
		loop_rate.sleep();
    	}
	return 0;
}

