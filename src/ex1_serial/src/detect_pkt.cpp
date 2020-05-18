/*
Content: This script creates a node that subscribes to the telemetry data streaming read from the USB and stores the packets for decoding. 
Dependencies: ex1_serial 
Created by: David Rodriguez (davidrm@dc.tohoku.ac.jp)
Last update: Nov. 22, 2019
Updated by: David Rodriguez (davidrm@dc.tohoku.ac.jp)
*/

//Includes
#include <ros/ros.h>
#include <vector>
#include <ex1_serial/Message.h>
#include <ex1_serial/Read.h>

//Classes and global variables

class Store_packet
{
private:	
	//private parameters
	int rocker_id;

	//global parameters
	int COBS_DELIMETER, MIN_PACKET_SIZE, MAX_PACKET_SIZE;

	//flags
	bool _NEW_PACKET = false;

	//variables
	size_t size = 0;
	std::vector<uint8_t> pkt_temp;

	void byteReceived(const ex1_serial::Read& byte);
	ros::NodeHandle p_nh; //define a private handle to access nodes' private param.
	ros::NodeHandle nh; //define a global handle to access global namespace resources.
	ros::Subscriber sub;
	ros::Publisher pub;
public:
	Store_packet(); //constructor
};

//Functions
/* Constructor */
Store_packet::Store_packet(): p_nh("~")
{	
	//We fetch node id.
	p_nh.getParam("rocker_id", rocker_id);

	//We fetch global parameters.
	nh.getParam("COBS_DELIMETER", COBS_DELIMETER);
	nh.getParam("MAX_PACKET_SIZE", MAX_PACKET_SIZE);
	nh.getParam("MIN_PACKET_SIZE", MIN_PACKET_SIZE);
	
	//Subscribe to different topics based on the rocker_id of the node. (see ex1_serial.launch)
	if(rocker_id == 1)//left rocker
	{
		sub = nh.subscribe("read_left", 200, &Store_packet::byteReceived, this);
	}else if(rocker_id == 2) // right rocker
	{
		sub = nh.subscribe("read_right", 200, &Store_packet::byteReceived, this);
	}else {
		ROS_WARN_STREAM("WARNING #2 - No rocker_id found.");
	}

	//Advertise serial message based on the rocker_id.
	if(rocker_id == 1)//left rocker
	{
		pub = nh.advertise<ex1_serial::Message>("raw_pkt_left", 200);
	}else if(rocker_id == 2) // right rocker
	{
		pub = nh.advertise<ex1_serial::Message>("raw_pkt_right", 200);
	}else {
		ROS_WARN_STREAM("WARNING #2 - No rocker_id found.");
	}
}

/* Subscriber callback function */
void Store_packet::byteReceived(const ex1_serial::Read& byte)
{
	//Use this callback function to fill in the advertise packet.
	ex1_serial::Message pkt;
	
	//We first check for byte.data to be non-equal to our COBS_DELIMETER and we define a flag
	//to track when a package is being stored. 
	if(byte.data == COBS_DELIMETER && _NEW_PACKET == false && size <= MAX_PACKET_SIZE)
	{// new paquet starts.
		pkt_temp.push_back(byte.data);
		size++;
		_NEW_PACKET = true;
	}
	else if(byte.data != COBS_DELIMETER && _NEW_PACKET == true && size <= MAX_PACKET_SIZE)
	{ //packet is being filled
		pkt_temp.push_back(byte.data);
		size++;
	}
	else if(byte.data == COBS_DELIMETER && _NEW_PACKET == true && 
		size <= MAX_PACKET_SIZE && size != 1)
	{// Packet has ended.
		pkt_temp.push_back(COBS_DELIMETER);
		_NEW_PACKET = false;
		size++;
		//Fill in the final packet only if size is greater than MIN_PACKET_SIZE
		if(size >= MIN_PACKET_SIZE){
			pkt.data.insert(pkt.data.begin(), pkt_temp.begin(), pkt_temp.end());
			pkt_temp.clear();
			pkt.size = size;
			size = 0;
			pub.publish(pkt);
		}else
		{//ERROR 3 - packet does not contain enough elements
			ROS_ERROR_STREAM(
			"WARNING #5 - Unsuccessful packet: Packet size is smaller than MIN_PACKET_SIZE.");
		}
	}
	else if(byte.data != COBS_DELIMETER && _NEW_PACKET == true && size > MAX_PACKET_SIZE)
	{ //ERROR 1: packet is too long. 
		_NEW_PACKET = false; //end packet. 
		size = 0; //restart a new packet. 		
		ROS_ERROR_STREAM(
		"WARNING #3 - Unsuccessful packet: Packet size larger than MAX_PACKET_SIZE.");
	}
	else if(byte.data != COBS_DELIMETER && _NEW_PACKET == false)
	{ //ERROR 2: previous packet ended prematurely. 
		size = 0;
		ROS_ERROR_STREAM(
		"WARNING #4 - Unsuccessful packet: Previous packet ended prematurely.");
	}
	else if(byte.data == COBS_DELIMETER && _NEW_PACKET == true && 
		size <= MAX_PACKET_SIZE && size == 1)
	{// AUTO RE-SYNCHRONIZATION FROM ERROR 2: Previous packet was unsuccessful. 
		pkt_temp.at(0) = COBS_DELIMETER; //discard the previous delimeter. 
		size = 1; //restart the packet
	}	
}

//Main
int main(int argc, char **argv)
{
	ros::init(argc, argv, "detect_pkt");
	//Create a Store_packet object. This will call the Store_packet() function automatically. 
	Store_packet packet;
	ros::spin();
	return 0;
}

