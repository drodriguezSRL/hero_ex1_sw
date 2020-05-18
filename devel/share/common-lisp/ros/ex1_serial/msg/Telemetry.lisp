; Auto-generated. Do not edit!


(cl:in-package ex1_serial-msg)


;//! \htmlinclude Telemetry.msg.html

(cl:defclass <Telemetry> (roslisp-msg-protocol:ros-message)
  ((id
    :reader id
    :initarg :id
    :type cl:fixnum
    :initform 0)
   (cmd
    :reader cmd
    :initarg :cmd
    :type cl:fixnum
    :initform 0)
   (len
    :reader len
    :initarg :len
    :type cl:fixnum
    :initform 0)
   (opt
    :reader opt
    :initarg :opt
    :type cl:float
    :initform 0.0))
)

(cl:defclass Telemetry (<Telemetry>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <Telemetry>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'Telemetry)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name ex1_serial-msg:<Telemetry> is deprecated: use ex1_serial-msg:Telemetry instead.")))

(cl:ensure-generic-function 'id-val :lambda-list '(m))
(cl:defmethod id-val ((m <Telemetry>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader ex1_serial-msg:id-val is deprecated.  Use ex1_serial-msg:id instead.")
  (id m))

(cl:ensure-generic-function 'cmd-val :lambda-list '(m))
(cl:defmethod cmd-val ((m <Telemetry>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader ex1_serial-msg:cmd-val is deprecated.  Use ex1_serial-msg:cmd instead.")
  (cmd m))

(cl:ensure-generic-function 'len-val :lambda-list '(m))
(cl:defmethod len-val ((m <Telemetry>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader ex1_serial-msg:len-val is deprecated.  Use ex1_serial-msg:len instead.")
  (len m))

(cl:ensure-generic-function 'opt-val :lambda-list '(m))
(cl:defmethod opt-val ((m <Telemetry>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader ex1_serial-msg:opt-val is deprecated.  Use ex1_serial-msg:opt instead.")
  (opt m))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <Telemetry>) ostream)
  "Serializes a message object of type '<Telemetry>"
  (cl:write-byte (cl:ldb (cl:byte 8 0) (cl:slot-value msg 'id)) ostream)
  (cl:write-byte (cl:ldb (cl:byte 8 8) (cl:slot-value msg 'id)) ostream)
  (cl:write-byte (cl:ldb (cl:byte 8 0) (cl:slot-value msg 'cmd)) ostream)
  (cl:write-byte (cl:ldb (cl:byte 8 0) (cl:slot-value msg 'len)) ostream)
  (cl:let ((bits (roslisp-utils:encode-single-float-bits (cl:slot-value msg 'opt))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) bits) ostream))
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <Telemetry>) istream)
  "Deserializes a message object of type '<Telemetry>"
    (cl:setf (cl:ldb (cl:byte 8 0) (cl:slot-value msg 'id)) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 8) (cl:slot-value msg 'id)) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 0) (cl:slot-value msg 'cmd)) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 0) (cl:slot-value msg 'len)) (cl:read-byte istream))
    (cl:let ((bits 0))
      (cl:setf (cl:ldb (cl:byte 8 0) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) bits) (cl:read-byte istream))
    (cl:setf (cl:slot-value msg 'opt) (roslisp-utils:decode-single-float-bits bits)))
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<Telemetry>)))
  "Returns string type for a message object of type '<Telemetry>"
  "ex1_serial/Telemetry")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'Telemetry)))
  "Returns string type for a message object of type 'Telemetry"
  "ex1_serial/Telemetry")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<Telemetry>)))
  "Returns md5sum for a message object of type '<Telemetry>"
  "223bde042d75b50cc1fe2380be06acc7")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'Telemetry)))
  "Returns md5sum for a message object of type 'Telemetry"
  "223bde042d75b50cc1fe2380be06acc7")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<Telemetry>)))
  "Returns full string definition for message of type '<Telemetry>"
  (cl:format cl:nil "# Custom data type for telemetry messages. ~%uint16 id~%uint8 cmd~%uint8 len ~%float32 opt ~%~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'Telemetry)))
  "Returns full string definition for message of type 'Telemetry"
  (cl:format cl:nil "# Custom data type for telemetry messages. ~%uint16 id~%uint8 cmd~%uint8 len ~%float32 opt ~%~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <Telemetry>))
  (cl:+ 0
     2
     1
     1
     4
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <Telemetry>))
  "Converts a ROS message object to a list"
  (cl:list 'Telemetry
    (cl:cons ':id (id msg))
    (cl:cons ':cmd (cmd msg))
    (cl:cons ':len (len msg))
    (cl:cons ':opt (opt msg))
))
