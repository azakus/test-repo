#!/bin/bash

# Copyright (c) 2015 The Polymer Project Authors. All rights reserved.
# This code may only be used under the BSD style license found at http://polymer.github.io/LICENSE.txt
# The complete set of authors may be found at http://polymer.github.io/AUTHORS.txt
# The complete set of contributors may be found at http://polymer.github.io/CONTRIBUTORS.txt
# Code distributed by Google as part of the polymer project is also
# subject to an additional IP rights grant found at http://polymer.github.io/PATENTS.txt

# editorconfig-tools only has a CLI option :(
npm install editorconfig-tools > /dev/null

# Pipeline steps
# 0 - get all files
# 1 - filter for js, css, json, and html
# 2 - run editorconfig-tools check on those files
# 3 - only print failed output
git ls-files | egrep "\.(js|css|json|html)$" | xargs -I '{}' node_modules/.bin/editorconfig-tools check '{}' | awk '$2 == "failed" { print $0 }'

# PIPESTATUS is an array of exit codes for each function in the pipe
# index 2 failure means editorconfig-tools found a non-conforming file
if [ ${PIPESTATUS[2]} -ne 0 ]; then
  exit 1
fi
