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

class Message {
  constructor(initObj={}) {
    if (initObj === null) {
      // initObj === null is a special case for deserialization where we don't initialize fields
      this.data = null;
      this.size = null;
    }
    else {
      if (initObj.hasOwnProperty('data')) {
        this.data = initObj.data
      }
      else {
        this.data = [];
      }
      if (initObj.hasOwnProperty('size')) {
        this.size = initObj.size
      }
      else {
        this.size = 0;
      }
    }
  }

  static serialize(obj, buffer, bufferOffset) {
    // Serializes a message object of type Message
    // Serialize message field [data]
    bufferOffset = _arraySerializer.uint8(obj.data, buffer, bufferOffset, null);
    // Serialize message field [size]
    bufferOffset = _serializer.uint8(obj.size, buffer, bufferOffset);
    return bufferOffset;
  }

  static deserialize(buffer, bufferOffset=[0]) {
    //deserializes a message object of type Message
    let len;
    let data = new Message(null);
    // Deserialize message field [data]
    data.data = _arrayDeserializer.uint8(buffer, bufferOffset, null)
    // Deserialize message field [size]
    data.size = _deserializer.uint8(buffer, bufferOffset);
    return data;
  }

  static getMessageSize(object) {
    let length = 0;
    length += object.data.length;
    return length + 5;
  }

  static datatype() {
    // Returns string type for a message object
    return 'ex1_serial/Message';
  }

  static md5sum() {
    //Returns md5sum for a message object
    return '7d65c7bbd4f88c12c49b0057e6c0ecce';
  }

  static messageDefinition() {
    // Returns full string definition for message
    return `
    # Custom data type for packets
    uint8[] data
    uint8 size
    
    `;
  }

  static Resolve(msg) {
    // deep-construct a valid message object instance of whatever was passed in
    if (typeof msg !== 'object' || msg === null) {
      msg = {};
    }
    const resolved = new Message(null);
    if (msg.data !== undefined) {
      resolved.data = msg.data;
    }
    else {
      resolved.data = []
    }

    if (msg.size !== undefined) {
      resolved.size = msg.size;
    }
    else {
      resolved.size = 0
    }

    return resolved;
    }
};

module.exports = Message;
