#!/usr/bin/env bash
set -euo pipefail

# Fortle Hermes Dashboard Patcher
# Apply custom branding patches to Hermes Agent dashboard
# Usage: ./apply.sh [--rebuild]
#   --rebuild  Also rebuild the frontend (requires node + npm)

HERMES_DIR="${HERMES_HOME:-$HOME/.hermes}/hermes-agent"
SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
PATCH_FILE="$SCRIPT_DIR/fortle-brand.patch"

echo "🎨 Fortle Hermes Dashboard Patcher"
echo "==================================="
echo ""

# Check hermes-agent exists
if [ ! -d "$HERMES_DIR" ]; then
    echo "❌ Hermes Agent not found at: $HERMES_DIR"
    exit 1
fi

# Check patch file
if [ ! -f "$PATCH_FILE" ]; then
    echo "❌ Patch file not found: $PATCH_FILE"
    exit 1
fi

cd "$HERMES_DIR"

# Check if already applied
if git diff --quiet web/src/i18n/en.ts web/src/App.tsx web/index.html 2>/dev/null; then
    # Check if the patch would apply cleanly
    if git apply --check "$PATCH_FILE" 2>/dev/null; then
        echo "📝 Applying patches..."
        git apply "$PATCH_FILE"
        echo "✅ Patches applied!"
    else
        echo "⚠️  Patches already applied or files modified differently."
        echo "   To force reapply: git apply --reverse --check $PATCH_FILE && git apply $PATCH_FILE"
    fi
else
    # Files already modified, try applying
    if git apply --check "$PATCH_FILE" 2>/dev/null; then
        echo "📝 Applying patches..."
        git apply "$PATCH_FILE"
        echo "✅ Patches applied!"
    else
        echo "⚠️  Some changes already exist. Attempting partial apply..."
        git apply --reject "$PATCH_FILE" 2>/dev/null || true
        echo "⚠️  Check .rej files for conflicts."
    fi
fi

# Rebuild if requested
if [[ "${1:-}" == "--rebuild" ]]; then
    echo ""
    echo "🔨 Rebuilding frontend..."
    if ! command -v npm &>/dev/null; then
        echo "❌ npm not found. Install Node.js first."
        exit 1
    fi
    cd "$HERMES_DIR/web"
    
    # Install deps if needed
    if [ ! -d "node_modules" ]; then
        echo "📦 Installing dependencies..."
        npm install 2>&1 | tail -3
    fi
    
    npm run build 2>&1 | tail -5
    echo ""
    echo "✅ Frontend rebuilt!"
fi

echo ""
echo "🔄 Restart dashboard: hermes dashboard"
echo "   Then hard refresh browser: Ctrl+Shift+R"
