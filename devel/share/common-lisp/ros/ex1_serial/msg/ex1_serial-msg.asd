
(cl:in-package :asdf)

(defsystem "ex1_serial-msg"
  :depends-on (:roslisp-msg-protocol :roslisp-utils )
  :components ((:file "_package")
    (:file "Message" :depends-on ("_package_Message"))
    (:file "_package_Message" :depends-on ("_package"))
    (:file "Read" :depends-on ("_package_Read"))
    (:file "_package_Read" :depends-on ("_package"))
    (:file "Send" :depends-on ("_package_Send"))
    (:file "_package_Send" :depends-on ("_package"))
    (:file "Telemetry" :depends-on ("_package_Telemetry"))
    (:file "_package_Telemetry" :depends-on ("_package"))
  ))