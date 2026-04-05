#!/usr/bin/env bash
# Shared language detection library for AI Teams

_AI_TEAMS_PROJECT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
_AI_TEAMS_ROLES_DIR="$_AI_TEAMS_PROJECT_DIR/roles"

_detect_locale() {
  local lang_env="${LANG:-${LC_ALL:-en}}"
  local lang_code="${lang_env%%[_.]*}"
  case "$lang_code" in
    zh) echo "zh-CN" ;;
    *)  echo "en" ;;
  esac
}

ai_teams_locale() {
  local locale="${AI_TEAM_LANG:-$(_detect_locale)}"
  if [ -d "$_AI_TEAMS_ROLES_DIR/$locale" ]; then
    echo "$locale"
  else
    echo "en"
  fi
}

ai_teams_available_locales() {
  for dir in "$_AI_TEAMS_ROLES_DIR"/*/; do
    [ -d "$dir" ] && basename "$dir"
  done
}
