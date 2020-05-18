/*
Content: This script creates a node that reads from the command topic, performs a cyclic redundancy check (CRC), and sends the final unframed packet to the COBS node. 
Dependencies: teleop | ex1_serial 
Created by: David Rodriguez (davidrm@dc.tohoku.ac.jp)
Last update: Nov. 12, 2019
Updated by: David Rodriguez (davidrm@dc.tohoku.ac.jp)
*/

/*Cyclic Redundancy Check Info
Algorithm: CRC-32/MPEG2
Width: 32 bits
Polynomial: 0x04C11DB7
Init: 0xFFFFFFFF
RefIn: False (bit 7 as MSB, 0 as LSB, and bytes are reflected before processing)
RefOut: False
XorOut: 0x00000000
Check: "123456789" -> 0x0376E6E7

Read more about CRC computation in: http://www.piclist.com/techref/method/math/crcguide.html
CRC functions used are part of: https://github.com/Michaelangel007/crc32
*/

//Includes
#include <ros/ros.h>
#include <vector>
#include <teleop/Command.h>
#include <ex1_serial/Message.h>

//Classes and global variables

class Crcmessage
{
private:	
	//private parameters
	int rocker_id;
	
	void commandReceived(const teleop::Command& msg);
	unsigned int crc32_mpeg2(size_t len, const __uint8_t *data);
	ros::NodeHandle p_nh; //define a private handle to access nodes' private param.
	ros::NodeHandle nh; //define a global handle to access global namespace resources.
	ros::Subscriber sub;
	ros::Publisher pub;
public:
	Crcmessage(); //constructor
};

//Functions
/* Constructor */
Crcmessage::Crcmessage(): p_nh("~")
{	
	//We fetch node id.
	p_nh.getParam("rocker_id", rocker_id);
	
	//Subscribe to different topics based on the rocker_id of the node. (see ex1_serial.launch)
	if(rocker_id == 1)//left rocker
	{
		sub = nh.subscribe("command_left", 200, &Crcmessage::commandReceived, this);
	}else if(rocker_id == 2) // right rocker
	{
		sub = nh.subscribe("command_right", 200, &Crcmessage::commandReceived, this);
	}else {
		ROS_WARN_STREAM("WARNING #2 - No rocker_id found.");
	}

	//Advertise serial message based on the rocker_id.
	if(rocker_id == 1)//left rocker
	{
		pub = nh.advertise<ex1_serial::Message>("message_left", 200);
	}else if(rocker_id == 2) // right rocker
	{
		pub = nh.advertise<ex1_serial::Message>("message_right", 200);
	}else {
		ROS_WARN_STREAM("WARNING #2 - No rocker_id found.");
	}
}

/* CRC32 calculation, functional approach, i.e., bit by bit */
unsigned int Crcmessage::crc32_mpeg2(size_t len, const __uint8_t *data)
{
	const unsigned char *buffer = (const unsigned __uint8_t*) data;
	unsigned int crc = 0xFFFFFFFF;
	unsigned int POLY = 0x04C11DB7;

	while( len-- )
	{
		crc = crc ^ (*buffer++ << 24);
		for( int bit = 0; bit < 8; bit++ )
		{
			if( crc & (1L << 31)) crc = (crc << 1) ^ POLY;
			else                  crc = (crc << 1);
		}
	}
	return crc;
}

/* Subscriber callback function */
void Crcmessage::commandReceived(const teleop::Command& ord)
{
	//Use this callback function to fill in the advertise message
	ex1_serial::Message msg;
	if (ord.id)
	{
		msg.data.push_back((uint8_t)(ord.id >> 8)); 
		msg.data.push_back((uint8_t)(ord.id & 0xFF));
		msg.data.push_back(ord.cmd);
		msg.data.push_back(ord.len);
		if(ord.len)
		{
			for (size_t i=0 ; i<ord.len ; i++)
			{
				msg.data.push_back(ord.opt[i]);
			} 
		}
		//Perform CRC
		const __uint8_t *pArg = &(msg.data[0]);
		size_t iter = msg.data.size();
		size_t nLen;
		if(iter%4 == 0){
			nLen = iter;
		}else{
			do{
				iter++;
			}while(iter%4 != 0);
			nLen = iter;
		}
		uint32_t crc = crc32_mpeg2(nLen, pArg);
		int bits = 24; 
		for (size_t i = 0; i <= 3; i++)
		{ 			
			msg.data.push_back((uint8_t)(crc >> bits & 0xff));
			bits -= 8;
		}
		msg.size = msg.data.size();
		//Gatekeeper: A message will only be published when commands are sent. 
		pub.publish(msg);
	}
	//pub.publish(msg);	
}

//Main
int main(int argc, char **argv)
{
	ros::init(argc, argv, "add_crc");
	//Create a Crcmessage object. This will call the Crcmessage() function automatically. 
	Crcmessage crc_msg;
	ros::spin();
	return 0;
}

