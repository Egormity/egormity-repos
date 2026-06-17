# RuYou Workspace Agent Navigation

This is the parent workspace for active work projects. Treat it as a multi-project container, not as a single repository.

## Safety Rules

- Work on one top-level project folder at a time.
- Before changes that could affect several projects, stop and confirm the scope with the user.
- Do not run broad formatting, dependency updates, mass renames, or cross-repository scripts unless explicitly requested.
- Prefer each repository's own `AGENTS.md` and `docs/` before inspecting implementation files.
- Do not use repository `README.md` files as the main AI-agent source of truth when `AGENTS.md` or `docs/` exist.

## Workspace Tree

Note: repository remotes may differ by project; links below are current `origin` values.

```text
.
├── alpharm/                    # Alpharm: mobile, web, and admin app family
│   ├── alpharm-admin/          # https://gitlab.com/ruyou/alpharm-admin.git
│   ├── alpharm-mobile/         # https://gitlab.com/ruyou/alpharm-mobile.git
│   └── alpharm-web/            # https://gitlab.com/ruyou/alpharm-web.git
│
├── amazi/                      # Amazi AI platform
│   └── crm-ai-agent/           # https://gitlab.com/mihrjakovsv/crm-ai-agent.git
│
├── bigam/                      # Bigam: webview projects
│   ├── bigam-webview/          # https://gitlab.com/ruyou/bigam-webview.git
│   └── bigam_v5/               # https://gitlab.com/ruyou/bigam_v5.git
│
├── eco-bike/                   # Eco Bike: landing page and frontend
│   ├── eco-landing/            # https://gitlab.com/ruyou/eco-landing.git
│   └── eko-front/              # https://gitlab.com/ruyou/eko-front.git
│
├── expert-teach-center/        # Expert Teach Center: web app + webview shell
│   ├── expert-path-app/        # https://github.com/timecapspro/expert-path-app.git
│   └── expert-teach-center-vebview/ # https://gitlab.com/ruyou/expert-teach-center-webview.git
│
├── mincult/                    # Mincult: backend, admin, frontend, and mobile apps
│   ├── mincult-admin-2/        # https://gitlab.com/ruyou/mincult-admin-2.git
│   ├── mincult-backend/        # https://gitlab.com/ruyou/mincult-backend.git
│   ├── mincult-frontend/       # https://gitlab.com/ruyou/mincult-frontend.git
│   └── mincult-mobile/         # https://gitlab.com/ruyou/mincult-mobile.git
│
├── music/                      # Health music apps
│   ├── music-android/          # https://gitlab.com/ruyou/music-android.git
│   └── music-ios/              # https://gitlab.com/ruyou/music-ios.git
│
├── on-fasion/                  # On Fashion: Bitrix site and mobile apps
│   ├── online-fashion.ru-bitrix/ # https://gitlab.com/ruyou/online-fashion.ru-bitrix.git
│   ├── on-fashion-android/     # https://gitlab.com/ruyou/on-fashion-android.git
│   └── on-fashion-ios/         # https://gitlab.com/ruyou/on-fashion-ios.git
│
├── panic-vpn/                  # Panic VPN project
│   └── panic-vpn/              # https://gitlab.com/ruyou/panic-vpn.git
│
├── podvijnik/                  # Podvijnik: frontend and backend
│   ├── podvijnik-frontend/     # https://gitlab.com/ruyou/podvijnik-frontend.git
│   └── podvizhnik-backend-php/ # https://gitlab.com/ruyou/podvizhnik-backend-php.git
│
├── premium/                    # Premium: CRM web and service v2
│   ├── premium-crm-web/        # https://gitlab.com/ruyou/premium-crm-web.git
│   └── premium_service_v2/     # https://gitlab.com/ruyou/premium_service_v2.git
│
├── privratnik/                 # Privratnik: personal cabinet and frontend
│   ├── lk/                     # https://github.com/crmgpp/lk.git
│   └── privratnik-frontend/    # https://gitlab.com/ruyou/privratnik-frontend.git
│
├── ruyou/                      # RuYou company project
│   └── ruyou_black/            # https://gitlab.com/ruyou/ruyou_black.git
│
├── semeli/                     # Semeli frontend
│   └── semeli-frontend/        # https://gitlab.com/black_ruyou/semeli-frontend.git
│
└── spektra-diagnostica/        # Spektra Diagnostica page
    └── spektra-diagnostica-page/ # https://github.com/timecapspro/spektra-diagnostica-page.git
```
