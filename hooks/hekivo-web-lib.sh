#!/usr/bin/env bash
# Shared helpers for Hekivo Web hooks.
# NOTE: Pro ships its own lib at hekivo-pro-lib.sh. Do not rely on cross-plugin sourcing.

hekivo_web_json_escape() {
  local input="$1"
  echo "$input" | sed 's/\\/\\\\/g' | sed 's/"/\\"/g' | awk '{printf "%s\\n", $0}'
}

hekivo_web_is_sage_project() {
  local root="${1:-.}"
  find "$root" \( -path '*/.git*' -o -path '*/node_modules*' -o -path '*/vendor*' -o -path '*/storage*' -o -path '*/.claude/*' \) -prune \
    -o -type f -name "composer.json" -print 2>/dev/null | head -20 | xargs grep -l '"roots/acorn"' 2>/dev/null | head -1
}
