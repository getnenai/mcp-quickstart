# MCP Server Publishing Scripts

Automated scripts to extract, setup, and publish the NenAI MCP Server to GitHub.

---

## 📋 Overview

These scripts automate the process of:
1. Extracting the MCP server from the `cup` monorepo
2. Setting up a standalone git repository
3. Publishing to GitHub at `github.com/getnenai/mcp-server`

---

## 🚀 Quick Start (Automated)

Run all steps automatically:

```bash
cd /Users/zidong/nen/mcp-quickstart/scripts
./publish-all.sh
```

This will:
- Extract files from cup monorepo
- Setup git repository and build
- Prompt you to create GitHub repo
- Push to GitHub and create release tag

---

## 📖 Manual Step-by-Step

If you prefer to run each step manually:

### Step 1: Extract MCP Server

```bash
cd /Users/zidong/nen/mcp-quickstart/scripts
./extract-mcp-server.sh
```

**What it does:**
- Copies MCP server files from `cup/frontend/packages/mcp-server/`
- Creates target directory at `/Users/zidong/nen/mcp-server/`
- Adds `.gitignore`, `LICENSE`, and `.npmignore`

**Output location:** `/Users/zidong/nen/mcp-server/`

---

### Step 2: Setup Repository

```bash
cd /Users/zidong/nen/mcp-server
../mcp-quickstart/scripts/setup-mcp-server.sh
```

**What it does:**
- Updates `package.json` with publishing metadata
- Installs dependencies
- Builds the TypeScript project
- Initializes git repository
- Creates initial commit

**Verification:**
- `dist/` directory exists with built files
- Git repository initialized with commit

---

### Step 3: Create GitHub Repository

**Before running the publish script**, create the GitHub repository:

1. Go to: https://github.com/organizations/getnenai/repositories/new
2. Settings:
   - **Repository name:** `mcp-server`
   - **Description:** "NenAI MCP Server for IDE workflow authoring"
   - **Visibility:** Private (recommended) or Public
   - **❌ DO NOT** initialize with README, .gitignore, or license
3. Click "Create repository"

---

### Step 4: Publish to GitHub

```bash
cd /Users/zidong/nen/mcp-server
../mcp-quickstart/scripts/publish-to-github.sh
```

**What it does:**
- Adds GitHub remote
- Pushes to main branch
- Optionally creates release tag `v0.2.0`

**Result:**
- MCP server is live at `https://github.com/getnenai/mcp-server`

---

## 🧪 Testing After Publishing

Test that mcp-quickstart can install from GitHub:

```bash
cd /Users/zidong/nen/mcp-quickstart

# Clean install
rm -rf node_modules package-lock.json
npm install

# Verify installation
npx @nen/mcp-server

# Test in your IDE
# (Follow INSTALLATION.md)
```

---

## 📁 What Gets Published

### Directory Structure

```
mcp-server/
├── src/                    # TypeScript source (not in npm, included in git)
│   ├── index.ts
│   ├── tools.ts
│   └── ssh.ts
├── dist/                   # Built JavaScript (included in npm)
│   ├── index.js
│   ├── tools.js
│   └── ssh.js
├── package.json           # Updated with publishing metadata
├── tsconfig.json
├── tsup.config.ts
├── README.md
├── TROUBLESHOOTING.md
├── LICENSE                # MIT License
├── .gitignore
└── .npmignore
```

### package.json Changes

The setup script adds these fields:

```json
{
  "files": ["dist", "README.md", "TROUBLESHOOTING.md"],
  "repository": {
    "type": "git",
    "url": "https://github.com/getnenai/mcp-server.git"
  },
  "keywords": ["mcp", "model-context-protocol", "nenai", "workflow", "automation"],
  "license": "MIT",
  "homepage": "https://github.com/getnenai/mcp-server#readme",
  "bugs": {
    "url": "https://github.com/getnenai/mcp-server/issues"
  }
}
```

---

## 🔄 Updating After Changes

When you make changes to the MCP server in the cup monorepo:

```bash
# Re-extract
cd /Users/zidong/nen/mcp-quickstart/scripts
./extract-mcp-server.sh

# Rebuild
cd /Users/zidong/nen/mcp-server
npm run build

# Commit and push
git add .
git commit -m "Update: description of changes"
git push

# Create new release (optional)
git tag v0.2.1
git push origin v0.2.1
```

---

## 🛠️ Script Reference

### extract-mcp-server.sh

**Purpose:** Copy MCP server files from cup monorepo

**Requirements:**
- Cup monorepo at `/Users/zidong/nen/cup`
- MCP server exists at `cup/frontend/packages/mcp-server/`

**Output:**
- Creates `/Users/zidong/nen/mcp-server/` directory
- Copies all necessary files
- Adds `.gitignore`, `LICENSE`, `.npmignore`

---

### setup-mcp-server.sh

**Purpose:** Setup git repository and build project

**Requirements:**
- Must be run from `/Users/zidong/nen/mcp-server/`
- Node.js 18+ installed
- npm available

**Output:**
- Updated `package.json`
- `node_modules/` installed
- `dist/` built
- Git repository initialized
- Initial commit created

---

### publish-to-github.sh

**Purpose:** Push to GitHub and create release

**Requirements:**
- Git repository initialized
- GitHub repository created (must be done manually first)
- Git authentication configured

**Output:**
- Code pushed to `main` branch
- Release tag created (optional)

---

### publish-all.sh

**Purpose:** Run all three scripts in sequence

**Flow:**
1. Extract MCP server
2. Setup repository
3. Pause for GitHub repo creation
4. Publish to GitHub

---

## 🐛 Troubleshooting

### "Source directory not found"

**Cause:** Cup monorepo path is incorrect

**Solution:**
- Verify cup monorepo is at `/Users/zidong/nen/cup`
- Or edit `SOURCE_DIR` in `extract-mcp-server.sh`

---

### "Build failed - dist/index.js not found"

**Cause:** TypeScript compilation error

**Solution:**
```bash
cd /Users/zidong/nen/mcp-server
npm install
npm run build
# Check for errors
```

---

### "Remote 'origin' already exists"

**Cause:** Git remote was already added

**Solution:**
- Choose 'y' to continue, or
- Remove remote: `git remote remove origin`
- Run script again

---

### "Git push failed"

**Cause:** Authentication issue or repository doesn't exist

**Solution:**
1. Verify repository exists on GitHub
2. Check git authentication:
   ```bash
   git config --global user.name
   git config --global user.email
   ```
3. Use SSH key or personal access token

---

## 📝 Notes

- **Git authentication:** Scripts use HTTPS URLs. Configure GitHub authentication before running.
- **Backup:** Original files in cup monorepo are not modified.
- **Re-running:** Safe to re-run extract script; it will overwrite target directory.
- **Clean slate:** Delete `/Users/zidong/nen/mcp-server/` to start fresh.

---

## 🔗 Related Documentation

- [INSTALLATION.md](../INSTALLATION.md) - How users install the MCP server
- [cup/docs/design/MCP_SERVER_PUBLISHING.md](../../cup/docs/design/MCP_SERVER_PUBLISHING.md) - Publishing design doc
- [GitHub: Creating a repository](https://docs.github.com/en/repositories/creating-and-managing-repositories/creating-a-new-repository)

---

## ✅ Success Checklist

After running the scripts:

- [ ] MCP server extracted to `/Users/zidong/nen/mcp-server/`
- [ ] `dist/` directory exists with built JavaScript
- [ ] Git repository initialized with commit
- [ ] GitHub repository created at `getnenai/mcp-server`
- [ ] Code pushed to GitHub main branch
- [ ] Release tag `v0.2.0` created (optional)
- [ ] Installation tested from mcp-quickstart
- [ ] MCP server runs successfully: `npx @nen/mcp-server`
- [ ] IDE integration tested (Cursor/Windsurf/Claude Desktop)

---

## 🆘 Getting Help

If you encounter issues:

1. Check error messages in script output
2. Verify all prerequisites are met
3. Try manual steps instead of automated script
4. Check GitHub authentication
5. Verify cup monorepo location

**Contact:** Your NenAI engineering team
