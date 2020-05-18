;; Auto-generated. Do not edit!


(when (boundp 'ex1_serial::Send)
  (if (not (find-package "EX1_SERIAL"))
    (make-package "EX1_SERIAL"))
  (shadow 'Send (find-package "EX1_SERIAL")))
(unless (find-package "EX1_SERIAL::SEND")
  (make-package "EX1_SERIAL::SEND"))

(in-package "ROS")
;;//! \htmlinclude Send.msg.html


(defclass ex1_serial::Send
  :super ros::object
  :slots (_data _size ))

(defmethod ex1_serial::Send
  (:init
   (&key
    ((:data __data) (make-array 0 :initial-element 0 :element-type :char))
    ((:size __size) 0)
    )
   (send-super :init)
   (setq _data __data)
   (setq _size (round __size))
   self)
  (:data
   (&optional __data)
   (if __data (setq _data __data)) _data)
  (:size
   (&optional __size)
   (if __size (setq _size __size)) _size)
  (:serialization-length
   ()
   (+
    ;; uint8[] _data
    (* 1    (length _data)) 4
    ;; uint8 _size
    1
    ))
  (:serialize
   (&optional strm)
   (let ((s (if strm strm
              (make-string-output-stream (send self :serialization-length)))))
     ;; uint8[] _data
     (write-long (length _data) s)
     (princ _data s)
     ;; uint8 _size
       (write-byte _size s)
     ;;
     (if (null strm) (get-output-stream-string s))))
  (:deserialize
   (buf &optional (ptr- 0))
   ;; uint8[] _data
   (let ((n (sys::peek buf ptr- :integer))) (incf ptr- 4)
     (setq _data (make-array n :element-type :char))
     (replace _data buf :start2 ptr-) (incf ptr- n))
   ;; uint8 _size
     (setq _size (sys::peek buf ptr- :char)) (incf ptr- 1)
   ;;
   self)
  )

(setf (get ex1_serial::Send :md5sum-) "7d65c7bbd4f88c12c49b0057e6c0ecce")
(setf (get ex1_serial::Send :datatype-) "ex1_serial/Send")
(setf (get ex1_serial::Send :definition-)
      "# Custom data type for packets
uint8[] data
uint8 size

")



(provide :ex1_serial/Send "7d65c7bbd4f88c12c49b0057e6c0ecce")


