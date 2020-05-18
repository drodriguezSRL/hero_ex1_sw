/*
Content: This script creates a node that reads form the message topic and frames the packet using COBS.
Dependencies: ex1_serial | 
Created by: David Rodriguez (davidrm@dc.tohoku.ac.jp)
Last update: Nov. 12, 2019
Updated by: David Rodriguez (davidrm@dc.tohoku.ac.jp)
*/

//Inlcudes
#include <ros/ros.h>
#include <vector>
//Message types necessary
#include <ex1_serial/Message.h>
#include <ex1_serial/Send.h>

//Classes and global variables
class Cobs
{
private:
	//private parameters
	int rocker_id;
	
	void crcMessageReceived(const ex1_serial::Message& msg);
	void cobsByteStuffing(const std::vector<uint8_t> &src, uint8_t dst[], const size_t size);
	int COBS_DELIMETER;
	ros::NodeHandle p_nh;	
	ros::NodeHandle nh;
	ros::Subscriber sub;
	ros::Publisher pub;
public:
	Cobs(); //constructor
};

//Functions
/* Constructor */
Cobs::Cobs(): p_nh("~")
{
	nh.getParam("COBS_DELIMETER", COBS_DELIMETER);
	
	//We fetch node id.
	p_nh.getParam("rocker_id", rocker_id);
	
	//Subscribe to different topics based on the rocker_id of the node. (see ex1_serial.launch)
	if(rocker_id == 1)//left rocker
	{
		sub = nh.subscribe("message_left", 200, &Cobs::crcMessageReceived, this);
	}else if(rocker_id == 2) // right rocker
	{
		sub = nh.subscribe("message_right", 200, &Cobs::crcMessageReceived, this);
	}else {
		ROS_WARN_STREAM("WARNING #2 - No rocker_id found.");
	}

	//Advertise serial message based on the rocker_id.
	if(rocker_id == 1)//left rocker
	{
		pub = nh.advertise<ex1_serial::Send>("send_left", 200);
	}else if(rocker_id == 2) // right rocker
	{
		pub = nh.advertise<ex1_serial::Send>("send_right", 200);
	}else {
		ROS_WARN_STREAM("WARNING #2 - No rocker_id found.");
	}	
}

/* COBS, Consistent Overhead Byte Stuffing */
void Cobs::cobsByteStuffing( const std::vector<uint8_t> &src, uint8_t dst[], const size_t src_size){
	int srcIndex = 0;
	int dstIndex = 1;
	int codeIndex = 1;
	uint8_t codeBlock_size = COBS_DELIMETER + 1;

	//We scout the source message (src) for COBS_DELIMETER in order to define the different COBS code blocks.
	while(srcIndex < src_size)
	{
		if(src.at(srcIndex) == COBS_DELIMETER)
		{
			//Define code byte.
			dst[codeIndex] = codeBlock_size;
			dstIndex++;
			codeIndex = dstIndex;
			//Reinitialize code block size.
			codeBlock_size = COBS_DELIMETER + 1;
					
		}else{
			//Stuff code block.
			dstIndex++;			
			dst[dstIndex] = src.at(srcIndex);
			codeBlock_size++;
		}
		srcIndex++;
	}
	
	//Stuff the code byte for the final block.
	dst[codeIndex] = codeBlock_size;
	//Final framing with leading and trailing COBS_DELIMETER. 
	dst[0] = COBS_DELIMETER; 
	dst[src_size + 2] = COBS_DELIMETER;
}

/* Callback function */
void Cobs::crcMessageReceived(const ex1_serial::Message& msg)
{
	//Use this call back to fill in the advertise message
	ex1_serial::Send snd;
	//A message will only be sent through USB when commands are sent. 
	if(msg.size != 0){
		uint8_t dst[msg.size + 3];

		// Perform COBS.
		cobsByteStuffing(msg.data, dst, msg.size);
		
		//Fill in final packet.
		for(size_t i = 0; i <= (msg.size + 2); i++)
		{
			snd.data.push_back(dst[i]);
		}
		snd.size = snd.data.size();
		pub.publish(snd);
	}
}

//Main

int main(int argc, char **argv)
{
	ros::init(argc, argv, "cobs");
	//Create a Cobs object. This will call the Cobs() function automatically. 
	Cobs cobs_msg;
	ros::spin();
	return 0;
}
