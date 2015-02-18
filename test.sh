#!/bin/bash
npm install editorconfig-tools > /dev/null

git ls-files | egrep "\.(js|css|json|html)$" | xargs -I '{}' node_modules/.bin/editorconfig-tools check '{}' | awk '$2 == "failed" { print $0 }'

for p in ${PIPESTATUS[@]}; do
  [ ${p} -ne 0 ] && exit 1
done

# vim: set ts=2 sw=2 tw=0:
