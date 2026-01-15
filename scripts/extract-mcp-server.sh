#!/bin/bash
set -e

echo "🚀 Extracting MCP Server from cup monorepo..."

# Configuration
SOURCE_DIR="/Users/zidong/nen/cup/frontend/packages/mcp-server"
TARGET_DIR="/Users/zidong/nen/mcp-server"

# Check if source exists
if [ ! -d "$SOURCE_DIR" ]; then
  echo "❌ Error: Source directory not found: $SOURCE_DIR"
  exit 1
fi

# Create target directory
echo "📁 Creating target directory: $TARGET_DIR"
mkdir -p "$TARGET_DIR"

# Copy MCP server files
echo "📦 Copying MCP server files..."
cp -r "$SOURCE_DIR/src" "$TARGET_DIR/"
cp "$SOURCE_DIR/package.json" "$TARGET_DIR/"
cp "$SOURCE_DIR/tsconfig.json" "$TARGET_DIR/"
cp "$SOURCE_DIR/tsup.config.ts" "$TARGET_DIR/"
cp "$SOURCE_DIR/README.md" "$TARGET_DIR/"
cp "$SOURCE_DIR/TROUBLESHOOTING.md" "$TARGET_DIR/"

if [ -f "$SOURCE_DIR/EXAMPLE.md" ]; then
  cp "$SOURCE_DIR/EXAMPLE.md" "$TARGET_DIR/"
fi

# Create .gitignore
echo "📝 Creating .gitignore..."
cat > "$TARGET_DIR/.gitignore" << 'EOF'
# Dependencies
node_modules/

# Build output
dist/

# Logs
*.log
npm-debug.log*
yarn-debug.log*
yarn-error.log*
pnpm-debug.log*

# Environment
.env
.env.local
.env.*.local

# IDE
.idea/
.vscode/
*.swp
*.swo
*.swn

# OS
.DS_Store
Thumbs.db

# Testing
coverage/
.nyc_output/

# Misc
*.tsbuildinfo
.cache/
EOF

# Create LICENSE
echo "📜 Creating LICENSE..."
cat > "$TARGET_DIR/LICENSE" << 'EOF'
MIT License

Copyright (c) 2026 NenAI

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.
EOF

# Create .npmignore for future npm publishing
echo "📝 Creating .npmignore..."
cat > "$TARGET_DIR/.npmignore" << 'EOF'
# Source files (only ship dist/)
src/
*.ts
!*.d.ts

# Config files
tsconfig.json
tsup.config.ts

# Development
.git/
.gitignore
.vscode/
.idea/

# Documentation (keep README, TROUBLESHOOTING)
EXAMPLE.md

# CI/CD
.github/

# Testing
test/
tests/
*.test.ts
*.spec.ts
coverage/
EOF

echo ""
echo "✅ Extraction complete!"
echo ""
echo "📍 MCP Server extracted to: $TARGET_DIR"
echo ""
echo "Next steps:"
echo "  1. cd $TARGET_DIR"
echo "  2. Run: ../mcp-quickstart/scripts/setup-mcp-server.sh"
echo ""
