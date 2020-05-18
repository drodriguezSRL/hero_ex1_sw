; Auto-generated. Do not edit!


(cl:in-package ex1_serial-msg)


;//! \htmlinclude Read.msg.html

(cl:defclass <Read> (roslisp-msg-protocol:ros-message)
  ((data
    :reader data
    :initarg :data
    :type cl:fixnum
    :initform 0))
)

(cl:defclass Read (<Read>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <Read>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'Read)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name ex1_serial-msg:<Read> is deprecated: use ex1_serial-msg:Read instead.")))

(cl:ensure-generic-function 'data-val :lambda-list '(m))
(cl:defmethod data-val ((m <Read>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader ex1_serial-msg:data-val is deprecated.  Use ex1_serial-msg:data instead.")
  (data m))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <Read>) ostream)
  "Serializes a message object of type '<Read>"
  (cl:write-byte (cl:ldb (cl:byte 8 0) (cl:slot-value msg 'data)) ostream)
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <Read>) istream)
  "Deserializes a message object of type '<Read>"
    (cl:setf (cl:ldb (cl:byte 8 0) (cl:slot-value msg 'data)) (cl:read-byte istream))
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<Read>)))
  "Returns string type for a message object of type '<Read>"
  "ex1_serial/Read")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'Read)))
  "Returns string type for a message object of type 'Read"
  "ex1_serial/Read")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<Read>)))
  "Returns md5sum for a message object of type '<Read>"
  "7c8164229e7d2c17eb95e9231617fdee")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'Read)))
  "Returns md5sum for a message object of type 'Read"
  "7c8164229e7d2c17eb95e9231617fdee")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<Read>)))
  "Returns full string definition for message of type '<Read>"
  (cl:format cl:nil "# Custom data type for streamed telemetry bytes ~%uint8 data~%~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'Read)))
  "Returns full string definition for message of type 'Read"
  (cl:format cl:nil "# Custom data type for streamed telemetry bytes ~%uint8 data~%~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <Read>))
  (cl:+ 0
     1
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <Read>))
  "Converts a ROS message object to a list"
  (cl:list 'Read
    (cl:cons ':data (data msg))
))
