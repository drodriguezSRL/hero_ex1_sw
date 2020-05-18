;; Auto-generated. Do not edit!


(when (boundp 'ex1_serial::Read)
  (if (not (find-package "EX1_SERIAL"))
    (make-package "EX1_SERIAL"))
  (shadow 'Read (find-package "EX1_SERIAL")))
(unless (find-package "EX1_SERIAL::READ")
  (make-package "EX1_SERIAL::READ"))

(in-package "ROS")
;;//! \htmlinclude Read.msg.html


(defclass ex1_serial::Read
  :super ros::object
  :slots (_data ))

(defmethod ex1_serial::Read
  (:init
   (&key
    ((:data __data) 0)
    )
   (send-super :init)
   (setq _data (round __data))
   self)
  (:data
   (&optional __data)
   (if __data (setq _data __data)) _data)
  (:serialization-length
   ()
   (+
    ;; uint8 _data
    1
    ))
  (:serialize
   (&optional strm)
   (let ((s (if strm strm
              (make-string-output-stream (send self :serialization-length)))))
     ;; uint8 _data
       (write-byte _data s)
     ;;
     (if (null strm) (get-output-stream-string s))))
  (:deserialize
   (buf &optional (ptr- 0))
   ;; uint8 _data
     (setq _data (sys::peek buf ptr- :char)) (incf ptr- 1)
   ;;
   self)
  )

(setf (get ex1_serial::Read :md5sum-) "7c8164229e7d2c17eb95e9231617fdee")
(setf (get ex1_serial::Read :datatype-) "ex1_serial/Read")
(setf (get ex1_serial::Read :definition-)
      "# Custom data type for streamed telemetry bytes 
uint8 data

")



(provide :ex1_serial/Read "7c8164229e7d2c17eb95e9231617fdee")


