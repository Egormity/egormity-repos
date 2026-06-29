#!/usr/bin/env bash
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
EGORMITY_SOURCE="https://github.com/Egormity"
RUYOU_SOURCES=(
  "https://gitlab.com/ruyou"
  "https://gitlab.com/mihrjakovsv"
  "https://gitlab.com/black_ruyou"
  "https://github.com/timecapspro"
)
ALL_SOURCES=("$EGORMITY_SOURCE" "${RUYOU_SOURCES[@]}")
ACCESSIBLE_SOURCES=()
ACCESSIBLE_RUYOU_SOURCES=()
SKIPPED_SOURCES=()
PROBE_DIR="$(mktemp -d)"

cleanup() {
  rm -rf "$PROBE_DIR"
}
trap cleanup EXIT

join_sources() {
  local joined=""
  local source

  for source in "$@"; do
    if [[ -n "$joined" ]]; then
      joined+=", "
    fi

    joined+="$source"
  done

  printf '%s' "$joined"
}

contains_source() {
  local needle="$1"
  shift
  local source

  for source in "$@"; do
    if [[ "$source" == "$needle" ]]; then
      return 0
    fi
  done

  return 1
}

test_source_access() {
  local source="$1"

  egormity_git_tools get_account_info "$source" account.json "$PROBE_DIR" >/dev/null 2>&1
}

run_optional_step() {
  local label="$1"
  shift

  printf '\n> %s\n' "$label"

  if ! "$@"; then
    printf 'Warning: skipped failed step: %s\n' "$label" >&2
    return 0
  fi
}

if ! command -v egormity_git_tools >/dev/null 2>&1; then
  echo "egormity_git_tools was not found in PATH." >&2
  exit 127
fi

cd "$ROOT_DIR"

for source in "${ALL_SOURCES[@]}"; do
  printf '\n> Check access: %s\n' "$source"

  if test_source_access "$source"; then
    ACCESSIBLE_SOURCES+=("$source")
    printf 'Accessible\n'
  else
    SKIPPED_SOURCES+=("$source")
    printf 'Warning: skipping inaccessible namespace: %s\n' "$source" >&2
  fi
done

if [[ "${#ACCESSIBLE_SOURCES[@]}" -eq 0 ]]; then
  echo "Warning: no accessible namespaces found; nothing to do." >&2
  exit 0
fi

run_optional_step "Generate all docs" \
  egormity_git_tools generate_agents "$(join_sources "${ACCESSIBLE_SOURCES[@]}")" ./

if contains_source "$EGORMITY_SOURCE" "${ACCESSIBLE_SOURCES[@]}"; then
  run_optional_step "Clone Egormity repositories" \
    egormity_git_tools clone_all "$EGORMITY_SOURCE"

  run_optional_step "Generate Egormity AGENTS.md files" \
    egormity_git_tools generate_agents "$EGORMITY_SOURCE" ./egormity
fi

for source in "${RUYOU_SOURCES[@]}"; do
  if contains_source "$source" "${ACCESSIBLE_SOURCES[@]}"; then
    ACCESSIBLE_RUYOU_SOURCES+=("$source")
  fi
done

if [[ "${#ACCESSIBLE_RUYOU_SOURCES[@]}" -gt 0 ]]; then
  run_optional_step "Clone RuYou repositories" \
    egormity_git_tools clone_all "$(join_sources "${ACCESSIBLE_RUYOU_SOURCES[@]}")" ruyou

  run_optional_step "Generate RuYou workspace AGENTS.md files" \
    egormity_git_tools generate_agents "$(join_sources "${ACCESSIBLE_RUYOU_SOURCES[@]}")" ruyou

  if [[ -d ruyou ]]; then
    cd ruyou

    for source in "${ACCESSIBLE_RUYOU_SOURCES[@]}"; do
      run_optional_step "Generate $source AGENTS.md files" \
        egormity_git_tools generate_agents "$source"
    done
  else
    echo "Warning: skipping per-namespace RuYou AGENTS.md files because the ruyou folder does not exist." >&2
  fi
fi

if [[ "${#SKIPPED_SOURCES[@]}" -gt 0 ]]; then
  printf '\nSkipped inaccessible namespaces:\n'
  printf -- '- %s\n' "${SKIPPED_SOURCES[@]}"
fi
