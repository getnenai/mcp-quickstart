#!/bin/bash
# Wrapper script to load .env and start MCP server
set -e  # Exit on error

# Get the directory where this script is located
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
ENV_FILE="$SCRIPT_DIR/.env"

# Check if .env exists
if [ ! -f "$ENV_FILE" ]; then
    echo "ERROR: .env file not found at $ENV_FILE" >&2
    echo "Please create .env file with your NenAI credentials." >&2
    echo "Example: cp .env.example .env" >&2
    exit 1
fi

# Load .env file safely using source
# Enable auto-export, source the file, then disable auto-export
set -a
source "$ENV_FILE"
set +a

# Validate required environment variables
if [ -z "$NEN_API_KEY" ]; then
    echo "ERROR: NEN_API_KEY not set in .env" >&2
    echo "Please add NEN_API_KEY to $ENV_FILE" >&2
    exit 1
fi

# Optional: Log that we're starting (to stderr so it doesn't interfere with MCP protocol)
echo "Starting NenAI MCP Server..." >&2
if [ -n "$NEN_DEPLOYMENT_ID" ]; then
    echo "Using deployment: $NEN_DEPLOYMENT_ID" >&2
fi

# Start the MCP server (exec replaces this process with node)
exec node "$SCRIPT_DIR/node_modules/@nen/mcp-server/dist/index.js"
