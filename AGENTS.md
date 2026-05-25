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
â”œâ”€â”€ alpharm/                    # Alpharm: mobile, web, and admin app family
â”‚   â”œâ”€â”€ alpharm-admin/          # https://gitlab.com/ruyou/alpharm-admin.git
â”‚   â”œâ”€â”€ alpharm-mobile/         # https://gitlab.com/ruyou/alpharm-mobile.git
â”‚   â””â”€â”€ alpharm-web/            # https://gitlab.com/ruyou/alpharm-web.git
â”‚
â”œâ”€â”€ amazi/                      # Amazi AI platform
â”‚   â””â”€â”€ crm-ai-agent/           # https://gitlab.com/mihrjakovsv/crm-ai-agent.git
â”‚
â”œâ”€â”€ bigam/                      # Bigam: webview projects
â”‚   â”œâ”€â”€ bigam-webview/          # https://gitlab.com/ruyou/bigam-webview.git
â”‚   â””â”€â”€ bigam_v5/               # https://gitlab.com/ruyou/bigam_v5.git
â”‚
â”œâ”€â”€ eco-bike/                   # Eco Bike: landing page and frontend
â”‚   â”œâ”€â”€ eco-landing/            # https://gitlab.com/ruyou/eco-landing.git
â”‚   â””â”€â”€ eko-front/              # https://gitlab.com/ruyou/eko-front.git
â”‚
â”œâ”€â”€ expert-teach-center/        # Expert Teach Center: web app + webview shell
â”‚   â”œâ”€â”€ expert-path-app/        # https://github.com/timecapspro/expert-path-app.git
â”‚   â””â”€â”€ expert-teach-center-vebview/ # https://gitlab.com/ruyou/expert-teach-center-webview.git
â”‚
â”œâ”€â”€ mincult/                    # Mincult: admin, frontend, and mobile apps
â”‚   â”œâ”€â”€ mincult-admin-2/        # https://gitlab.com/ruyou/mincult-admin-2.git
â”‚   â”œâ”€â”€ mincult-frontend/       # https://gitlab.com/ruyou/mincult-frontend.git
â”‚   â””â”€â”€ mincult-mobile/         # https://gitlab.com/ruyou/mincult-mobile.git
â”‚
â”œâ”€â”€ music/                      # Health music apps
â”‚   â”œâ”€â”€ music-android/          # https://gitlab.com/ruyou/music-android.git
â”‚   â””â”€â”€ music-ios/              # https://gitlab.com/ruyou/music-ios.git
â”‚
â”œâ”€â”€ on-fasion/                  # On Fashion: Bitrix site and mobile apps
â”‚   â”œâ”€â”€ online-fashion.ru-bitrix/ # https://gitlab.com/ruyou/online-fashion.ru-bitrix.git
â”‚   â”œâ”€â”€ on-fashion-android/     # https://gitlab.com/ruyou/on-fashion-android.git
â”‚   â””â”€â”€ on-fashion-ios/         # https://gitlab.com/ruyou/on-fashion-ios.git
â”‚
â”œâ”€â”€ panic-vpn/                  # Panic VPN project
â”‚   â””â”€â”€ panic-vpn/              # https://gitlab.com/ruyou/panic-vpn.git
â”‚
â”œâ”€â”€ podvijnik/                  # Podvijnik: frontend and backend
â”‚   â”œâ”€â”€ podvijnik-frontend/     # https://gitlab.com/ruyou/podvijnik-frontend.git
â”‚   â””â”€â”€ podvizhnik-backend-php/ # https://gitlab.com/ruyou/podvizhnik-backend-php.git
â”‚
â”œâ”€â”€ premium/                    # Premium: CRM web and service v2
â”‚   â”œâ”€â”€ premium-crm-web/        # https://gitlab.com/ruyou/premium-crm-web.git
â”‚   â””â”€â”€ premium_service_v2/     # https://gitlab.com/ruyou/premium_service_v2.git
â”‚
â”œâ”€â”€ privratnik/                 # Privratnik: personal cabinet and frontend
â”‚   â”œâ”€â”€ lk/                     # https://github.com/crmgpp/lk.git
â”‚   â””â”€â”€ privratnik-frontend/    # https://gitlab.com/ruyou/privratnik-frontend.git
â”‚
â”œâ”€â”€ ruyou/                      # RuYou company project
â”‚   â””â”€â”€ ruyou_black/            # https://gitlab.com/ruyou/ruyou_black.git
â”‚
â”œâ”€â”€ semeli/                     # Semeli frontend
â”‚   â””â”€â”€ semeli-frontend/        # https://gitlab.com/black_ruyou/semeli-frontend.git
â”‚
â””â”€â”€ spektra-diagnostica/        # Spektra Diagnostica page
    â””â”€â”€ spektra-diagnostica-page/ # https://github.com/timecapspro/spektra-diagnostica-page.git
```

