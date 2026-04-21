#!/usr/bin/env bash
# Hekivo Web SessionStart hook — base context for FREE tier.
# Inline project detection only (no scripts/ dir).
# Sets HEKIVO_WEB_LOADED=1 marker so hekivo-pro can detect the base.

set -uo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]:-$0}")" && pwd)"
PLUGIN_ROOT="$(cd "${SCRIPT_DIR}/.." && pwd)"

# shellcheck source=/dev/null
source "${SCRIPT_DIR}/hekivo-web-lib.sh"

# Inline Sage detection
FOUND=$(hekivo_web_is_sage_project ".")
if [ -z "$FOUND" ]; then
  # Not a Sage project — emit an empty-context event but still set the marker
  cat <<EOF
{
  "hookSpecificOutput": {
    "hookEventName": "SessionStart",
    "additionalContext": "<!-- hekivo-web loaded; no Sage project in cwd -->"
  }
}
EOF
  exit 0
fi

THEME_DIR=$(dirname "$FOUND")
THEME_REL="${THEME_DIR#./}"

LANDO_YML="no"
[ -f ".lando.yml" ] && LANDO_YML="yes"

LIVEWIRE="no"
[ -f "${THEME_REL}/composer.json" ] && grep -q "acorn-livewire" "${THEME_REL}/composer.json" 2>/dev/null && LIVEWIRE="yes"

SKILL_CONTENT=""
if [ -f "${PLUGIN_ROOT}/skills/hekivoing/SKILL.md" ]; then
  SKILL_CONTENT=$(cat "${PLUGIN_ROOT}/skills/hekivoing/SKILL.md" 2>/dev/null || true)
fi
SKILL_ESCAPED=$(hekivo_web_json_escape "$SKILL_CONTENT")

SUMMARY="Hekivo Web (Free) loaded. Sage/Acorn project detected at: ${THEME_REL}"
SUMMARY="${SUMMARY}\nLando: ${LANDO_YML} | Livewire: ${LIVEWIRE}"
SUMMARY="${SUMMARY}\n\nFREE tier skills available: hekivoing, onboarding, sage-lando, install-plugin, wp-cli-ops."
SUMMARY="${SUMMARY}\nUpgrade to Pro for the full toolkit: https://hekivo.com/pro"
SUMMARY="${SUMMARY}\n\n${SKILL_ESCAPED}"

cat <<EOF
{
  "hookSpecificOutput": {
    "hookEventName": "SessionStart",
    "additionalContext": "<EXTREMELY_IMPORTANT>\nHEKIVO_WEB_LOADED=1\n${SUMMARY}\n</EXTREMELY_IMPORTANT>"
  }
}
EOF

exit 0
