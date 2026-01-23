#!/bin/bash

# Setup script for remote Nen MCP server
# This configures Cursor to connect to the remote MCP server

set -e

# Check required environment variables
if [ -z "$NEN_API_KEY" ]; then
    echo "Error: NEN_API_KEY environment variable is not set"
    echo "Run: export NEN_API_KEY=\"your_api_key_here\""
    exit 1
fi

if [ -z "$NEN_MCP_URL" ]; then
    echo "Error: NEN_MCP_URL environment variable is not set"
    echo "Run: export NEN_MCP_URL=\"your_remote_mcp_url_here\""
    exit 1
fi

# Create Cursor config directory if it doesn't exist
CURSOR_DIR="$HOME/.cursor"
mkdir -p "$CURSOR_DIR"

# Path to mcp.json
MCP_CONFIG="$CURSOR_DIR/mcp.json"

# Create/update mcp.json
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

echo "✅ Successfully configured Cursor MCP at: $MCP_CONFIG"
echo ""
echo "Configuration:"
echo "  Server: nenai (remote)"
echo "  URL: \${env:NEN_MCP_URL}"
echo "  Auth: \${env:NEN_API_KEY}"
echo ""
echo "Next steps:"
echo "  1. Completely quit Cursor (⌘Q or Ctrl+Q)"
echo "  2. Reopen Cursor"
echo "  3. Verify by asking the AI: 'Use nen_list_workflows to verify the MCP server is working'"
