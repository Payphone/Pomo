;;;; pomo.lisp

(in-package #:pomo)

(defparameter *short-break* 5
  "Short break in minutes after almost every work period.")
(defparameter *long-break* 15
  "Long break in minutes after four short breaks.")
(defparameter *work-period* 25
  "Amount of time in minutes of working before taking a break.")
(defvar *pomos* 0
  "The total number of Pomodoros done so far.")

(defun min->sec (minutes)
  "Converts from minutes to seconds."
  (* minutes 60))

(defun start-message-timer (name time &key end-message)
  "Starts a message timer. Returns nil if it couldn't start the timer."
  (unless (list-all-timers)
    (message "~A for ~A minutes." name time)
    (schedule-timer (make-timer #'(lambda () (let ((*suppress-echo-timeout* t))
                                          (message end-message))) :name name)
                    (min->sec time))
    (return-from start-message-timer t))
  (when (list-all-timers)
    (message "Can't start, there's already a timer running.")
    (return-from start-message-timer nil)))

(defcommand pomo-status () ()
  "Returns the current timer status."
  (message "~A" (or (first (mapcar #'timer-name (list-all-timers)))
                    "Not active.")))

(defcommand pomo-reset () ()
  "Resets the total number of Pomodoros done, and stops and timers."
  (setf *pomos* 0)
  (stop-pomo))

(defcommand pomo-start () ()
  "Starts a timer for the specified work period."
  (if (start-message-timer 'work *work-period*
                           :end-message "Take it easy.")
      (incf *pomos*)))

(defcommand pomo-stop () ()
  "Removes all timers."
  (loop for timer in (list-all-timers) do (unschedule-timer timer))
  (message "Removed all timers."))

(defcommand pomo-break () ()
  "Starts a timer for the specified break period. Once four Pomodoros have been
  done, the break is long."
  (start-message-timer 'break (if (and (> *pomos* 4) (= (mod *pomos* 4) 1))
                                  *long-break*
                                  *short-break*)
                       :end-message "Get back to work."))
