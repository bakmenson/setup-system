#!/bin/bash

emacs --batch --eval "(require 'org)" --eval '(org-babel-tangle-file "setup-system/README.org")'
