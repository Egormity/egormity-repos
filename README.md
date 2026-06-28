# Egormity Repositories

This repository contains generated project files and supporting workspace content.

All content in this repository was generated with [Egormity/egormity-tools](https://github.com/Egormity/egormity-tools).

## My workflow

### Generate all the docs

- egormity_git_tools generate_agents "https://github.com/Egormity, https://gitlab.com/ruyou, https://gitlab.com/mihrjakovsv, https://gitlab.com/black_ruyou, https://github.com/timecapspro" ./

### Generate my account

- egormity_git_tools clone_all "https://github.com/Egormity"
- egormity_git_tools generate_agents "https://github.com/Egormity" ./egormity

### Generate RuYou

- egormity_git_tools clone_all "https://gitlab.com/ruyou, https://gitlab.com/mihrjakovsv, https://gitlab.com/black_ruyou, https://github.com/timecapspro" ruyou
- egormity_git_tools generate_agents "https://gitlab.com/ruyou, https://gitlab.com/mihrjakovsv, https://gitlab.com/black_ruyou, https://github.com/timecapspro" ruyou
- cd ruyou
- egormity_git_tools generate_agents "https://gitlab.com/ruyou"
- egormity_git_tools generate_agents "https://gitlab.com/mihrjakovsv"
- egormity_git_tools generate_agents "https://gitlab.com/black_ruyou"
- egormity_git_tools generate_agents "https://github.com/timecapspro"
