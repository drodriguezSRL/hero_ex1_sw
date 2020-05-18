// Auto-generated. Do not edit!

// (in-package ex1_serial.msg)


"use strict";

const _serializer = _ros_msg_utils.Serialize;
const _arraySerializer = _serializer.Array;
const _deserializer = _ros_msg_utils.Deserialize;
const _arrayDeserializer = _deserializer.Array;
const _finder = _ros_msg_utils.Find;
const _getByteLength = _ros_msg_utils.getByteLength;

//-----------------------------------------------------------

class Telemetry {
  constructor(initObj={}) {
    if (initObj === null) {
      // initObj === null is a special case for deserialization where we don't initialize fields
      this.id = null;
      this.cmd = null;
      this.len = null;
      this.opt = null;
    }
    else {
      if (initObj.hasOwnProperty('id')) {
        this.id = initObj.id
      }
      else {
        this.id = 0;
      }
      if (initObj.hasOwnProperty('cmd')) {
        this.cmd = initObj.cmd
      }
      else {
        this.cmd = 0;
      }
      if (initObj.hasOwnProperty('len')) {
        this.len = initObj.len
      }
      else {
        this.len = 0;
      }
      if (initObj.hasOwnProperty('opt')) {
        this.opt = initObj.opt
      }
      else {
        this.opt = 0.0;
      }
    }
  }

  static serialize(obj, buffer, bufferOffset) {
    // Serializes a message object of type Telemetry
    // Serialize message field [id]
    bufferOffset = _serializer.uint16(obj.id, buffer, bufferOffset);
    // Serialize message field [cmd]
    bufferOffset = _serializer.uint8(obj.cmd, buffer, bufferOffset);
    // Serialize message field [len]
    bufferOffset = _serializer.uint8(obj.len, buffer, bufferOffset);
    // Serialize message field [opt]
    bufferOffset = _serializer.float32(obj.opt, buffer, bufferOffset);
    return bufferOffset;
  }

  static deserialize(buffer, bufferOffset=[0]) {
    //deserializes a message object of type Telemetry
    let len;
    let data = new Telemetry(null);
    // Deserialize message field [id]
    data.id = _deserializer.uint16(buffer, bufferOffset);
    // Deserialize message field [cmd]
    data.cmd = _deserializer.uint8(buffer, bufferOffset);
    // Deserialize message field [len]
    data.len = _deserializer.uint8(buffer, bufferOffset);
    // Deserialize message field [opt]
    data.opt = _deserializer.float32(buffer, bufferOffset);
    return data;
  }

  static getMessageSize(object) {
    return 8;
  }

  static datatype() {
    // Returns string type for a message object
    return 'ex1_serial/Telemetry';
  }

  static md5sum() {
    //Returns md5sum for a message object
    return '223bde042d75b50cc1fe2380be06acc7';
  }

  static messageDefinition() {
    // Returns full string definition for message
    return `
    # Custom data type for telemetry messages. 
    uint16 id
    uint8 cmd
    uint8 len 
    float32 opt 
    
    `;
  }

  static Resolve(msg) {
    // deep-construct a valid message object instance of whatever was passed in
    if (typeof msg !== 'object' || msg === null) {
      msg = {};
    }
    const resolved = new Telemetry(null);
    if (msg.id !== undefined) {
      resolved.id = msg.id;
    }
    else {
      resolved.id = 0
    }

    if (msg.cmd !== undefined) {
      resolved.cmd = msg.cmd;
    }
    else {
      resolved.cmd = 0
    }

    if (msg.len !== undefined) {
      resolved.len = msg.len;
    }
    else {
      resolved.len = 0
    }

    if (msg.opt !== undefined) {
      resolved.opt = msg.opt;
    }
    else {
      resolved.opt = 0.0
    }

    return resolved;
    }
};

module.exports = Telemetry;
