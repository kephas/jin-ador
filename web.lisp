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


(defclass <jin-ador> (caveman2:<app>)())
(defparameter *app* (make-instance '<jin-ador>))

(defvar *baad-default-shell*)

(defvar *families* '("Stark" "Greyjoy" "Lannister" "Baratheon" "Tyrell" "Martel"))

(defun open-storage ()
  (ele:open-store `(:clsql (:sqlite3 ,(merge-pathnames #p"timers.sqlite"
						       (asdf:component-pathname (asdf:find-system "jin-ador"))))))
     (let ((shell (ele:get-from-root "baad-default-shell")))
       (unless shell
	 (setf shell (ele:make-btree))
	 (ele:add-to-root "baad-default-shell" shell))
       (setf *baad-default-shell* shell)))

(defvar *js-scripts* '("jquery" "bootstrap" "angular"))

(defun js-scripts (stream)
  (with-html-output (out stream)
    (dolist (script *js-scripts*)
      (let ((src (format nil "/static/js/~a.js" script)))
	(htm (:script :src src))))))

(defmacro jin-page (title &body body)
  `(with-html-output-to-string (out nil :indent t)
     (:html
      (:head
       (:title (fmt "Jin Ador - ~a" ,title))
       (:meta :name "viewport" :content "width=device-width")
       (:link :href "/static/css/bootstrap.min.css" :rel "stylesheet")
       (:style :type "text/css" "body {margin: 4em 2em;}"))
      (:body
       ((:div :class "navbar navbar-inverse navbar-fixed-top" :role "navigation")
	((:div :class "container")
	 ((:div :class "navbar-header")
	  ({collapse-btn} ".nabu-navbar-collapse")
	  ((:a :class "navbar-brand" :href "#") "Jin Ador"))
	 ((:div :class "collapse navbar-collapse nabu-navbar-collapse")
	  ((:ul :class "nav navbar-nav")))))
       ((:div :class "container")
	(:h1 (str ,title))
	,@body
	(js-scripts out))))))

(defroute "/" (&key reset)
  (jin-page "Home"
    (:a :id "foobar" :href "#1" "Foobar")
    (:hr)
    (:div :id "target")))

(defroute "/reset" (&key time)
  (dolist (family *families*)
    (setf (shell-object *baad-default-shell* family) time))
  (redirect *response* "/"))

(defroute "/test" ()
  "<span>OK!</span>")

(defun clackup (port)
  (open-storage)
  (clack:clackup
   (clack.builder:builder
    (clack.middleware.static:<clack-middleware-static>
     :path "/static/"
     :root (merge-pathnames #p"static/" (asdf:system-source-directory "jin-ador")))
    *app*)
   :port port))
