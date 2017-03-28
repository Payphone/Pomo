;;;; pomo.asd

(asdf:defsystem #:pomo
  :description "A Pomodoro StumpWM module."
  :author "Peyton Farrar <peyton@peytonfarrar.com>"
  :license "MIT"
  :depends-on (#:stumpwm #:trivial-timers)
  :serial t
  :components ((:file "package")
               (:file "pomo")))
