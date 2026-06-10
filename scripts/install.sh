#!/usr/bin/env sh
set -eu

repo_dir=$(CDPATH= cd -- "$(dirname -- "$0")/.." && pwd)
timestamp=$(date +%Y%m%d-%H%M%S)

link_config() {
  source_path=$1
  target_path=$2

  mkdir -p "$(dirname "$target_path")"

  if [ -L "$target_path" ]; then
    current_target=$(readlink "$target_path")
    if [ "$current_target" = "$source_path" ]; then
      printf 'Already linked: %s\n' "$target_path"
      return
    fi
  fi

  if [ -e "$target_path" ] || [ -L "$target_path" ]; then
    backup_path="${target_path}.${timestamp}.bak"
    mv "$target_path" "$backup_path"
    printf 'Backed up: %s -> %s\n' "$target_path" "$backup_path"
  fi

  ln -s "$source_path" "$target_path"
  printf 'Linked: %s -> %s\n' "$target_path" "$source_path"
}

link_config "$repo_dir/cmux/cmux.json" "$HOME/.config/cmux/cmux.json"
link_config "$repo_dir/ghostty/config" "$HOME/.config/ghostty/config"

printf '\nRun this to apply changes without restarting cmux:\n'
printf '  cmux reload-config\n'

