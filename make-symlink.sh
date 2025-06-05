#!/bin/bash

script_dir=$(dirname -- "${BASH_SOURCE[0]}")

mkdir -p "$HOME"/bin
for f in "$script_dir"/bin/*; do
  ln -s "$(realpath "$f")" "$HOME"/bin/"$(basename -- "$f")"
done
