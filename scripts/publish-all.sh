#!/bin/bash
set -e

echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo "🚀 NenAI MCP Server - GitHub Publishing Automation"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo ""

SCRIPTS_DIR="$(cd "$(dirname "$0")" && pwd)"

# Step 1: Extract
echo "📦 Step 1/3: Extracting MCP Server from cup monorepo..."
echo ""
bash "$SCRIPTS_DIR/extract-mcp-server.sh"

# Step 2: Setup
echo ""
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo "⚙️  Step 2/3: Setting up git repository..."
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo ""
cd /Users/zidong/nen/mcp-server
bash "$SCRIPTS_DIR/setup-mcp-server.sh"

# Step 3: Pause before publishing
echo ""
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo "⏸️  Pausing before publishing..."
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo ""
echo "⚠️  IMPORTANT: Before continuing, you must:"
echo ""
echo "1. Create the GitHub repository:"
echo "   https://github.com/organizations/getnenai/repositories/new"
echo ""
echo "   Settings:"
echo "   - Repository name: mcp-server"
echo "   - Description: NenAI MCP Server for IDE workflow authoring"
echo "   - Visibility: Private (recommended) or Public"
echo "   - ❌ DO NOT initialize with README, .gitignore, or license"
echo ""
echo "2. Once created, the repository URL will be:"
echo "   https://github.com/getnenai/mcp-server"
echo ""
read -p "✅ Repository created? Press Enter to continue or Ctrl+C to cancel..."

# Step 3: Publish
echo ""
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo "📤 Step 3/3: Publishing to GitHub..."
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo ""
bash "$SCRIPTS_DIR/publish-to-github.sh"

echo ""
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo "🎉 All done!"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo ""
echo "✅ MCP Server is now published to GitHub"
echo "🔗 Repository: https://github.com/getnenai/mcp-server"
echo ""
echo "📝 Next steps:"
echo "   1. Test installation: cd /Users/zidong/nen/mcp-quickstart && npm install"
echo "   2. Verify MCP server works: npx @nen/mcp-server"
echo "   3. Update documentation if needed"
echo ""
