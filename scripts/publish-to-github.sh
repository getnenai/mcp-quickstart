#!/bin/bash
set -e

echo "🚀 Publishing MCP Server to GitHub..."

# Configuration
REPO_DIR="/Users/zidong/nen/mcp-server"
GITHUB_ORG="getnenai"
GITHUB_REPO="mcp-server"
VERSION="0.2.0"

# Check if in correct directory
if [ ! -d "$REPO_DIR" ]; then
  echo "❌ Error: MCP Server directory not found: $REPO_DIR"
  echo "   Run extract-mcp-server.sh first"
  exit 1
fi

cd "$REPO_DIR"

# Check if git is initialized
if [ ! -d ".git" ]; then
  echo "❌ Error: Git not initialized"
  echo "   Run setup-mcp-server.sh first"
  exit 1
fi

# Check if remote exists
if git remote get-url origin &> /dev/null; then
  echo "⚠️  Remote 'origin' already exists"
  echo "   Current origin: $(git remote get-url origin)"
  read -p "   Continue? (y/N) " -n 1 -r
  echo
  if [[ ! $REPLY =~ ^[Yy]$ ]]; then
    echo "Cancelled."
    exit 1
  fi
else
  echo "🔗 Adding GitHub remote..."
  git remote add origin "https://github.com/${GITHUB_ORG}/${GITHUB_REPO}.git"
fi

# Verify we have commits
if ! git log -1 &> /dev/null; then
  echo "❌ Error: No commits found"
  echo "   Run setup-mcp-server.sh first"
  exit 1
fi

# Show what will be pushed
echo ""
echo "📋 Files to be pushed:"
git ls-files | head -20
echo "..."
echo ""
echo "📊 Repository status:"
git log --oneline -1
echo ""

# Confirm push
read -p "🚀 Push to GitHub? (y/N) " -n 1 -r
echo
if [[ ! $REPLY =~ ^[Yy]$ ]]; then
  echo "Cancelled."
  exit 1
fi

# Push to GitHub
echo ""
echo "📤 Pushing to GitHub..."
git branch -M main
git push -u origin main

echo ""
echo "✅ Pushed to main branch!"

# Ask about release tag
echo ""
read -p "🏷️  Create release tag v${VERSION}? (y/N) " -n 1 -r
echo
if [[ $REPLY =~ ^[Yy]$ ]]; then
  echo "📌 Creating tag v${VERSION}..."
  git tag "v${VERSION}"
  git push origin "v${VERSION}"
  
  echo ""
  echo "✅ Tag created!"
  echo ""
  echo "📝 Create GitHub release:"
  echo "   https://github.com/${GITHUB_ORG}/${GITHUB_REPO}/releases/new?tag=v${VERSION}"
fi

echo ""
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo "✅ MCP Server published successfully!"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo ""
echo "🔗 Repository: https://github.com/${GITHUB_ORG}/${GITHUB_REPO}"
echo ""
echo "🧪 Test installation:"
echo "   cd /Users/zidong/nen/mcp-quickstart"
echo "   rm -rf node_modules package-lock.json"
echo "   npm install"
echo "   npx @nen/mcp-server"
echo ""
echo "📚 Update mcp-quickstart README if needed"
echo ""
