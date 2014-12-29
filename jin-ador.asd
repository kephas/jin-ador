(asdf:defsystem "jin-ador"
  :description "Game of Thrones timer"
  :version "0.1"
  :author "Pierre Thierry <pierre@nothos.net>"
  :licence "AGPL"
  :depends-on ("scheme" "alexandria" "cl-who" "caveman2" "elephant")
  :components ((:file "package")
	       ;(:file "misc")
	       (:file "shell")
	       (:file "bootstrap")
	       (:file "web"))
  :serial t)
