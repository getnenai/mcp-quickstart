#!/bin/bash

# Generate Cursor deeplink for NenAI MCP installation
# Usage: bash generate-deeplink.sh

set -e

echo "============================================"
echo "  NenAI MCP Deeplink Generator"
echo "============================================"
echo ""

# Check if env vars are set
if [ -n "$NEN_API_KEY" ] && [ -n "$NEN_MCP_URL" ]; then
    echo "✓ Using environment variables:"
    echo "  NEN_API_KEY: ${NEN_API_KEY:0:10}..."
    echo "  NEN_MCP_URL: $NEN_MCP_URL"
    echo ""
else
    echo "⚠ Environment variables not found"
    echo ""
    echo "You can either:"
    echo "1. Set them now (they won't persist)"
    echo "2. Exit and set them permanently in your shell profile"
    echo ""
    read -p "Continue? (Y/n): " continue_choice
    
    if [[ "$continue_choice" =~ ^[Nn]$ ]]; then
        echo ""
        echo "To set permanently, add to ~/.zshrc or ~/.bashrc:"
        echo ""
        echo "export NEN_API_KEY=\"your_api_key_here\""
        echo "export NEN_MCP_URL=\"your_mcp_url_here\""
        echo ""
        exit 0
    fi
fi

# Create JSON config with environment variable placeholders
config_json='{
  "url": "${env:NEN_MCP_URL}",
  "headers": {
    "X-Api-Key": "${env:NEN_API_KEY}"
  }
}'

# Base64 encode (handle macOS vs Linux)
if [[ "$OSTYPE" == "darwin"* ]]; then
    config_base64=$(echo -n "$config_json" | base64)
else
    config_base64=$(echo -n "$config_json" | base64 -w 0)
fi

# Generate the deeplink
deeplink="cursor://anysphere.cursor-deeplink/mcp/install?name=nenai&config=$config_base64"

echo "============================================"
echo "  Deeplink Generated!"
echo "============================================"
echo ""
echo "$deeplink"
echo ""
echo "============================================"
echo "  Usage Options"
echo "============================================"
echo ""
echo "1. Copy and paste in your browser"
echo "2. Use this script to open automatically"
echo "3. Share with team members"
echo ""

read -p "Open in Cursor now? (Y/n): " open_choice

if [[ ! "$open_choice" =~ ^[Nn]$ ]]; then
    if command -v open &> /dev/null; then
        open "$deeplink"
        echo "✓ Opening Cursor..."
    elif command -v xdg-open &> /dev/null; then
        xdg-open "$deeplink"
        echo "✓ Opening Cursor..."
    else
        echo "⚠ Could not auto-open. Copy the link above and paste in your browser."
    fi
fi

echo ""
echo "============================================"
echo "  Important Reminders"
echo "============================================"
echo ""
echo "1. Ensure environment variables are set:"
echo "   export NEN_API_KEY=\"...\""
echo "   export NEN_MCP_URL=\"...\""
echo ""
echo "2. Add them to ~/.zshrc or ~/.bashrc"
echo ""
echo "3. Restart your terminal: source ~/.zshrc"
echo ""
echo "4. Restart Cursor completely (⌘Q or Ctrl+Q)"
echo ""
echo "5. Verify: Ask AI 'Use nen_list_workflows'"
echo ""
