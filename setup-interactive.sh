#!/bin/bash

# Interactive setup script for NenAI MCP
# Prompts for credentials and generates installation options

set -e

echo "============================================"
echo "  NenAI MCP Interactive Setup"
echo "============================================"
echo ""

# Check if env vars are already set
if [ -n "$NEN_API_KEY" ] && [ -n "$NEN_MCP_URL" ]; then
    echo "✓ Found existing environment variables:"
    echo "  NEN_API_KEY: ${NEN_API_KEY:0:10}..."
    echo "  NEN_MCP_URL: $NEN_MCP_URL"
    echo ""
    read -p "Use these values? (Y/n): " use_existing
    
    if [[ "$use_existing" =~ ^[Nn]$ ]]; then
        unset NEN_API_KEY
        unset NEN_MCP_URL
    fi
fi

# Prompt for API key if not set
if [ -z "$NEN_API_KEY" ]; then
    echo "Enter your NenAI API Key:"
    echo "(Get this from your NenAI customer engineer)"
    read -r NEN_API_KEY
    
    if [ -z "$NEN_API_KEY" ]; then
        echo "❌ Error: API key cannot be empty"
        exit 1
    fi
fi

# Prompt for MCP URL if not set
if [ -z "$NEN_MCP_URL" ]; then
    echo ""
    echo "Enter your NenAI MCP URL:"
    echo "(Get this from your NenAI customer engineer)"
    echo "Example: https://mcp.getnen.ai/"
    read -r NEN_MCP_URL
    
    if [ -z "$NEN_MCP_URL" ]; then
        echo "❌ Error: MCP URL cannot be empty"
        exit 1
    fi
fi

echo ""
echo "============================================"
echo "  Choose Installation Method"
echo "============================================"
echo ""
echo "1. One-Click Install (Cursor Deeplink)"
echo "   - Automatic configuration"
echo "   - Opens directly in Cursor"
echo "   - Recommended for most users"
echo ""
echo "2. Manual Configuration"
echo "   - Creates ~/.cursor/mcp.json"
echo "   - More control over setup"
echo ""
read -p "Select method (1 or 2): " method

if [ "$method" = "1" ]; then
    # Generate deeplink
    echo ""
    echo "Generating one-click install link..."
    
    # Create JSON config
    config_json=$(cat <<EOF
{
  "url": "\${env:NEN_MCP_URL}",
  "headers": {
    "X-Api-Key": "\${env:NEN_API_KEY}"
  }
}
EOF
)
    
    # Base64 encode (different command for macOS vs Linux)
    if [[ "$OSTYPE" == "darwin"* ]]; then
        config_base64=$(echo -n "$config_json" | base64)
    else
        config_base64=$(echo -n "$config_json" | base64 -w 0)
    fi
    
    deeplink="cursor://anysphere.cursor-deeplink/mcp/install?name=nenai&config=$config_base64"
    
    echo ""
    echo "✅ Installation link generated!"
    echo ""
    echo "════════════════════════════════════════════"
    echo "IMPORTANT: Set these environment variables"
    echo "in your shell profile (~/.zshrc or ~/.bashrc):"
    echo "════════════════════════════════════════════"
    echo ""
    echo "export NEN_API_KEY=\"$NEN_API_KEY\""
    echo "export NEN_MCP_URL=\"$NEN_MCP_URL\""
    echo ""
    echo "Then run: source ~/.zshrc  (or ~/.bashrc)"
    echo ""
    echo "════════════════════════════════════════════"
    echo "One-Click Install Link:"
    echo "════════════════════════════════════════════"
    echo ""
    echo "$deeplink"
    echo ""
    
    # Try to open the deeplink automatically
    read -p "Open Cursor now to install? (Y/n): " open_now
    if [[ ! "$open_now" =~ ^[Nn]$ ]]; then
        if command -v open &> /dev/null; then
            open "$deeplink"
            echo "✓ Opening Cursor..."
        elif command -v xdg-open &> /dev/null; then
            xdg-open "$deeplink"
            echo "✓ Opening Cursor..."
        else
            echo "⚠ Could not auto-open. Copy the link above and paste it in your browser."
        fi
    fi
    
elif [ "$method" = "2" ]; then
    # Manual configuration
    CURSOR_DIR="$HOME/.cursor"
    mkdir -p "$CURSOR_DIR"
    
    MCP_CONFIG="$CURSOR_DIR/mcp.json"
    
    cat > "$MCP_CONFIG" << 'EOF'
{
  "mcpServers": {
    "nenai": {
      "url": "${env:NEN_MCP_URL}",
      "headers": {
        "X-Api-Key": "${env:NEN_API_KEY}"
      }
    }
  }
}
EOF
    
    echo ""
    echo "✅ Successfully configured: $MCP_CONFIG"
    echo ""
    echo "════════════════════════════════════════════"
    echo "IMPORTANT: Set these environment variables"
    echo "in your shell profile (~/.zshrc or ~/.bashrc):"
    echo "════════════════════════════════════════════"
    echo ""
    echo "export NEN_API_KEY=\"$NEN_API_KEY\""
    echo "export NEN_MCP_URL=\"$NEN_MCP_URL\""
    echo ""
    echo "Then run: source ~/.zshrc  (or ~/.bashrc)"
    echo ""
else
    echo "❌ Invalid selection"
    exit 1
fi

echo "════════════════════════════════════════════"
echo "Next Steps:"
echo "════════════════════════════════════════════"
echo ""
echo "1. Add environment variables to your shell profile"
echo "2. Restart your terminal OR run: source ~/.zshrc"
echo "3. Completely quit Cursor (⌘Q or Ctrl+Q)"
echo "4. Reopen Cursor"
echo "5. Verify by asking the AI:"
echo "   'Use nen_list_workflows to verify the MCP server is working'"
echo ""
echo "✨ Setup complete!"
