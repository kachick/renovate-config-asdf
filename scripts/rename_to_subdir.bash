#!/bin/bash

set -eux

for old_path in $(git ls-files 'asdf-plugin-*.json'); do
  mv "$old_path" "plugins/$(echo "$old_path" | grep -Po '(?<=asdf-plugin-)\S+?(?=\.json)').json5"
done
