# Troubleshooting Guide

## Installation Issues

### npm install fails

**Error:** Various npm errors during installation

**Solution:**

1. Ensure you're using Node.js 18+:
   ```bash
   node --version  # Should be v18.0.0 or higher
   ```

2. Clear npm cache and try again:
   ```bash
   npm cache clean --force
   rm -rf node_modules package-lock.json
   npm install
   ```

3. If using a different package manager (yarn, pnpm), use npm instead:
   ```bash
   npm install
   ```

---

## Cursor Configuration Issues

### MCP server not appearing in Cursor

**Symptoms:** AI agent doesn't have access to NenAI tools

**Solutions:**

1. **Verify config file exists:**
   ```bash
   cat ~/.cursor/mcp.json
   ```

2. **Check JSON syntax is valid:**
   ```bash
   node -e "JSON.parse(require('fs').readFileSync(process.env.HOME + '/.cursor/mcp.json'))"
   ```

3. **Ensure absolute path in `cwd`:**
   ```json
   {
     "mcpServers": {
       "nen": {
         "command": "npx",
         "args": ["@nen/mcp-server"],
         "cwd": "/full/absolute/path/to/mcp-quickstart"
       }
     }
   }
   ```
   
   Get the correct path:
   ```bash
   cd /path/to/mcp-quickstart
   pwd
   ```

4. **Restart Cursor completely:**
   - macOS: Cmd+Q (not just close window)
   - Windows/Linux: File > Exit

5. **Check Cursor logs:**
   - View > Output
   - Select "Model Context Protocol" from dropdown
   - Look for error messages about the "nen" server

### "command not found: npx" error

**Cause:** Cursor can't find Node.js/npm in its PATH

**Solution:**

1. Find npm path:
   ```bash
   which npx
   ```

2. Use full path in config:
   ```json
   {
     "mcpServers": {
       "nen": {
         "command": "/usr/local/bin/npx",
         "args": ["@nen/mcp-server"],
         "cwd": "/full/path/to/mcp-quickstart"
       }
     }
   }
   ```

3. Or add Node.js to your shell profile (~/.zshrc or ~/.bashrc):
   ```bash
   export PATH="/usr/local/bin:$PATH"
   ```
   Then restart Cursor.

---

## API Authentication Issues

### "Invalid API key" or authentication errors

**Symptoms:** MCP tools fail with authentication errors

**Solutions:**

1. **Check .env file format:**
   ```bash
   cat .env
   ```
   
   Should look like:
   ```bash
   NEN_API_KEY=sk_xxxxxxxxxxxxx
   NEN_DEPLOYMENT_ID=dep_xxxxxxxxxxxxx
   ```

2. **Common mistakes:**
   - ❌ Quotes around values: `NEN_API_KEY="sk_xxx"`
   - ❌ Extra spaces: `NEN_API_KEY= sk_xxx`
   - ❌ Comments on same line: `NEN_API_KEY=sk_xxx # my key`
   - ✅ Correct: `NEN_API_KEY=sk_xxx`

3. **Verify credentials are correct:**
   - Check with your customer engineer
   - Ensure they haven't been rotated/revoked

4. **Restart Cursor after editing .env:**
   - Changes require a full restart (Cmd+Q/File > Exit)

### "Deployment not found" error

**Cause:** Invalid or incorrect NEN_DEPLOYMENT_ID

**Solution:**

1. Verify your deployment ID with your customer engineer
2. Ensure it starts with `dep_` or matches the format provided
3. Check for typos in `.env` file

---

## Workflow Creation Issues

### Workflow creation fails with validation errors

**Common causes:**

1. **Invalid FSM structure:** Missing required fields
2. **Malformed JSON:** Syntax errors in generated files
3. **Missing variables:** Referenced `${VARIABLES}` not defined

**Debug steps:**

1. Start with a simple workflow:
   ```
   "Create a workflow that takes a screenshot"
   ```

2. Check generated JSON:
   ```bash
   cat workflows/my_workflows/your-workflow/workflow.json
   ```

3. Validate JSON syntax:
   ```bash
   node -e "JSON.parse(require('fs').readFileSync('workflows/my_workflows/your-workflow/workflow.json'))"
   ```

4. Review the `.cursorrules` file for FSM requirements:
   ```bash
   less .cursorrules
   ```

### AI agent doesn't understand FSM structure

**Solution:**

The `.cursorrules` file should be automatically loaded by Cursor. If not:

1. Ensure `.cursorrules` file exists in the repo root
2. Manually reference it in your prompt:
   ```
   "Using the .cursorrules file, create a workflow that..."
   ```

3. Check Cursor settings for cursor rules loading

---

## Runtime Issues

### Workflow runs fail immediately

**Possible causes:**

1. **Invalid credentials:** Check .env file
2. **Deployment not running:** Contact customer engineer
3. **Quota exceeded:** Check your usage limits

**Debug:**

Use `get_run_logs` tool to see detailed error messages:
```
"Get the logs for run <run_id>"
```

### Can't view workflow execution video

**Issue:** `get_run_video` returns error or invalid URL

**Solution:**

1. Ensure the run has completed
2. Check if video recording is enabled for your deployment
3. Contact customer engineer if videos aren't being generated

---

## Permission Issues

### EACCES: permission denied

**Error:** Permission errors during npm install or file operations

**Solution:**

```bash
# Fix npm permissions
sudo chown -R $(whoami) ~/.npm

# Fix project permissions
sudo chown -R $(whoami) .
```

### Can't create workflows directory

**Solution:**

```bash
# Create manually
mkdir -p workflows/my_workflows
```

---

## Development Issues

### Want to test changes to .cursorrules

**Solution:**

1. Edit `.cursorrules` file
2. Reference it explicitly in your prompt:
   ```
   "Based on the updated .cursorrules, create a workflow that..."
   ```

3. Or restart Cursor to reload the rules file

### Want to clean up test workflows

**Solution:**

```bash
# Remove all custom workflows (keeps samples)
npm run clean

# Or manually:
rm -rf workflows/my_workflows/*
```

---

## Getting More Help

### Run the diagnostic script

```bash
npm run verify
```

This checks:
- Node.js and npm versions
- .env file existence and format
- Directory structure
- MCP server installation
- Cursor configuration

### Collect information for support

When contacting support, provide:

1. Output of `npm run verify`
2. Node.js version: `node --version`
3. Operating system and version
4. Contents of `~/.cursor/mcp.json` (sanitized)
5. Cursor logs (View > Output > Model Context Protocol)
6. Error messages or screenshots

### Contact support

- Email: hello@nen.ai
- Include "MCP Quickstart" in subject line
- Provide the information above

---

## Common Questions

### Can I use this with VS Code or other IDEs?

The MCP server is designed for MCP-compatible tools. Check your IDE's MCP support:

- **Cursor:** Native support ✅
- **VS Code:** Requires MCP extension
- **Other IDEs:** Check MCP documentation

### Can I use a different package manager?

We recommend npm, but if you must use yarn or pnpm:

```bash
# Install with npm first to ensure compatibility
npm install

# Then you can use your preferred manager
```

### How do I update the MCP server?

```bash
npm update @nen/mcp-server
```

Or force reinstall:
```bash
npm cache clean --force
rm -rf node_modules package-lock.json
npm install
```

### Can I customize the workflow directory structure?

Yes, but you'll need to update references in your workflows and ensure the AI knows where to save files. The default structure is recommended.
