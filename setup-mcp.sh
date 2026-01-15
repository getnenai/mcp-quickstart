#!/bin/bash
set -e

echo "🚀 Setting up NenAI MCP Server..."
echo ""

# Get absolute path to project
PROJECT_DIR=$(pwd)

# Check if .env exists
if [ ! -f "$PROJECT_DIR/.env" ]; then
    echo "❌ Error: .env file not found"
    echo ""
    echo "Please create .env with your credentials:"
    echo "  cp .env.example .env"
    echo "  # Then edit .env with your actual credentials"
    exit 1
fi

# Load environment variables safely using source
set -a
source "$PROJECT_DIR/.env"
set +a

# Check required variables
if [ -z "$NEN_API_KEY" ]; then
    echo "❌ Error: NEN_API_KEY not set in .env"
    echo "Please add NEN_API_KEY to your .env file"
    exit 1
fi

echo "✅ Found NEN_API_KEY in .env"

if [ -n "$NEN_DEPLOYMENT_ID" ]; then
    echo "✅ Found NEN_DEPLOYMENT_ID in .env"
fi

echo ""
echo "📁 Project directory: $PROJECT_DIR"

# Verify wrapper script exists
if [ ! -f "$PROJECT_DIR/start-mcp-server.sh" ]; then
    echo "❌ Error: start-mcp-server.sh not found"
    echo "This file should be included in the repository."
    exit 1
fi

# Make the wrapper script executable
chmod +x "$PROJECT_DIR/start-mcp-server.sh"
echo "✅ Wrapper script is executable"

# Backup existing mcp.json if it exists
MCP_CONFIG="$HOME/.cursor/mcp.json"
if [ -f "$MCP_CONFIG" ]; then
    BACKUP_FILE="$MCP_CONFIG.backup.$(date +%Y%m%d_%H%M%S)"
    cp "$MCP_CONFIG" "$BACKUP_FILE"
    echo "📦 Backed up existing config to: $BACKUP_FILE"
fi

# Create/update mcp.json to use the wrapper script
mkdir -p ~/.cursor
cat > "$MCP_CONFIG" << EOF
{
  "mcpServers": {
    "nenai": {
      "command": "bash",
      "args": ["$PROJECT_DIR/start-mcp-server.sh"],
      "cwd": "$PROJECT_DIR"
    }
  }
}
EOF

# Verify mcp.json was written correctly
if [ ! -f "$MCP_CONFIG" ]; then
    echo "❌ Error: Failed to write $MCP_CONFIG"
    exit 1
fi

# Verify the wrapper script path is in the config
if ! grep -q "start-mcp-server.sh" "$MCP_CONFIG"; then
    echo "❌ Error: Configuration appears malformed"
    exit 1
fi

echo ""
echo "✅ MCP server configured successfully!"
echo ""
echo "📝 Configuration written to: $MCP_CONFIG"
echo "🔒 Your credentials remain secure in: $PROJECT_DIR/.env"
echo "   (They are NOT written to mcp.json)"
echo ""
echo "🔄 Next steps:"
echo "   1. Restart Cursor completely (Cmd+Q or Ctrl+Q, then reopen)"
echo "   2. Ask the AI agent: 'Use list_workflows to verify the MCP server is working'"
echo ""
echo "💡 Tip: To update credentials, just edit .env - no need to re-run setup"
echo ""