# RuYou Workspace Agent Navigation

This is the parent workspace for active work projects. Treat it as a multi-project container, not as a single repository.

## Safety Rules

- Work on one top-level project folder at a time.
- Before changes that could affect several projects, stop and confirm the scope with the user.
- Do not run broad formatting, dependency updates, mass renames, or cross-repository scripts unless explicitly requested.
- Prefer each repository's own `AGENTS.md` and `docs/` before inspecting implementation files.
- Do not use repository `README.md` files as the main AI-agent source of truth when `AGENTS.md` or `docs/` exist.

## Workspace Tree

Note: right now every tracked repository in this workspace points to the same `origin`:
`https://gitlab.com/ruyou/egormity-dev-env.git`

```text
.
├── alpharm/                    # Alpharm: mobile, web, and admin app family
│   ├── alpharm-admin/          # https://gitlab.com/ruyou/egormity-dev-env.git
│   ├── alpharm-mobile/         # https://gitlab.com/ruyou/egormity-dev-env.git
│   └── alpharm-web/            # https://gitlab.com/ruyou/egormity-dev-env.git
│
├── amazi/                      # Amazi AI platform
│   └── crm-ai-agent/           # https://gitlab.com/ruyou/egormity-dev-env.git
│
├── bigam/                      # Bigam: webview project
│   └── bigam-webview/          # https://gitlab.com/ruyou/egormity-dev-env.git
│
├── eco-bike/                   # Eco Bike: landing page and frontend
│   ├── eco-landing/            # https://gitlab.com/ruyou/egormity-dev-env.git
│   └── eko-front/              # https://gitlab.com/ruyou/egormity-dev-env.git
│
├── expert-teach-center/        # Expert Teach Center: web app + webview shell
│   ├── expert-path-app/        # https://gitlab.com/ruyou/egormity-dev-env.git
│   └── expert-teach-center-vebview/ # https://gitlab.com/ruyou/egormity-dev-env.git
│
├── mincult/                    # Mincult: admin, frontend, and mobile apps
│   ├── mincult-admin-2/        # https://gitlab.com/ruyou/egormity-dev-env.git
│   ├── mincult-frontend/       # https://gitlab.com/ruyou/egormity-dev-env.git
│   └── mincult-mobile/         # https://gitlab.com/ruyou/egormity-dev-env.git
│
├── music/                      # Health music apps
│   ├── music-android/          # https://gitlab.com/ruyou/egormity-dev-env.git
│   └── music-ios/              # https://gitlab.com/ruyou/egormity-dev-env.git
│
├── on-fasion/                  # On Fashion: Bitrix site and mobile apps
│   ├── online-fashion.ru-bitrix/ # https://gitlab.com/ruyou/egormity-dev-env.git
│   ├── on-fashion-android/     # https://gitlab.com/ruyou/egormity-dev-env.git
│   └── on-fashion-ios/         # https://gitlab.com/ruyou/egormity-dev-env.git
│
├── panic-vpn/                  # Panic VPN project
│   └── panic-vpn/              # https://gitlab.com/ruyou/egormity-dev-env.git
│
├── podvijnik/                  # Podvijnik: frontend and backend
│   ├── podvijnik-frontend/     # https://gitlab.com/ruyou/egormity-dev-env.git
│   └── podvizhnik-backend-php/ # https://gitlab.com/ruyou/egormity-dev-env.git
│
├── premium/                    # Premium: CRM web and service v2
│   ├── premium-crm-web/        # https://gitlab.com/ruyou/egormity-dev-env.git
│   └── premium_service_v2/     # https://gitlab.com/ruyou/egormity-dev-env.git
│
├── privratnik/                 # Privratnik: personal cabinet and frontend
│   ├── lk/                     # https://gitlab.com/ruyou/egormity-dev-env.git
│   └── privratnik-frontend/    # https://gitlab.com/ruyou/egormity-dev-env.git
│
├── ruyou/                      # RuYou company project
│   └── ruyou_black/            # https://gitlab.com/ruyou/egormity-dev-env.git
│
├── semeli/                     # Semeli frontend
│   └── semeli-frontend/        # https://gitlab.com/ruyou/egormity-dev-env.git
│
└── spektra-diagnostica/        # Spektra Diagnostica page
    └── spektra-diagnostica-page/ # https://gitlab.com/ruyou/egormity-dev-env.git
```
