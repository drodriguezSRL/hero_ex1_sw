; Auto-generated. Do not edit!


(cl:in-package ex1_serial-msg)


;//! \htmlinclude Message.msg.html

(cl:defclass <Message> (roslisp-msg-protocol:ros-message)
  ((data
    :reader data
    :initarg :data
    :type (cl:vector cl:fixnum)
   :initform (cl:make-array 0 :element-type 'cl:fixnum :initial-element 0))
   (size
    :reader size
    :initarg :size
    :type cl:fixnum
    :initform 0))
)

(cl:defclass Message (<Message>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <Message>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'Message)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name ex1_serial-msg:<Message> is deprecated: use ex1_serial-msg:Message instead.")))

(cl:ensure-generic-function 'data-val :lambda-list '(m))
(cl:defmethod data-val ((m <Message>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader ex1_serial-msg:data-val is deprecated.  Use ex1_serial-msg:data instead.")
  (data m))

(cl:ensure-generic-function 'size-val :lambda-list '(m))
(cl:defmethod size-val ((m <Message>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader ex1_serial-msg:size-val is deprecated.  Use ex1_serial-msg:size instead.")
  (size m))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <Message>) ostream)
  "Serializes a message object of type '<Message>"
  (cl:let ((__ros_arr_len (cl:length (cl:slot-value msg 'data))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) __ros_arr_len) ostream))
  (cl:map cl:nil #'(cl:lambda (ele) (cl:write-byte (cl:ldb (cl:byte 8 0) ele) ostream))
   (cl:slot-value msg 'data))
  (cl:write-byte (cl:ldb (cl:byte 8 0) (cl:slot-value msg 'size)) ostream)
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <Message>) istream)
  "Deserializes a message object of type '<Message>"
  (cl:let ((__ros_arr_len 0))
    (cl:setf (cl:ldb (cl:byte 8 0) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 8) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 16) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 24) __ros_arr_len) (cl:read-byte istream))
  (cl:setf (cl:slot-value msg 'data) (cl:make-array __ros_arr_len))
  (cl:let ((vals (cl:slot-value msg 'data)))
    (cl:dotimes (i __ros_arr_len)
    (cl:setf (cl:ldb (cl:byte 8 0) (cl:aref vals i)) (cl:read-byte istream)))))
    (cl:setf (cl:ldb (cl:byte 8 0) (cl:slot-value msg 'size)) (cl:read-byte istream))
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<Message>)))
  "Returns string type for a message object of type '<Message>"
  "ex1_serial/Message")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'Message)))
  "Returns string type for a message object of type 'Message"
  "ex1_serial/Message")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<Message>)))
  "Returns md5sum for a message object of type '<Message>"
  "7d65c7bbd4f88c12c49b0057e6c0ecce")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'Message)))
  "Returns md5sum for a message object of type 'Message"
  "7d65c7bbd4f88c12c49b0057e6c0ecce")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<Message>)))
  "Returns full string definition for message of type '<Message>"
  (cl:format cl:nil "# Custom data type for packets~%uint8[] data~%uint8 size~%~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'Message)))
  "Returns full string definition for message of type 'Message"
  (cl:format cl:nil "# Custom data type for packets~%uint8[] data~%uint8 size~%~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <Message>))
  (cl:+ 0
     4 (cl:reduce #'cl:+ (cl:slot-value msg 'data) :key #'(cl:lambda (ele) (cl:declare (cl:ignorable ele)) (cl:+ 1)))
     1
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <Message>))
  "Converts a ROS message object to a list"
  (cl:list 'Message
    (cl:cons ':data (data msg))
    (cl:cons ':size (size msg))
))
