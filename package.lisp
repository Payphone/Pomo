;;;; package.lisp

(defpackage #:pomo
  (:use #:cl #:stumpwm #:trivial-timers)
  (:export #:pomo-status
           #:pomo-reset
           #:pomo-start
           #:pomo-stop
           #:pomo-break
           #:*short-break*
           #:*long-break*
           #:*work-period*))
