 #| Jin Ador - Game of Thrones timer
    Copyright (C) 2014 Pierre Thierry <pierre@nothos.net>

    This program is free software: you can redistribute it and/or modify
    it under the terms of the GNU Affero General Public License as published by
    the Free Software Foundation, either version 3 of the License, or
    (at your option) any later version.

    This program is distributed in the hope that it will be useful,
    but WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
    GNU Affero General Public License for more details.

    You should have received a copy of the GNU Affero General Public License
    along with this program.  If not, see <http://www.gnu.org/licenses/>. |#

(in-package :nothos.net/2014.12.jin-ador)

(ele:defpclass timer ()
  ((seconds-left :initarg :size :accessor timer-left)
   (state :initarg :state :accessor timer-state)) ;nil for stopped
  (:default-initargs :state nil))

(defun timer-start (timer)
  (setf (timer-state timer) (now)))

(defun timer-stop (timer)
  (let ((elapsed (- (timestamp-to-unix (now)) (timestamp-to-unix (timer-state timer)))))
    (setf (timer-state timer) nil)
    (decf (timer-left timer) elapsed)))

(defun timer-toggle (timer)
  (if (timer-state timer)
      (timer-stop timer)
      (timer-start timer)))

(defun timer-alist (timer)
  (let ((state (timer-state timer)))
    (if state
	`((:state :started)
	  (:last-value ,(timer-left timer))
	  (:start-date ,(* 1000 (timestamp-to-unix state))))
	`((:state :stopped)
	  (:last-value ,(timer-left timer))))))

(defmethod json:encode-json ((object timer) &optional stream)
  (json:encode-json-alist (timer-alist object) stream))
