# Egormity Repositories

This repository contains generated project files and supporting workspace content.

All content in this repository was generated with [Egormity/egormity-tools](https://github.com/Egormity/egormity-tools).

The installed CLI command is `egormity_git_tools`.

## My workflow

Use the root workflow script to regenerate the repository workspace from the configured GitHub and GitLab accounts.
Each script checks namespace access first. If a user or namespace is not accessible, it is skipped and the rest of the workflow continues.

### Windows

Run from PowerShell:

```powershell
.\run-workflow.ps1
```

### macOS and Linux

Run from a POSIX shell:

```bash
./run-workflow.sh
```

If the script is not executable after checkout, run:

```bash
chmod +x ./run-workflow.sh
./run-workflow.sh
```

## Workflow steps

The scripts run these steps in order. Inaccessible namespaces and failed namespace-specific steps are reported and skipped:

1. Check access for every configured account URL with `egormity_git_tools get_account_info`.
2. Skip inaccessible namespaces.
3. Generate all docs for every accessible configured account.
4. Clone repositories from `https://github.com/Egormity` when it is accessible.
5. Generate AGENTS.md files for the Egormity workspace when it is accessible.
6. Clone repositories from accessible RuYou-related GitLab/GitHub accounts into `ruyou`.
7. Generate AGENTS.md files for the combined accessible RuYou workspace.
8. Generate separate AGENTS.md files inside `ruyou` for accessible namespaces:
   - `https://gitlab.com/ruyou`
   - `https://gitlab.com/mihrjakovsv`
   - `https://gitlab.com/black_ruyou`
   - `https://github.com/timecapspro`

## egormity_git_tools reference

Reusable help output from `egormity_git_tools --help`:

```text
egormity_git_tools 0.3.6

Usage:
  egormity_git_tools <command> [args]
  python -m egormity_git_tools <command> [args]
  Use comma or semicolon separated URLs for multi-account commands.

Commands:
  init_clis                                Verify required GitHub and GitLab CLIs are installed and authenticated.
  get_account_info <urls> [filename] [path] Write account repository metadata to JSON.
  generate_agents <urls> [folder] [path]   Generate an AGENTS.md navigation file for account workspaces.
  clone_all <urls> [folder] [path]         Clone all repositories from GitHub or GitLab accounts.
  init <urls> [folder] [path]              Clone all repositories and generate AGENTS.md navigation files.
  pull_all_current_bnach <path>            Pull the current branch for every repository under a path.
  push_all_current_branch <path>           Push the current branch for every repository under a path.

Options:
  -h, --help                              Show this help message.
  --version, --v                          Show the installed tool version.
```
