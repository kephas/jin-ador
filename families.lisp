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


(defvar *families* '("Stark" "Greyjoy" "Lannister" "Baratheon" "Tyrell" "Martel"))

(defun create-timers (shell duration families)
  (dolist (family families)
    (setf (shell-object shell family) (make-instance 'timer :size duration))))

(defun families-json (shell families)
  (json:encode-json-alist-to-string
   (mapcar (lambda (family)
	     (cons family (shell-object shell family)))
	   families)))
