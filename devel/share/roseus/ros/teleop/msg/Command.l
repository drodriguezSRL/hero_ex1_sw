;; Auto-generated. Do not edit!


(when (boundp 'teleop::Command)
  (if (not (find-package "TELEOP"))
    (make-package "TELEOP"))
  (shadow 'Command (find-package "TELEOP")))
(unless (find-package "TELEOP::COMMAND")
  (make-package "TELEOP::COMMAND"))

(in-package "ROS")
;;//! \htmlinclude Command.msg.html


(defclass teleop::Command
  :super ros::object
  :slots (_id _cmd _len _opt ))

(defmethod teleop::Command
  (:init
   (&key
    ((:id __id) 0)
    ((:cmd __cmd) 0)
    ((:len __len) 0)
    ((:opt __opt) (make-array 16 :initial-element 0 :element-type :char))
    )
   (send-super :init)
   (setq _id (round __id))
   (setq _cmd (round __cmd))
   (setq _len (round __len))
   (setq _opt __opt)
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
    ;; uint8[16] _opt
    (* 1    16)
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
     ;; uint8[16] _opt
     (princ _opt s)
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
   ;; uint8[16] _opt
   (setq _opt (make-array 16 :element-type :char))
   (replace _opt buf :start2 ptr-) (incf ptr- 16)
   ;;
   self)
  )

(setf (get teleop::Command :md5sum-) "491437395421608172e700163ad99a96")
(setf (get teleop::Command :datatype-) "teleop/Command")
(setf (get teleop::Command :definition-)
      "# Custom data type for command messages. 
uint16 id
uint8 cmd
uint8 len 
uint8[16] opt 

")



(provide :teleop/Command "491437395421608172e700163ad99a96")


