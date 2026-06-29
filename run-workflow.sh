#!/usr/bin/env bash
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
ALL_SOURCES="https://github.com/Egormity, https://gitlab.com/ruyou, https://gitlab.com/mihrjakovsv, https://gitlab.com/black_ruyou, https://github.com/timecapspro"
EGORMITY_SOURCE="https://github.com/Egormity"
RUYOU_SOURCES="https://gitlab.com/ruyou, https://gitlab.com/mihrjakovsv, https://gitlab.com/black_ruyou, https://github.com/timecapspro"

run_step() {
  local label="$1"
  shift

  printf '\n> %s\n' "$label"
  "$@"
}

if ! command -v egormity_git_tools >/dev/null 2>&1; then
  echo "egormity_git_tools was not found in PATH." >&2
  exit 127
fi

cd "$ROOT_DIR"

run_step "Generate all docs" \
  egormity_git_tools generate_agents "$ALL_SOURCES" ./

run_step "Clone Egormity repositories" \
  egormity_git_tools clone_all "$EGORMITY_SOURCE"

run_step "Generate Egormity AGENTS.md files" \
  egormity_git_tools generate_agents "$EGORMITY_SOURCE" ./egormity

run_step "Clone RuYou repositories" \
  egormity_git_tools clone_all "$RUYOU_SOURCES" ruyou

run_step "Generate RuYou workspace AGENTS.md files" \
  egormity_git_tools generate_agents "$RUYOU_SOURCES" ruyou

cd ruyou

run_step "Generate ruyou AGENTS.md files" \
  egormity_git_tools generate_agents "https://gitlab.com/ruyou"

run_step "Generate mihrjakovsv AGENTS.md files" \
  egormity_git_tools generate_agents "https://gitlab.com/mihrjakovsv"

run_step "Generate black_ruyou AGENTS.md files" \
  egormity_git_tools generate_agents "https://gitlab.com/black_ruyou"

run_step "Generate timecapspro AGENTS.md files" \
  egormity_git_tools generate_agents "https://github.com/timecapspro"
