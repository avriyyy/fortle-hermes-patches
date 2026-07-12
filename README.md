# Fortle Hermes Dashboard Patches

Custom branding patches for Hermes Agent dashboard.

## What's Changed

| File | Before | After |
|------|--------|-------|
| `web/index.html` | `<title>Hermes Agent - Dashboard</title>` | `<title>Fortle - Dashboard</title>` |
| `web/src/App.tsx` | Sidebar: "Hermes<br>Agent" | Sidebar: "FORTLE<br>DEV" |
| `web/src/i18n/en.ts` | _(unchanged)_ | _(unchanged)_ |

## Quick Apply (new device)

```bash
# Clone
git clone https://github.com/avriyyy/fortle-hermes-patches.git ~/.hermes/fortle-patches

# Apply + rebuild
cd ~/.hermes/fortle-patches
chmod +x apply.sh
./apply.sh --rebuild

# Restart dashboard
hermes dashboard
```

## Apply Only (skip rebuild)

```bash
./apply.sh
# Then manually rebuild:
cd ~/.hermes/hermes-agent/web && npm install && npm run build
```

## ⚠️ Notes

- Patches will be **overwritten** on `hermes update`. Just re-run `./apply.sh --rebuild` after.
- Requires Node.js + npm for frontend rebuild.
- Only sidebar title and browser tab are customized. i18n brand text ("Hermes Agent") is kept as-is.

## Adding More Patches

1. Make changes in `~/.hermes/hermes-agent/web/`
2. Generate patch: `cd ~/.hermes/hermes-agent && git diff web/src/ web/index.html > ~/fortle-hermes-patches/fortle-brand.patch`
3. Update `apply.sh` if needed
4. Commit + push to GitHub
