# Fortle Hermes Dashboard Patches

Custom branding patches for Hermes Agent dashboard.

## What's Changed

| File | Change |
|------|--------|
| `web/index.html` | Title: "Hermes Agent" → "Fortle" |
| `web/src/App.tsx` | Sidebar: "Hermes Agent" → "FORTLE DEV" |
| `web/src/i18n/en.ts` | Brand: "Hermes Agent" → "FORTLE.DEV" |

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
- Only English i18n is patched. Other languages still show "Hermes Agent".

## Adding More Patches

1. Make changes in `~/.hermes/hermes-agent/web/`
2. Generate patch: `cd ~/.hermes/hermes-agent && git diff > ~/fortle-hermes-patches/new.patch`
3. Update `apply.sh` to include the new patch
4. Push to GitHub
