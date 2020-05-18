/*
Content: This script creates a node that translates the DSPS4 joystick movements into actual commands to operate one single wheel independently. The wheel to be commanded is defined by wheel_id. This script includes commands sent to both driving and steering motors.
Dependencies: joy | std_msgs
Created by: David Rodriguez (davidrm@dc.tohoku.ac.jp)
Last update: Nov. 21, 2019
Updated by: David Rodriguez (davidrm@dc.tohoku.ac.jp)
*/
#include <cmath>
#include <stdlib.h>
#include <ros/ros.h>
//Message types necessary
#include <sensor_msgs/Joy.h> //joystick movements published on the /joy topic by the joy package.
#include <std_msgs/String.h>
#include <teleop/Command.h>

//Classes and global variables
#define PI 3.14159265

class Command
{
private:
	//node private parameters
	int wheel_id, rocker_id;
	//global parameters
	float WHEEL_BASE, WHEEL_TRACK, WHEEL_RADIUS, DEF_MAXSPEED, DEF_MINTURNRAD, maxSpeed,
	      PNT_TURN_ANGLE, DEF_MAX_PNT_TURN_SPEED;     
	int LIGHTS, SET_MAXSPEED, PNT_TURN_MODE, DRIVING, STEERING, SAFETY_BTN, PNT_TURN_LEFT, 
	    PNT_TURN_RIGHT;
	//flags (required for switches and controlling when buttons are being pressed)
	bool _FLAG_1, _FLAG_2, _FLAG_3, _FLAG_4, _FLAG_5, 
	     _LIGHTS_STATUS, _PNT_TURN_STATUS, _MAXSPEED_STATUS;
	//variables
	float speed1, speed2, curv_radius, angle, arg;

	void joyCommandReceived(const sensor_msgs::Joy& joy);
	ros::NodeHandle p_nh; //define a private handle to access nodes' private param.
	ros::NodeHandle nh; //define a global handle to access global namespace resources.
	ros::Subscriber sub;
	ros::Publisher pub;

public:
	Command(); //constructor
};

//Functions
Command::Command(): p_nh("~"), _FLAG_1(false), _LIGHTS_STATUS(false), _PNT_TURN_STATUS(false),
_MAXSPEED_STATUS(false), _FLAG_2(false), _FLAG_3(false), _FLAG_4(false), _FLAG_5(false)
{
	//We fetch node id.
	p_nh.getParam("wheel_id", wheel_id);
	p_nh.getParam("rocker_id", rocker_id);
	//We fetch default operational parameters from teleop.launch.
	nh.getParam("WHEEL_BASE", WHEEL_BASE);
	nh.getParam("WHEEL_TRACK", WHEEL_TRACK);
	nh.getParam("WHEEL_RADIUS", WHEEL_RADIUS);
	nh.getParam("DEF_MAXSPEED", DEF_MAXSPEED);
	nh.getParam("DEF_MINTURNRAD", DEF_MINTURNRAD);
	nh.getParam("DEF_MAX_PNT_TURN_SPEED", DEF_MAX_PNT_TURN_SPEED);

	/* ---> Here is where you can change the functionality of the joystick <--- */
	//We fetch buttons&axes map from teleop.launch.
	nh.getParam("R1_btn", SAFETY_BTN);
	nh.getParam("circle_btn", LIGHTS);
	nh.getParam("L1_btn", SET_MAXSPEED);
	nh.getParam("triangle_btn", PNT_TURN_MODE);
	nh.getParam("upDownAxis_leftStick", DRIVING);
	nh.getParam("leftRigtAxis_rightStick", STEERING);
	nh.getParam("L2_axs", PNT_TURN_LEFT);
	nh.getParam("R2_axs", PNT_TURN_RIGHT);

	//Define initial maximum driving speed
	maxSpeed = DEF_MAXSPEED;
	//Define point turn steering angle.
	PNT_TURN_ANGLE = (180/PI) * (atan2(WHEEL_BASE, WHEEL_TRACK));
	
	//Advertise on different topics based on the rocker_id of the node. (see teleop.launch)
	if(rocker_id == 1)//left rocker
	{
		pub = nh.advertise<teleop::Command>("command_left", 200);
	}else if(rocker_id == 2) // right rocker
	{
		pub = nh.advertise<teleop::Command>("command_right", 200);
	}else {
		ROS_WARN_STREAM("WARNING #2 - No rocker_id found.");
	}
	//Subscribe to the joystick movements. 
	sub = nh.subscribe("joy", 200, &Command::joyCommandReceived, this);

}

void Command::joyCommandReceived(const sensor_msgs::Joy& joy)
{
	//Use this callback function to fill in the advertised message.
	//Define array to be sent.
	teleop::Command ord;

	//Based on the node ID (i.e., wheel_id in launch file), we only listen to a specific set of commands.
	switch(wheel_id){
		case 0: //####################  lights  ####################
			//The following code actives and deactives the lights.
			if(joy.buttons[LIGHTS] && _LIGHTS_STATUS == false && _FLAG_1 == false){
				ord.id = 1;
				ord.cmd = 1;
				ord.len = 0;
				ord.opt = {};
				_LIGHTS_STATUS = true;
				ROS_INFO_STREAM("Turning lights ON.");
			}else if(!joy.buttons[LIGHTS] &&
				 _LIGHTS_STATUS == true && _FLAG_1 == false){
				_FLAG_1 = true;
			}else if(joy.buttons[LIGHTS] && _LIGHTS_STATUS == true && _FLAG_1 == true){
				ord.id = 1;
				ord.cmd = 2;
				ord.len = 0;
				ord.opt = {};
				_LIGHTS_STATUS = false;
				ROS_INFO_STREAM("Turning lights OFF.");
			}else if(!joy.buttons[LIGHTS] && _LIGHTS_STATUS == false && _FLAG_1== true){
				_FLAG_1 = false;
			}
			break;
		case 1: //####################  wheel 1  ####################
			//Set max speed. Starting value is defined by DEF_MAXSPEED.
			if(joy.buttons[SET_MAXSPEED] && _MAXSPEED_STATUS == false){
				if(maxSpeed < 1.0){ maxSpeed += 0.1;}
				else{ maxSpeed = DEF_MAXSPEED;}
				ROS_INFO_STREAM(
				"Setting new MAX_SPEED to: "<< maxSpeed <<" m/s.");
				_MAXSPEED_STATUS = true;
			}else if(!joy.buttons[SET_MAXSPEED]){_MAXSPEED_STATUS = false;}

			//Trigger/Cancel Point-Turn Mode.
			//While on Point-Turn Mode, driving or steering commands will be deactivated.
			if(joy.buttons[PNT_TURN_MODE] &&
			   joy.buttons[SAFETY_BTN] &&
			   _PNT_TURN_STATUS == false && _FLAG_1 == false){
				ord.id = 1;
				ord.cmd = 5;
				ord.len = 4;
				//Define opt argument
				angle = PNT_TURN_ANGLE;
				uint8_t *array;
				array = reinterpret_cast<uint8_t*>(&angle);
				for(int i = 0; i <=3; i++){
					ord.opt[i] = array[i];
				}
				ROS_INFO_STREAM("Point-turn Mode activated.");
				_PNT_TURN_STATUS = true;
			}else if(!joy.buttons[PNT_TURN_MODE] &&
				 !joy.buttons[SAFETY_BTN] &&
				 _PNT_TURN_STATUS == true && _FLAG_1 == false){
				_FLAG_1 = true;
			}else if(joy.buttons[PNT_TURN_MODE] &&
				 joy.buttons[SAFETY_BTN] &&
				 _PNT_TURN_STATUS == true && _FLAG_1 == true){
				ord.id = 1;
				ord.cmd = 5;
				ord.len = 4;
				//Define opt argument
				angle = 0.0;
				uint8_t *array;
				array = reinterpret_cast<uint8_t*>(&angle);
				for(int i = 0; i <=3; i++){
					ord.opt[i] = array[i];
				}
				ROS_INFO_STREAM("Point-turn Mode cancelled.");
				_PNT_TURN_STATUS = false;
			}else if(!joy.buttons[PNT_TURN_MODE] &&
				 !joy.buttons[SAFETY_BTN] &&
				 _PNT_TURN_STATUS == false && _FLAG_1 == true){
				 _FLAG_1 = false;
			}

			//Driving command.
			if(joy.axes[DRIVING] && _PNT_TURN_STATUS == false){
				_FLAG_3 = true;
				ord.id = 1;
				ord.cmd = 3;
				ord.len = 4;
				//Define opt argument
				speed1 = -joy.axes[DRIVING]*maxSpeed;
				speed2 =  (180/PI) * (speed1/WHEEL_RADIUS); //deg/s
				uint8_t *array;
				//array = (uint8_t*)(&speed);
				array = reinterpret_cast<uint8_t*>(&speed2);
				for(int i = 0; i <=3; i++){
					//ord.opt[i] = *(array + i);
					ord.opt[i] = array[i];
				}
				if(speed1 > 0){
					ROS_INFO_STREAM(
					"Driving forward at: "<< abs(speed2) << " deg/s.");
				}else{
					ROS_INFO_STREAM(
					"Driving backward at: "<< abs(speed2) << " deg/s.");}
			}else if(joy.axes[DRIVING] && _PNT_TURN_STATUS == true){
				ROS_INFO_STREAM("Driving command disabled.");
			}else if(!joy.axes[DRIVING] && _FLAG_3 == true){
				_FLAG_3 = false;				
				ord.id = 1;
				ord.cmd = 3;
				ord.len = 4;
				//Define opt argument
				speed1 = 0.0;
				speed2 =  (180/PI) * (speed1/WHEEL_RADIUS); //deg/s
				uint8_t *array;
				array = reinterpret_cast<uint8_t*>(&speed2);
				for(int i = 0; i <=3; i++){
					//ord.opt[i] = *(array + i);
					ord.opt[i] = array[i];
				}
			}

			//Steering command.
			if(joy.axes[STEERING] && _PNT_TURN_STATUS == false){
				_FLAG_2 = true;
				ord.id = 1;
				ord.cmd = 5;
				ord.len = 4;
				//Define opt argument
				curv_radius = DEF_MINTURNRAD/(-joy.axes[STEERING]);
				if(curv_radius < 0){ //left turn
					angle =
					(-180/PI) *
					atan2(WHEEL_BASE,(abs(curv_radius)-WHEEL_TRACK/2));
					ROS_INFO_STREAM(
					"Turning left. Curvature radius: "<<abs(curv_radius)<<" m.");
				}else{ //right turn
					angle =
					(180/PI) *
					atan2(WHEEL_BASE,(abs(curv_radius)+WHEEL_TRACK/2));
					ROS_INFO_STREAM(
					"Turning right. Curvature radius: "<<abs(curv_radius)<<" m.");
				}
				uint8_t *array;
				array = reinterpret_cast<uint8_t*>(&angle);
				for(int i = 0; i <=3; i++){
					ord.opt[i] = array[i];
				}
			}else if(joy.axes[STEERING] && _PNT_TURN_STATUS == true){
				ROS_INFO_STREAM("Steering command disabled.");
			}else if(!joy.axes[STEERING] && _FLAG_2 == true){
				_FLAG_2 = false;				
				ord.id = 1;
				ord.cmd = 5;
				ord.len = 4;
				//Define opt argument
				angle = 0.0;
				uint8_t *array;
				array = reinterpret_cast<uint8_t*>(&angle);
				for(int i = 0; i <=3; i++){
					ord.opt[i] = array[i];
				}
			}

			//Point turn.
			if(_PNT_TURN_STATUS == true && 
				joy.axes[PNT_TURN_LEFT] == -1 && 
				_FLAG_4 == false && _FLAG_5 == false){
				_FLAG_4 = true;
				ord.id = 1;
				ord.cmd = 3;
				ord.len = 4;
				//Define opt argument
				speed1 = abs(joy.axes[PNT_TURN_LEFT])*DEF_MAX_PNT_TURN_SPEED;
				speed2 =  (180/PI) * (speed1/WHEEL_RADIUS); //deg/s
				uint8_t *array;
				array = reinterpret_cast<uint8_t*>(&speed2);
				for(int i = 0; i <=3; i++){
					ord.opt[i] = array[i];
				}
				ROS_INFO_STREAM("Point turn left at: "<< DEF_MAX_PNT_TURN_SPEED 
					<< " m/s.");
			}else if(_PNT_TURN_STATUS == true && 
				joy.axes[PNT_TURN_LEFT] != -1 && _FLAG_4 == true){
				//We always want to send one 0 speed command to stop the wheel. 
				ord.id = 1;
				ord.cmd = 3;
				ord.len = 4;
				//Define opt argument
				speed1 = 0.0;
				speed2 =  (180/PI) * (speed1/WHEEL_RADIUS); //deg/s
				uint8_t *array;
				array = reinterpret_cast<uint8_t*>(&speed2);
				for(int i = 0; i <=3; i++){
					ord.opt[i] = array[i];
				}
				_FLAG_4 = false;
			}
			if(_PNT_TURN_STATUS == true && 
			joy.axes[PNT_TURN_RIGHT] == -1 && 
			_FLAG_5 == false && _FLAG_4 == false){
				_FLAG_5 = true;
				ord.id = 1;
				ord.cmd = 3;
				ord.len = 4;
				//Define opt argument
				speed1 = -abs(joy.axes[PNT_TURN_LEFT])*DEF_MAX_PNT_TURN_SPEED;
				speed2 =  (180/PI) * (speed1/WHEEL_RADIUS); //deg/s
				uint8_t *array;
				array = reinterpret_cast<uint8_t*>(&speed2);
				for(int i = 0; i <=3; i++){
					ord.opt[i] = array[i];
				}
				ROS_INFO_STREAM("Point turn right at: "<< DEF_MAX_PNT_TURN_SPEED 
					<< " m/s.");
			}else if(_PNT_TURN_STATUS == true &&  
				joy.axes[PNT_TURN_RIGHT] != -1 && _FLAG_5 == true){
				//We always want to send one 0 speed command to stop the wheel.
				ord.id = 1;
				ord.cmd = 3;
				ord.len = 4;
				//Define opt argument
				speed1 = 0.0;
				speed2 =  (180/PI) * (speed1/WHEEL_RADIUS); //deg/s
				uint8_t *array;
				array = reinterpret_cast<uint8_t*>(&speed2);
				for(int i = 0; i <=3; i++){
					ord.opt[i] = array[i];
				}
				_FLAG_5 = false;
			}
			break;

		case 2: //###############   wheel 2   ###############
			//First we set max speed. Starting value is defined by DEF_MAXSPEED.
			if(joy.buttons[SET_MAXSPEED] && _MAXSPEED_STATUS == false){
				if(maxSpeed < 1.0){ maxSpeed += 0.1;}
				else{ maxSpeed = DEF_MAXSPEED;}
				_MAXSPEED_STATUS = true;
			}else if(!joy.buttons[SET_MAXSPEED]){_MAXSPEED_STATUS = false;}

			//Trigger/Cancel point turn mode.
			if(joy.buttons[PNT_TURN_MODE] &&
			   joy.buttons[SAFETY_BTN] &&
			   _FLAG_1 == false && _PNT_TURN_STATUS == false){
				ord.id = 1;
				ord.cmd = 5;
				ord.len = 4;
				//Define opt argument
				angle = -PNT_TURN_ANGLE;
				uint8_t *array;
				array = reinterpret_cast<uint8_t*>(&angle);
				for(int i = 0; i <=3; i++){
					ord.opt[i] = array[i];
				}
				_FLAG_1 = true;
			}else if(!joy.buttons[PNT_TURN_MODE] &&
				 !joy.buttons[SAFETY_BTN] &&
				 _FLAG_1 == true && _PNT_TURN_STATUS == false){
				_PNT_TURN_STATUS = true;
			}else if(joy.buttons[PNT_TURN_MODE] &&
				 joy.buttons[SAFETY_BTN] &&
				 _FLAG_1 == true && _PNT_TURN_STATUS == true){
				ord.id = 1;
				ord.cmd = 5;
				ord.len = 4;
				//Define opt argument
				angle = 0.0;
				uint8_t *array;
				array = reinterpret_cast<uint8_t*>(&angle);
				for(int i = 0; i <=3; i++){
					ord.opt[i] = array[i];
				}
				_FLAG_1 = false;
			}else if(!joy.buttons[PNT_TURN_MODE] &&
				 !joy.buttons[SAFETY_BTN] &&
				 _FLAG_1 == false && _PNT_TURN_STATUS == true){
				 _PNT_TURN_STATUS = false;
			}

			//Driving command.
			if(joy.axes[DRIVING] && _PNT_TURN_STATUS == false){
				_FLAG_3 = true;
				ord.id = 1;
				ord.cmd = 3;
				ord.len = 4;
				//Define opt argument
				speed1 = joy.axes[DRIVING]*maxSpeed;
				speed2 =  (180/PI) * (speed1/WHEEL_RADIUS); //deg/s
				uint8_t *array;
				array = reinterpret_cast<uint8_t*>(&speed2);
				for(int i = 0; i <=3; i++){
					ord.opt[i] = array[i];
				}
			}else if(!joy.axes[DRIVING] && _FLAG_3 == true){
				_FLAG_3 = false;				
				ord.id = 1;
				ord.cmd = 3;
				ord.len = 4;
				//Define opt argument
				speed1 = 0.0;
				speed2 =  (180/PI) * (speed1/WHEEL_RADIUS); //deg/s
				uint8_t *array;
				array = reinterpret_cast<uint8_t*>(&speed2);
				for(int i = 0; i <=3; i++){
					//ord.opt[i] = *(array + i);
					ord.opt[i] = array[i];
				}
			}

			//Steering command.
			if(joy.axes[STEERING] && _PNT_TURN_STATUS == false){
				_FLAG_2 = true;		
				ord.id = 1;
				ord.cmd = 5;
				ord.len = 4;
				//Define opt argument
				curv_radius = DEF_MINTURNRAD/(-joy.axes[STEERING]);
				if(curv_radius < 0){ //left turn
					angle =
					(-180/PI) *
					atan2(WHEEL_BASE,(abs(curv_radius)+WHEEL_TRACK/2));
				}else{ //right turn
					angle =
					(180/PI) *
					atan2(WHEEL_BASE,(abs(curv_radius)-WHEEL_TRACK/2));
				}
				uint8_t *array;
				array = reinterpret_cast<uint8_t*>(&angle);
				for(int i = 0; i <=3; i++){
					ord.opt[i] = array[i];
				}
			}else if(!joy.axes[STEERING] && _FLAG_2 == true){
				_FLAG_2 = false;				
				ord.id = 1;
				ord.cmd = 5;
				ord.len = 4;
				//Define opt argument
				angle = 0.0;
				uint8_t *array;
				array = reinterpret_cast<uint8_t*>(&angle);
				for(int i = 0; i <=3; i++){
					ord.opt[i] = array[i];
				}
			}

			//Point turn.
			if(_PNT_TURN_STATUS == true && 
				joy.axes[PNT_TURN_LEFT] == -1 && 
				_FLAG_4 == false && _FLAG_5 == false){
				_FLAG_4 = true;
				ord.id = 1;
				ord.cmd = 3;
				ord.len = 4;
				//Define opt argument
				speed1 = -abs(joy.axes[PNT_TURN_LEFT])*DEF_MAX_PNT_TURN_SPEED;
				speed2 =  (180/PI) * (speed1/WHEEL_RADIUS); //deg/s
				uint8_t *array;
				array = reinterpret_cast<uint8_t*>(&speed2);
				for(int i = 0; i <=3; i++){
					ord.opt[i] = array[i];
				}
			}else if(_PNT_TURN_STATUS == true && 
				joy.axes[PNT_TURN_LEFT] != -1 && _FLAG_4 == true){
				//We always want to send one 0 speed command to stop the wheel. 
				ord.id = 1;
				ord.cmd = 3;
				ord.len = 4;
				//Define opt argument
				speed1 = 0.0;
				speed2 =  (180/PI) * (speed1/WHEEL_RADIUS); //deg/s
				uint8_t *array;
				array = reinterpret_cast<uint8_t*>(&speed2);
				for(int i = 0; i <=3; i++){
					ord.opt[i] = array[i];
				}
				_FLAG_4 = false;
			}
			if(_PNT_TURN_STATUS == true && 
			joy.axes[PNT_TURN_RIGHT] == -1 && 
			_FLAG_5 == false && _FLAG_4 == false){
				_FLAG_5 = true;
				ord.id = 1;
				ord.cmd = 3;
				ord.len = 4;
				//Define opt argument
				speed1 = abs(joy.axes[PNT_TURN_LEFT])*DEF_MAX_PNT_TURN_SPEED;
				speed2 =  (180/PI) * (speed1/WHEEL_RADIUS); //deg/s
				uint8_t *array;
				array = reinterpret_cast<uint8_t*>(&speed2);
				for(int i = 0; i <=3; i++){
					ord.opt[i] = array[i];
				}
			}else if(_PNT_TURN_STATUS == true &&  
				joy.axes[PNT_TURN_RIGHT] != -1 && _FLAG_5 == true){
				//We always want to send one 0 speed command to stop the wheel.
				ord.id = 1;
				ord.cmd = 3;
				ord.len = 4;
				//Define opt argument
				speed1 = 0.0;
				speed2 =  (180/PI) * (speed1/WHEEL_RADIUS); //deg/s
				uint8_t *array;
				array = reinterpret_cast<uint8_t*>(&speed2);
				for(int i = 0; i <=3; i++){
					ord.opt[i] = array[i];
				}
				_FLAG_5 = false;
			}
			break;

		case 3: //###############   wheel 3   ###############
			//First we set max speed. Starting value is defined by DEF_MAXSPEED.
			if(joy.buttons[SET_MAXSPEED] && _MAXSPEED_STATUS == false){
				if(maxSpeed < 1.0){ maxSpeed += 0.1;}
				else{ maxSpeed = DEF_MAXSPEED;}
				_MAXSPEED_STATUS = true;
			}else if(!joy.buttons[SET_MAXSPEED]){_MAXSPEED_STATUS = false;}

			//Trigger/Cancel point turn mode.
			if(joy.buttons[PNT_TURN_MODE] &&
			   joy.buttons[SAFETY_BTN] &&
			   _FLAG_1 == false && _PNT_TURN_STATUS == false){
				ord.id = 1;
				ord.cmd = 6;
				ord.len = 4;
				//Define opt argument
				angle = PNT_TURN_ANGLE;
				uint8_t *array;
				array = reinterpret_cast<uint8_t*>(&angle);
				for(int i = 0; i <=3; i++){
					ord.opt[i] = array[i];
				}
				_FLAG_1 = true;
			}else if(!joy.buttons[PNT_TURN_MODE] &&
				 !joy.buttons[SAFETY_BTN] &&
				 _FLAG_1 == true && _PNT_TURN_STATUS == false){
				_PNT_TURN_STATUS = true;
			}else if(joy.buttons[PNT_TURN_MODE] &&
				 joy.buttons[SAFETY_BTN] &&
				 _FLAG_1 == true && _PNT_TURN_STATUS == true){
				ord.id = 1;
				ord.cmd = 6;
				ord.len = 4;
				//Define opt argument
				angle = 0.0;
				uint8_t *array;
				array = reinterpret_cast<uint8_t*>(&angle);
				for(int i = 0; i <=3; i++){
					ord.opt[i] = array[i];
				}
				_FLAG_1 = false;
			}else if(!joy.buttons[PNT_TURN_MODE] &&
				 !joy.buttons[SAFETY_BTN] &&
				 _FLAG_1 == false && _PNT_TURN_STATUS == true){
				 _PNT_TURN_STATUS = false;
			}

			//Driving command.
			if(joy.axes[DRIVING] && _PNT_TURN_STATUS == false){
				_FLAG_3 = true;
				ord.id = 1;
				ord.cmd = 4;
				ord.len = 4;
				//Define opt argument
				speed1 = joy.axes[DRIVING]*maxSpeed;
				speed2 =  (180/PI) * (speed1/WHEEL_RADIUS); //deg/s
				uint8_t *array;
				array = reinterpret_cast<uint8_t*>(&speed2);
				for(int i = 0; i <=3; i++){
					ord.opt[i] = array[i];
				}
			}else if(!joy.axes[DRIVING] && _FLAG_3 == true){
				_FLAG_3 = false;				
				ord.id = 1;
				ord.cmd = 4;
				ord.len = 4;
				//Define opt argument
				speed1 = 0.0;
				speed2 =  (180/PI) * (speed1/WHEEL_RADIUS); //deg/s
				uint8_t *array;
				array = reinterpret_cast<uint8_t*>(&speed2);
				for(int i = 0; i <=3; i++){
					//ord.opt[i] = *(array + i);
					ord.opt[i] = array[i];
				}
			}

			//Point turn.
			if(_PNT_TURN_STATUS == true && 
				joy.axes[PNT_TURN_LEFT] == -1 && 
				_FLAG_4 == false && _FLAG_5 == false){
				_FLAG_4 = true;
				ord.id = 1;
				ord.cmd = 4;
				ord.len = 4;
				//Define opt argument
				speed1 = -abs(joy.axes[PNT_TURN_LEFT])*DEF_MAX_PNT_TURN_SPEED;
				speed2 =  (180/PI) * (speed1/WHEEL_RADIUS); //deg/s
				uint8_t *array;
				array = reinterpret_cast<uint8_t*>(&speed2);
				for(int i = 0; i <=3; i++){
					ord.opt[i] = array[i];
				}
			}else if(_PNT_TURN_STATUS == true && 
				joy.axes[PNT_TURN_LEFT] != -1 && _FLAG_4 == true){
				//We always want to send one 0 speed command to stop the wheel. 
				ord.id = 1;
				ord.cmd = 4;
				ord.len = 4;
				//Define opt argument
				speed1 = 0.0;
				speed2 =  (180/PI) * (speed1/WHEEL_RADIUS); //deg/s
				uint8_t *array;
				array = reinterpret_cast<uint8_t*>(&speed2);
				for(int i = 0; i <=3; i++){
					ord.opt[i] = array[i];
				}
				_FLAG_4 = false;
			}
			if(_PNT_TURN_STATUS == true && 
			joy.axes[PNT_TURN_RIGHT] == -1 && 
			_FLAG_5 == false && _FLAG_4 == false){
				_FLAG_5 = true;
				ord.id = 1;
				ord.cmd = 4;
				ord.len = 4;
				//Define opt argument
				speed1 = abs(joy.axes[PNT_TURN_LEFT])*DEF_MAX_PNT_TURN_SPEED;
				speed2 =  (180/PI) * (speed1/WHEEL_RADIUS); //deg/s
				uint8_t *array;
				array = reinterpret_cast<uint8_t*>(&speed2);
				for(int i = 0; i <=3; i++){
					ord.opt[i] = array[i];
				}
			}else if(_PNT_TURN_STATUS == true &&  
				joy.axes[PNT_TURN_RIGHT] != -1 && _FLAG_5 == true){
				//We always want to send one 0 speed command to stop the wheel.
				ord.id = 1;
				ord.cmd = 4;
				ord.len = 4;
				//Define opt argument
				speed1 = 0.0;
				speed2 =  (180/PI) * (speed1/WHEEL_RADIUS); //deg/s
				uint8_t *array;
				array = reinterpret_cast<uint8_t*>(&speed2);
				for(int i = 0; i <=3; i++){
					ord.opt[i] = array[i];
				}
				_FLAG_5 = false;
			}
			break;

		case 4: //###############  wheel 4   ###############
			//First we set max speed. Starting value is defined by DEF_MAXSPEED.
			if(joy.buttons[SET_MAXSPEED] && _MAXSPEED_STATUS == false){
				if(maxSpeed < 1.0){ maxSpeed += 0.1;}
				else{ maxSpeed = DEF_MAXSPEED;}
				_MAXSPEED_STATUS = true;
			}else if(!joy.buttons[SET_MAXSPEED]){_MAXSPEED_STATUS = false;}

			//Trigger/Cancel point turn mode.
			if(joy.buttons[PNT_TURN_MODE] &&
			   joy.buttons[SAFETY_BTN] &&
			   _FLAG_1 == false && _PNT_TURN_STATUS == false){
				ord.id = 1;
				ord.cmd = 6;
				ord.len = 4;
				//Define opt argument
				angle = -PNT_TURN_ANGLE;
				uint8_t *array;
				array = reinterpret_cast<uint8_t*>(&angle);
				for(int i = 0; i <=3; i++){
					ord.opt[i] = array[i];
				}
				_FLAG_1 = true;
			}else if(!joy.buttons[PNT_TURN_MODE] &&
				 !joy.buttons[SAFETY_BTN] &&
				 _FLAG_1 == true && _PNT_TURN_STATUS == false){
				_PNT_TURN_STATUS = true;
			}else if(joy.buttons[PNT_TURN_MODE] &&
				 joy.buttons[SAFETY_BTN] &&
				 _FLAG_1 == true && _PNT_TURN_STATUS == true){
				ord.id = 1;
				ord.cmd = 6;
				ord.len = 4;
				//Define opt argument
				angle = 0.0;
				uint8_t *array;
				array = reinterpret_cast<uint8_t*>(&angle);
				for(int i = 0; i <=3; i++){
					ord.opt[i] = array[i];
				}
				_FLAG_1 = false;
			}else if(!joy.buttons[PNT_TURN_MODE] &&
				 !joy.buttons[SAFETY_BTN] &&
				 _FLAG_1 == false && _PNT_TURN_STATUS == true){
				 _PNT_TURN_STATUS = false;
			}

			//Driving command.
			if(joy.axes[DRIVING] && _PNT_TURN_STATUS == false){
				_FLAG_3 = true;
				ord.id = 1;
				ord.cmd = 4;
				ord.len = 4;
				//Define opt argument
				speed1 = -joy.axes[DRIVING]*maxSpeed;
				speed2 =  (180/PI) * (speed1/WHEEL_RADIUS); //deg/s
				uint8_t *array;
				array = reinterpret_cast<uint8_t*>(&speed2);
				for(int i = 0; i <=3; i++){
					ord.opt[i] = array[i];
				}
			}else if(!joy.axes[DRIVING] && _FLAG_3 == true){
				_FLAG_3 = false;				
				ord.id = 1;
				ord.cmd = 4;
				ord.len = 4;
				//Define opt argument
				speed1 = 0.0;
				speed2 =  (180/PI) * (speed1/WHEEL_RADIUS); //deg/s
				uint8_t *array;
				array = reinterpret_cast<uint8_t*>(&speed2);
				for(int i = 0; i <=3; i++){
					//ord.opt[i] = *(array + i);
					ord.opt[i] = array[i];
				}
			}
			//Point turn.
			if(_PNT_TURN_STATUS == true && 
				joy.axes[PNT_TURN_LEFT] == -1 && 
				_FLAG_4 == false && _FLAG_5 == false){
				_FLAG_4 = true;
				ord.id = 1;
				ord.cmd = 4;
				ord.len = 4;
				//Define opt argument
				speed1 = abs(joy.axes[PNT_TURN_LEFT])*DEF_MAX_PNT_TURN_SPEED;
				speed2 =  (180/PI) * (speed1/WHEEL_RADIUS); //deg/s
				uint8_t *array;
				array = reinterpret_cast<uint8_t*>(&speed2);
				for(int i = 0; i <=3; i++){
					ord.opt[i] = array[i];
				}
			}else if(_PNT_TURN_STATUS == true && 
				joy.axes[PNT_TURN_LEFT] != -1 && _FLAG_4 == true){
				//We always want to send one 0 speed command to stop the wheel. 
				ord.id = 1;
				ord.cmd = 4;
				ord.len = 4;
				//Define opt argument
				speed1 = 0.0;
				speed2 =  (180/PI) * (speed1/WHEEL_RADIUS); //deg/s
				uint8_t *array;
				array = reinterpret_cast<uint8_t*>(&speed2);
				for(int i = 0; i <=3; i++){
					ord.opt[i] = array[i];
				}
				_FLAG_4 = false;
			}
			if(_PNT_TURN_STATUS == true && 
			joy.axes[PNT_TURN_RIGHT] == -1 && 
			_FLAG_5 == false && _FLAG_4 == false){
				_FLAG_5 = true;
				ord.id = 1;
				ord.cmd = 4;
				ord.len = 4;
				//Define opt argument
				speed1 = -abs(joy.axes[PNT_TURN_LEFT])*DEF_MAX_PNT_TURN_SPEED;
				speed2 =  (180/PI) * (speed1/WHEEL_RADIUS); //deg/s
				uint8_t *array;
				array = reinterpret_cast<uint8_t*>(&speed2);
				for(int i = 0; i <=3; i++){
					ord.opt[i] = array[i];
				}
			}else if(_PNT_TURN_STATUS == true &&  
				joy.axes[PNT_TURN_RIGHT] != -1 && _FLAG_5 == true){
				//We always want to send one 0 speed command to stop the wheel.
				ord.id = 1;
				ord.cmd = 4;
				ord.len = 4;
				//Define opt argument
				speed1 = 0.0;
				speed2 =  (180/PI) * (speed1/WHEEL_RADIUS); //deg/s
				uint8_t *array;
				array = reinterpret_cast<uint8_t*>(&speed2);
				for(int i = 0; i <=3; i++){
					ord.opt[i] = array[i];
				}
				_FLAG_5 = false;
			}
			break;

		case 9://----------TESTING CASE ---------------
			if(joy.buttons[LIGHTS] && _FLAG_1 == false){
				ord.id = 1;
				ord.cmd = 6;
				ord.len = 4;
				//Define opt argument
				arg = 32.0;
				uint8_t *array;
				array = reinterpret_cast<uint8_t*>(&arg);
				for(int i = 0; i <=3; i++){
					ord.opt[i] = array[i];
				}
			}else if(!joy.buttons[LIGHTS] && _FLAG_1 == false){
				_FLAG_1 = true;
			}else if(joy.buttons[LIGHTS] && _FLAG_1 == true){
				ord.id = 1;
				ord.cmd = 6;
				ord.len = 4;
				//Define opt argument
				arg = -32.0;
				uint8_t *array;
				array = reinterpret_cast<uint8_t*>(&arg);
				for(int i = 0; i <=3; i++){
					ord.opt[i] = array[i];
				}
			}else if(!joy.buttons[LIGHTS] && _FLAG_1 == true){
				_FLAG_1 = false;
			}
			break;
		default: 
			ROS_WARN_STREAM("WARNING #1 - No match for wheel_id.");
	}
	pub.publish(ord);
}

//Main
int main(int argc, char **argv){
	ros::init(argc, argv, "teleop");
	//Create a command object. This will call the Command() function automatically.
	Command teleop_ex1;
	ros::Rate loop_rate(1000);
	while(ros::ok()){
		ros::spinOnce();
		loop_rate.sleep();
	}
	return 0;
}
