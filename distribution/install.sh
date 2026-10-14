#!/usr/bin/env bash
# AOS Frictionless One-Line Onboarding Installer for macOS and Linux
set -e

echo "====================================================="
echo " ⚡ Installing AOS (Agent Operating System)"
echo "====================================================="

# 1. Detect Python 3.11+
if command -v python3 &>/dev/null; then
    PY_CMD="python3"
elif command -v python &>/dev/null; then
    PY_CMD="python"
else
    echo "❌ Error: Python 3 is required but not found. Please install Python 3.11+." >&2
    exit 1
fi

PY_VER=$($PY_CMD -c "import sys; print(f'{sys.version_info.major}.{sys.version_info.minor}')")
MAJOR=$(echo "$PY_VER" | cut -d. -f1)
MINOR=$(echo "$PY_VER" | cut -d. -f2)

if [ "$MAJOR" -lt 3 ] || [ "$MAJOR" -eq 3 -a "$MINOR" -lt 11 ]; then
    echo "❌ Error: AOS requires Python 3.11+. Detected Python $PY_VER" >&2
    exit 1
fi
echo " • Python Version: $PY_VER (OK)"

# 2. Determine Repository Root & Virtual Environment
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
if [[ "$SCRIPT_DIR" == */scripts* ]]; then
    REPO_ROOT="$(dirname "$SCRIPT_DIR")"
else
    REPO_ROOT="$SCRIPT_DIR"
fi

VENV_DIR="$REPO_ROOT/.venv"
VENV_PY="$VENV_DIR/bin/python"

if [ ! -f "$VENV_PY" ]; then
    echo " • Creating virtual environment in $VENV_DIR..."
    $PY_CMD -m venv "$VENV_DIR"
fi

# 3. Locate & Install Wheel Package
WHEEL=$(find "$REPO_ROOT/dist" -name "*.whl" 2>/dev/null | sort | tail -n 1)

if [ -n "$WHEEL" ] && [ -f "$WHEEL" ]; then
    echo " • Installing AOS from package: $(basename "$WHEEL")..."
    "$VENV_PY" -m pip install "$WHEEL" --force-reinstall --quiet
else
    echo " • Fetching latest release package..."
    RELEASE_URL="https://github.com/GamalxX/aos/releases/latest/download/aos-1.0.0-py3-none-any.whl"
    "$VENV_PY" -m pip install "$RELEASE_URL" --force-reinstall --quiet || "$VENV_PY" -m pip install aos --quiet
fi

# 4. Auto-Inject MCP Config for Detected Editors
AOS_BIN="$VENV_DIR/bin/aos"
if [ -f "$AOS_BIN" ]; then
    echo " • Injecting MCP configuration into detected IDEs..."
    "$AOS_BIN" setup
    echo " • Running system diagnostics..."
    "$AOS_BIN" doctor
else
    "$VENV_PY" -m app.client.entrypoint setup
    "$VENV_PY" -m app.client.entrypoint doctor
fi

echo "====================================================="
echo " ✅ AOS Setup Complete!"
echo " Control Center UI:  http://127.0.0.1:4141"
echo " Run MCP Server:     aos-mcp"
echo " Run Control Center: aos-settings"
echo "====================================================="
