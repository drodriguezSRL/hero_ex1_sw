/*
Content: This script creates a node that reads from the uncobs packet topic, performs a cyclic redundancy check (CRC) to make sure the packet is valid. 
Dependencies: teleop | ex1_serial 
Created by: David Rodriguez (davidrm@dc.tohoku.ac.jp)
Last update: Nov. 26, 2019
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
#include <string>
#include <algorithm>
#include <map>
#include <vector>
#include <ros/ros.h>
#include <ex1_serial/Telemetry.h>
#include <ex1_serial/Message.h>

//Classes and global variables

class Validation
{
private:	
	//private parameters
	int rocker_id;

	//global parameters
	std::vector<int> cmd_list;
	std::map<std::string,int> len_dictionary;
	
	void originalpktReceived(const ex1_serial::Message& org_pkt);
	unsigned int crc32_mpeg2(size_t len, const __uint8_t *data);
	ros::NodeHandle p_nh; //define a private handle to access nodes' private param.
	ros::NodeHandle nh; //define a global handle to access global namespace resources.
	ros::Subscriber sub;
	ros::Publisher pub;
public:
	Validation(); //constructor
};

//Functions
/* Constructor */
Validation::Validation(): p_nh("~")
{	
	//We fetch node id.
	p_nh.getParam("rocker_id", rocker_id);

	//We fetch dictionary of commands.
	nh.getParam("/cmd_list", cmd_list);
	nh.getParam("/len_dictionary", len_dictionary);
	
	//Subscribe to different topics based on the rocker_id of the node. (see ex1_serial.launch)
	if(rocker_id == 1)//left rocker
	{
		sub = 
		nh.subscribe("uncobs_pkt_left", 200, &Validation::originalpktReceived, this);
	}else if(rocker_id == 2) // right rocker
	{
		sub = 
		nh.subscribe("uncobs_pkt_right", 200, &Validation::originalpktReceived, this);
	}else {
		ROS_WARN_STREAM("WARNING #2 - No rocker_id found.");
	}

	//Advertise serial message based on the rocker_id.
	if(rocker_id == 1)//left rocker
	{
		pub = nh.advertise<ex1_serial::Telemetry>("telemetry_left", 200);
	}else if(rocker_id == 2) // right rocker
	{
		pub = nh.advertise<ex1_serial::Telemetry>("telemetry_right", 200);
	}else {
		ROS_WARN_STREAM("WARNING #2 - No rocker_id found.");
	}
}

/* CRC32 calculation, functional approach, i.e., bit by bit */
unsigned int Validation::crc32_mpeg2(size_t len, const __uint8_t *data)
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
void Validation::originalpktReceived(const ex1_serial::Message& org_pkt)
{
	//Use this callback function to fill in the advertise message
	ex1_serial::Telemetry tmt;

	//We first extract info from raw packet and perform all the validation checks. 
	tmt.id = ((org_pkt.data[0] << 8) | org_pkt.data[1]);
	uint8_t cmd = org_pkt.data[2];
	uint8_t len = org_pkt.data[3];
	
	//We create a temporary vector to afterwards check the CRC.
	std::vector<uint8_t> temp;
	for(size_t i = 0; i < 4; i++){
		temp.push_back(org_pkt.data[i]);	
	}
	
	uint8_t opt[len];
	float arg;
	if(len)
	{
		for(size_t i=0; i<len; i++){
			opt[i] = org_pkt.data[4+i];
			temp.push_back(org_pkt.data[4+i]);
		}
		//From uint8 to float
		std::memcpy(&arg, &opt, sizeof(arg));
		/*ROS_WARN_STREAM("CMD OPT= " << arg);*/
	}
	uint8_t crc_val[4] =
		{org_pkt.data[4+len],
		org_pkt.data[5+len],
		org_pkt.data[6+len],
		org_pkt.data[7+len]};

	//################# Validation checks #######################
	//FIRST CHECK: Check that CMD byte is in the list of commands
	if(std::find(cmd_list.begin(), cmd_list.end(), cmd) != cmd_list.end()){
		tmt.cmd = cmd;
	}else{
		ROS_WARN_STREAM("WARNING #6 - Unsuccessful packet: CMD is not in the list of commands.");
	}

	//SECOND and THIRD CHECK: Check if LEN byte matches with the overall packet size
	// and if LEN byte matches with CMD id.
	
	if(!len){
		tmt.len = len;
	}else if(len && org_pkt.size == (8 + len)){
		if((len_dictionary.find(std::to_string(cmd))->second) != len){
			ROS_WARN_STREAM(
			"WARNING #7 - Unsuccessful packet:  LEN doesn't match with the corresponding CMD id value.");
		}else{
			tmt.len = len;
			tmt.opt = arg;
		}
	}else if(len && org_pkt.size != (8 + len)){
		ROS_WARN_STREAM("WARNING #8 - Unsuccessful packet: LEN doesn't match with the packet size.");
	}
	
	//FOURTH CHECK: CRC validation.
	//Perform CRC
	const __uint8_t *pArg = &(temp[0]);
	size_t iter = temp.size();
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
	std::vector<uint8_t> crc_check;
	for (size_t i = 0; i <= 3; i++)
	{ 			
		temp.push_back((uint8_t)(crc >> bits & 0xff));
		bits -= 8;
	}
	for(size_t i = 0; i <= 3; i++){
		if(crc_val[i] != temp[4+len+i]){
			ROS_WARN_STREAM(
			"WARNING #9 - Unsuccessful packet: CRC validation doesn't match with the corresponding CRC value.");
		}else{
			pub.publish(tmt);
		}
	}
}

//Main
int main(int argc, char **argv)
{
	ros::init(argc, argv, "pkt_validation");
	Validation valid_pkt;
	ros::spin();
	return 0;
}

