;; Auto-generated. Do not edit!


(when (boundp 'ex1_serial::Telemetry)
  (if (not (find-package "EX1_SERIAL"))
    (make-package "EX1_SERIAL"))
  (shadow 'Telemetry (find-package "EX1_SERIAL")))
(unless (find-package "EX1_SERIAL::TELEMETRY")
  (make-package "EX1_SERIAL::TELEMETRY"))

(in-package "ROS")
;;//! \htmlinclude Telemetry.msg.html


(defclass ex1_serial::Telemetry
  :super ros::object
  :slots (_id _cmd _len _opt ))

(defmethod ex1_serial::Telemetry
  (:init
   (&key
    ((:id __id) 0)
    ((:cmd __cmd) 0)
    ((:len __len) 0)
    ((:opt __opt) 0.0)
    )
   (send-super :init)
   (setq _id (round __id))
   (setq _cmd (round __cmd))
   (setq _len (round __len))
   (setq _opt (float __opt))
   self)
  (:id
   (&optional __id)
   (if __id (setq _id __id)) _id)
  (:cmd
   (&optional __cmd)
   (if __cmd (setq _cmd __cmd)) _cmd)
  (:len
   (&optional __len)
   (if __len (setq _len __len)) _len)
  (:opt
   (&optional __opt)
   (if __opt (setq _opt __opt)) _opt)
  (:serialization-length
   ()
   (+
    ;; uint16 _id
    2
    ;; uint8 _cmd
    1
    ;; uint8 _len
    1
    ;; float32 _opt
    4
    ))
  (:serialize
   (&optional strm)
   (let ((s (if strm strm
              (make-string-output-stream (send self :serialization-length)))))
     ;; uint16 _id
       (write-word _id s)
     ;; uint8 _cmd
       (write-byte _cmd s)
     ;; uint8 _len
       (write-byte _len s)
     ;; float32 _opt
       (sys::poke _opt (send s :buffer) (send s :count) :float) (incf (stream-count s) 4)
     ;;
     (if (null strm) (get-output-stream-string s))))
  (:deserialize
   (buf &optional (ptr- 0))
   ;; uint16 _id
     (setq _id (sys::peek buf ptr- :short)) (incf ptr- 2)
   ;; uint8 _cmd
     (setq _cmd (sys::peek buf ptr- :char)) (incf ptr- 1)
   ;; uint8 _len
     (setq _len (sys::peek buf ptr- :char)) (incf ptr- 1)
   ;; float32 _opt
     (setq _opt (sys::peek buf ptr- :float)) (incf ptr- 4)
   ;;
   self)
  )

(setf (get ex1_serial::Telemetry :md5sum-) "223bde042d75b50cc1fe2380be06acc7")
(setf (get ex1_serial::Telemetry :datatype-) "ex1_serial/Telemetry")
(setf (get ex1_serial::Telemetry :definition-)
      "# Custom data type for telemetry messages. 
uint16 id
uint8 cmd
uint8 len 
float32 opt 

")



(provide :ex1_serial/Telemetry "223bde042d75b50cc1fe2380be06acc7")


