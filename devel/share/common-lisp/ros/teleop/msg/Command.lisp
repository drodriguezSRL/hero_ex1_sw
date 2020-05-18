; Auto-generated. Do not edit!


(cl:in-package teleop-msg)


;//! \htmlinclude Command.msg.html

(cl:defclass <Command> (roslisp-msg-protocol:ros-message)
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
    :type (cl:vector cl:fixnum)
   :initform (cl:make-array 16 :element-type 'cl:fixnum :initial-element 0)))
)

(cl:defclass Command (<Command>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <Command>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'Command)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name teleop-msg:<Command> is deprecated: use teleop-msg:Command instead.")))

(cl:ensure-generic-function 'id-val :lambda-list '(m))
(cl:defmethod id-val ((m <Command>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader teleop-msg:id-val is deprecated.  Use teleop-msg:id instead.")
  (id m))

(cl:ensure-generic-function 'cmd-val :lambda-list '(m))
(cl:defmethod cmd-val ((m <Command>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader teleop-msg:cmd-val is deprecated.  Use teleop-msg:cmd instead.")
  (cmd m))

(cl:ensure-generic-function 'len-val :lambda-list '(m))
(cl:defmethod len-val ((m <Command>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader teleop-msg:len-val is deprecated.  Use teleop-msg:len instead.")
  (len m))

(cl:ensure-generic-function 'opt-val :lambda-list '(m))
(cl:defmethod opt-val ((m <Command>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader teleop-msg:opt-val is deprecated.  Use teleop-msg:opt instead.")
  (opt m))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <Command>) ostream)
  "Serializes a message object of type '<Command>"
  (cl:write-byte (cl:ldb (cl:byte 8 0) (cl:slot-value msg 'id)) ostream)
  (cl:write-byte (cl:ldb (cl:byte 8 8) (cl:slot-value msg 'id)) ostream)
  (cl:write-byte (cl:ldb (cl:byte 8 0) (cl:slot-value msg 'cmd)) ostream)
  (cl:write-byte (cl:ldb (cl:byte 8 0) (cl:slot-value msg 'len)) ostream)
  (cl:map cl:nil #'(cl:lambda (ele) (cl:write-byte (cl:ldb (cl:byte 8 0) ele) ostream))
   (cl:slot-value msg 'opt))
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <Command>) istream)
  "Deserializes a message object of type '<Command>"
    (cl:setf (cl:ldb (cl:byte 8 0) (cl:slot-value msg 'id)) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 8) (cl:slot-value msg 'id)) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 0) (cl:slot-value msg 'cmd)) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 0) (cl:slot-value msg 'len)) (cl:read-byte istream))
  (cl:setf (cl:slot-value msg 'opt) (cl:make-array 16))
  (cl:let ((vals (cl:slot-value msg 'opt)))
    (cl:dotimes (i 16)
    (cl:setf (cl:ldb (cl:byte 8 0) (cl:aref vals i)) (cl:read-byte istream))))
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<Command>)))
  "Returns string type for a message object of type '<Command>"
  "teleop/Command")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'Command)))
  "Returns string type for a message object of type 'Command"
  "teleop/Command")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<Command>)))
  "Returns md5sum for a message object of type '<Command>"
  "491437395421608172e700163ad99a96")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'Command)))
  "Returns md5sum for a message object of type 'Command"
  "491437395421608172e700163ad99a96")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<Command>)))
  "Returns full string definition for message of type '<Command>"
  (cl:format cl:nil "# Custom data type for command messages. ~%uint16 id~%uint8 cmd~%uint8 len ~%uint8[16] opt ~%~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'Command)))
  "Returns full string definition for message of type 'Command"
  (cl:format cl:nil "# Custom data type for command messages. ~%uint16 id~%uint8 cmd~%uint8 len ~%uint8[16] opt ~%~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <Command>))
  (cl:+ 0
     2
     1
     1
     0 (cl:reduce #'cl:+ (cl:slot-value msg 'opt) :key #'(cl:lambda (ele) (cl:declare (cl:ignorable ele)) (cl:+ 1)))
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <Command>))
  "Converts a ROS message object to a list"
  (cl:list 'Command
    (cl:cons ':id (id msg))
    (cl:cons ':cmd (cmd msg))
    (cl:cons ':len (len msg))
    (cl:cons ':opt (opt msg))
))
