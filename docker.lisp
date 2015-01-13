(in-package :cl-user)
(ql:quickload "jin-ador")
(swank:create-server :port 2001)
(jin-ador::clackup 2002)
