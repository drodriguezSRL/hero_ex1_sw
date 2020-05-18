/*
Content: This script creates a node that reads form the telemetry raw packets topic and unCOBS the packet. If you want to learn more about COBS, check cobs.cpp file in ex1_serial/src. 
Dependencies: ex1_serial | 
Created by: David Rodriguez (davidrm@dc.tohoku.ac.jp)
Last update: Nov. 25, 2019
Updated by: David Rodriguez (davidrm@dc.tohoku.ac.jp)
*/

//Inlcudes
#include <ros/ros.h>
#include <vector>
//Message types necessary
#include <ex1_serial/Message.h>

//Classes and global variables
class Uncobs
{
private:
	//private parameters
	int rocker_id;
	
	//global parameters
	int COBS_DELIMETER;
	
	void packetReceived(const ex1_serial::Message& pkt);
	void uncobsByteStuffing(const std::vector<uint8_t> &src, std::vector<uint8_t> &dst, uint8_t src_size);
	ros::NodeHandle p_nh;	
	ros::NodeHandle nh;
	ros::Subscriber sub;
	ros::Publisher pub;
public:
	Uncobs(); //constructor
};

//Functions
/* Constructor */
Uncobs::Uncobs(): p_nh("~")
{
	nh.getParam("COBS_DELIMETER", COBS_DELIMETER);
	
	//We fetch node id.
	p_nh.getParam("rocker_id", rocker_id);
	
	//Subscribe to different topics based on the rocker_id of the node. (see ex1_serial.launch)
	if(rocker_id == 1)//left rocker
	{
		sub = nh.subscribe("raw_pkt_left", 200, &Uncobs::packetReceived, this);
	}else if(rocker_id == 2) // right rocker
	{
		sub = nh.subscribe("raw_pkt_right", 200, &Uncobs::packetReceived, this);
	}else {
		ROS_WARN_STREAM("WARNING #2 - No rocker_id found.");
	}

	//Advertise serial message based on the rocker_id.
	if(rocker_id == 1)//left rocker
	{
		pub = nh.advertise<ex1_serial::Message>("uncobs_pkt_left", 200);
	}else if(rocker_id == 2) // right rocker
	{
		pub = nh.advertise<ex1_serial::Message>("uncobs_pkt_right", 200);
	}else {
		ROS_WARN_STREAM("WARNING #2 - No rocker_id found.");
	}	
}

/* COBS, Consistent Overhead Byte Stuffing */
void Uncobs::uncobsByteStuffing(const std::vector<uint8_t> &src, std::vector<uint8_t> &dst, uint8_t src_size){
	uint8_t codeBlock_size;
	int srcIndex = 1;

	//We scout the source packet (src) in order to define the different COBS code blocks.
	if(src[0] == COBS_DELIMETER){
		while(srcIndex < (src_size - 1)){
			codeBlock_size = src[srcIndex];
			for(int blockIndex = 1; blockIndex < codeBlock_size; blockIndex++){
				dst.push_back(src[srcIndex + blockIndex]);			
			}
			dst.push_back(0); //add the 0 at the end of the cobs block. 
			srcIndex += codeBlock_size;
		}
	}
}

/* Callback function */
void Uncobs::packetReceived(const ex1_serial::Message& pkt)
{
	//Use this call back to fill in the advertise message
	ex1_serial::Message newpkt;
	std::vector<uint8_t> dst;

	// Perform UnCOBS.
	uncobsByteStuffing(pkt.data, dst, pkt.size);

	//Fill in final packet without the trailing 0.
	for(size_t i = 0; i < (dst.size()-1); i++)
	{
		newpkt.data.push_back(dst[i]);
	}
	newpkt.size = newpkt.data.size();
	pub.publish(newpkt);

}

//Main

int main(int argc, char **argv)
{
	ros::init(argc, argv, "uncobs");
	//Create a Uncobs object. This will call the Uncobs() function automatically. 
	Uncobs uncobs_pkt;
	ros::spin();
	return 0;
}
