#!/bin/bash

emacs --batch --eval "(require 'org)" --eval '(org-babel-tangle-file "setup-system/README.org")'
bash setup-system/setup-system.sh
rm setup-system/setup-system.sh
