#!/bin/bash
set -e

echo "🚀 Setting up NenAI MCP Server..."
echo ""

# Check if .env exists
if [ ! -f .env ]; then
    echo "❌ Error: .env file not found"
    echo ""
    echo "Please create .env with your credentials:"
    echo "  NEN_API_KEY=your_key_here"
    echo "  NEN_DEPLOYMENT_ID=your_deployment_id (optional)"
    exit 1
fi

# Load environment variables
export $(cat .env | grep -v '^#' | grep -v '^$' | xargs)

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

# Get absolute path to project
PROJECT_DIR=$(pwd)
echo ""
echo "📁 Project directory: $PROJECT_DIR"

# Create/update mcp.json
mkdir -p ~/.cursor
cat > ~/.cursor/mcp.json << EOF
{
  "mcpServers": {
    "nenai": {
      "command": "node",
      "args": ["$PROJECT_DIR/node_modules/@nen/mcp-server/dist/index.js"],
      "cwd": "$PROJECT_DIR",
      "env": {
        "NEN_API_KEY": "$NEN_API_KEY",
        "NEN_DEPLOYMENT_ID": "$NEN_DEPLOYMENT_ID"
      }
    }
  }
}
EOF

echo ""
echo "✅ MCP server configured successfully!"
echo ""
echo "📝 Configuration written to: ~/.cursor/mcp.json"
echo ""
echo "🔄 Next steps:"
echo "   1. Restart Cursor completely (Cmd+Q or Ctrl+Q, then reopen)"
echo "   2. Ask the AI agent: 'Use list_workflows to verify the MCP server is working'"
echo ""
