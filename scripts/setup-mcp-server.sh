#!/bin/bash
set -e

echo "⚙️  Setting up MCP Server repository..."

# Configuration
REPO_DIR="/Users/zidong/nen/mcp-server"
GITHUB_ORG="getnenai"
GITHUB_REPO="mcp-server"

# Check if in correct directory
if [ ! -f "package.json" ]; then
  echo "❌ Error: Must be run from mcp-server directory"
  echo "   Run: cd $REPO_DIR"
  exit 1
fi

# Update package.json with publishing metadata
echo "📝 Updating package.json..."
node -e "
const fs = require('fs');
const pkg = JSON.parse(fs.readFileSync('package.json', 'utf8'));

// Add publishing fields
pkg.files = ['dist', 'README.md', 'TROUBLESHOOTING.md'];
pkg.repository = {
  type: 'git',
  url: 'https://github.com/${GITHUB_ORG}/${GITHUB_REPO}.git'
};
pkg.keywords = ['mcp', 'model-context-protocol', 'nenai', 'workflow', 'automation', 'computer-use'];
pkg.license = 'MIT';
pkg.homepage = 'https://github.com/${GITHUB_ORG}/${GITHUB_REPO}#readme';
pkg.bugs = {
  url: 'https://github.com/${GITHUB_ORG}/${GITHUB_REPO}/issues'
};

// Add prepublishOnly script
if (!pkg.scripts) pkg.scripts = {};
pkg.scripts.prepublishOnly = 'npm run build';

fs.writeFileSync('package.json', JSON.stringify(pkg, null, 2) + '\n');
console.log('✅ package.json updated');
"

# Install dependencies
echo ""
echo "📦 Installing dependencies..."
npm install

# Build the project
echo ""
echo "🔨 Building project..."
npm run build

# Verify build output
if [ ! -d "dist" ] || [ ! -f "dist/index.js" ]; then
  echo "❌ Error: Build failed - dist/index.js not found"
  exit 1
fi

echo "✅ Build successful"

# Initialize git repository
echo ""
echo "🔧 Initializing git repository..."
git init

# Create initial commit
echo ""
echo "📝 Creating initial commit..."
git add .
git commit -m "Initial commit: NenAI MCP Server

- TypeScript MCP server for workflow authoring
- Tools: nen_create_workflow, nen_upload, nen_run, nen_status, nen_logs, nen_artifacts, nen_list_runs
- Built with @modelcontextprotocol/sdk
- Supports Cursor, Windsurf, Claude Desktop"

# Show repository status
echo ""
echo "✅ Repository initialized!"
echo ""
echo "📊 Repository status:"
git log --oneline -1
echo ""
git status

# Instructions for pushing to GitHub
echo ""
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo "🚀 Next steps to publish to GitHub:"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo ""
echo "1. Create repository on GitHub:"
echo "   https://github.com/organizations/${GITHUB_ORG}/repositories/new"
echo "   - Name: ${GITHUB_REPO}"
echo "   - Description: NenAI MCP Server for IDE workflow authoring"
echo "   - Visibility: Private (or Public)"
echo "   - DO NOT initialize with README"
echo ""
echo "2. Add remote and push:"
echo "   git remote add origin https://github.com/${GITHUB_ORG}/${GITHUB_REPO}.git"
echo "   git branch -M main"
echo "   git push -u origin main"
echo ""
echo "3. Create release tag:"
echo "   git tag v0.2.0"
echo "   git push origin v0.2.0"
echo ""
echo "4. Test installation from mcp-quickstart:"
echo "   cd /Users/zidong/nen/mcp-quickstart"
echo "   npm install"
echo "   npx @nen/mcp-server"
echo ""
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo ""
