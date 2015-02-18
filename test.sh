#!/bin/bash
npm install editorconfig-tools

git ls-files | egrep "\.(js|css|json|html)$" | xargs -I '{}' node_modules/.bin/editorconfig-tools check '{}'
