;;;; pomo.asd

(asdf:defsystem #:pomo
  :description "A StumpWM module for keeping track of Pomodoro sessions."
  :author "Peyton Farrar <peyton@peytonfarrar.com>"
  :license "MIT"
  :depends-on (#:stumpwm #:trivial-timers)
  :serial t
  :components ((:file "package")
               (:file "pomo")))
