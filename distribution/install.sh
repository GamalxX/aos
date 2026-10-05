#!/usr/bin/env bash
# AOS Linux / macOS Standalone Installer Script

set -e

echo "====================================================="
echo " 🚀 Installing AOS (Agent Operating System) Core"
echo "====================================================="

# 1. Detect Operating System & Architecture
OS_TYPE="$(uname -s | tr '[:upper:]' '[:lower:]')"
ARCH_TYPE="$(uname -m)"

PLATFORM_TARGET=""
if [[ "$OS_TYPE" == "linux" ]]; then
    PLATFORM_TARGET="linux"
elif [[ "$OS_TYPE" == "darwin" ]]; then
    if [[ "$ARCH_TYPE" == "arm64" ]]; then
        PLATFORM_TARGET="darwin-arm64"
    else
        PLATFORM_TARGET="darwin-x64"
    fi
fi

# 2. Ensure Global ~/.aos Directory
GLOBAL_AOS="$HOME/.aos"
BIN_DIR="$GLOBAL_AOS/bin"
mkdir -p "$BIN_DIR"
echo " • Ensured directory: $BIN_DIR"

# 3. Attempt Standalone Binary Download from Branded Gateway
BINARY_INSTALLED=false
GATEWAY_URL="${AOS_DOWNLOAD_URL:-https://api.aos.run/download/$PLATFORM_TARGET}"
LAUNCHER="$BIN_DIR/aos"

if [[ -n "$PLATFORM_TARGET" ]]; then
    echo " • Fetching latest standalone binary from: $GATEWAY_URL"
    if command -v curl &> /dev/null; then
        if curl -fsSL -L --connect-timeout 10 -o "$LAUNCHER" "$GATEWAY_URL" 2>/dev/null; then
            if [[ -s "$LAUNCHER" && $(wc -c < "$LAUNCHER") -gt 1000000 ]]; then
                chmod +x "$LAUNCHER"
                echo " • Successfully downloaded standalone executable: $LAUNCHER"
                BINARY_INSTALLED=true
            else
                rm -f "$LAUNCHER"
            fi
        fi
    fi
fi

# 4. Fallback: Python launcher script
if [[ "$BINARY_INSTALLED" != "true" ]]; then
    echo " • Standalone binary gateway offline or unavailable. Falling back to local Python wrapper."
    if ! command -v python3 &> /dev/null; then
        echo "❌ Python 3 is required but not found. Please install Python 3.10+."
        exit 1
    fi
    PY_VERSION=$(python3 -c "import sys; print(f'{sys.version_info.major}.{sys.version_info.minor}')")
    echo " • Detected Python: $PY_VERSION"
    
    cat << 'EOF' > "$LAUNCHER"
#!/usr/bin/env bash
python3 -m app.client.cli_setup "$@"
EOF
    chmod +x "$LAUNCHER"
    echo " • Created Python launcher: $LAUNCHER"
fi

# 5. PATH instructions
if [[ ":$PATH:" != *":$BIN_DIR:"* ]]; then
    echo " • Note: Add $BIN_DIR to your PATH in ~/.bashrc or ~/.zshrc:"
    echo "   export PATH=\"\$HOME/.aos/bin:\$PATH\""
fi

echo "====================================================="
echo " ✅ AOS Installation Complete!"
echo " Run 'aos setup' inside any repository to enable."
echo "====================================================="
