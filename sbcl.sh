#!/bin/sh

exec sbcl --eval '(ql:quickload "jin-ador")' --eval "(in-package :jin-ador)" --eval "(clackup $1)"
