# Troubleshooting Guide

## Quick Diagnostics

Run the test script to check your setup:

```bash
npm test
```

This will validate:
- `.env` file exists and has credentials
- Wrapper script is present and executable
- `mcp.json` is correctly configured
- No secrets leaked into `mcp.json`
- Dependencies are installed

---

## Common Issues

### 1. MCP Server Not Found in Cursor

**Symptom:** AI agent doesn't have access to `nen_*` tools

**Solutions:**
1. Verify setup completed:
   ```bash
   npm test
   ```

2. Check mcp.json exists:
   ```bash
   cat ~/.cursor/mcp.json
   ```

3. **Completely restart Cursor** (not just reload window):
   - Mac: Cmd+Q, then reopen
   - Linux/Windows: Ctrl+Q, then reopen

4. Check Cursor logs for MCP errors:
   - Open Cursor Developer Tools (Help → Toggle Developer Tools)
   - Look for errors mentioning "MCP" or "nenai"

---

### 2. "ERROR: .env file not found"

**Symptom:** MCP server fails to start with this error

**Solutions:**
1. Create `.env` from template:
   ```bash
   cp .env.example .env
   ```

2. Add your credentials to `.env`:
   ```bash
   NEN_API_KEY=your_actual_api_key_here
   NEN_DEPLOYMENT_ID=your_deployment_id_here
   ```

3. Verify file location:
   ```bash
   ls -la .env
   # Should be in the mcp-quickstart directory
   ```

---

### 3. "ERROR: NEN_API_KEY not set in .env"

**Symptom:** Setup or wrapper script reports missing API key

**Solutions:**
1. Open `.env` and verify format:
   ```bash
   cat .env
   ```

2. Ensure no spaces around `=`:
   ```bash
   # CORRECT:
   NEN_API_KEY=sk_abc123
   
   # WRONG:
   NEN_API_KEY = sk_abc123
   NEN_API_KEY=
   ```

3. Ensure no quotes needed:
   ```bash
   # CORRECT:
   NEN_API_KEY=sk_abc123
   
   # WRONG (usually):
   NEN_API_KEY="sk_abc123"
   ```

4. Check for hidden characters (copy-paste issues):
   ```bash
   hexdump -C .env | head
   ```

---

### 4. "Permission denied" when running scripts

**Symptom:** `bash: ./setup-mcp.sh: Permission denied`

**Solutions:**
```bash
chmod +x setup-mcp.sh start-mcp-server.sh test-setup.sh
npm run setup
```

---

### 5. MCP Server Starts But Tools Don't Work

**Symptom:** AI can see tools but they fail with 401/403

**Solutions:**
1. Verify API key is valid:
   ```bash
   # Check if key looks correct (should be long alphanumeric)
   grep NEN_API_KEY .env
   ```

2. Contact your NenAI customer engineer to verify:
   - API key is active
   - API key has correct permissions
   - Deployment ID is correct (if using one)

3. Test the wrapper script manually:
   ```bash
   # This should start the server (Ctrl+C to stop)
   ./start-mcp-server.sh
   ```

---

### 6. "Cannot find module @nen/mcp-server"

**Symptom:** Error when starting MCP server

**Solutions:**
1. Install dependencies:
   ```bash
   npm install
   ```

2. Verify installation:
   ```bash
   ls node_modules/@nen/mcp-server/dist/index.js
   # Should exist
   ```

3. Re-run setup:
   ```bash
   npm run setup
   ```

---

### 7. Setup Works But MCP Server Not Loading

**Symptom:** No errors, but AI doesn't have tools

**Possible Causes:**

1. **Cursor didn't fully restart**
   - Use Cmd+Q or Ctrl+Q (not just close window)
   - Wait 5 seconds
   - Reopen Cursor

2. **Multiple mcp.json files**
   ```bash
   # Check for conflicts
   find ~ -name "mcp.json" 2>/dev/null
   ```

3. **Cursor using different config location**
   - Check Cursor settings for MCP configuration path
   - Some versions use `~/.config/cursor/mcp.json`

4. **MCP protocol version mismatch**
   - Update Cursor to latest version
   - Update MCP server: `npm install`

---

### 7a. Tool Documented But Not Available

**Symptom:** Documentation mentions a tool (e.g., `list_workflows`) but AI agent says it doesn't exist

**Cause:** Package is installed from GitHub but pinned to an old commit before the tool was added

**Solutions:**

1. Check current version:
   ```bash
   npm list @nen/mcp-server
   # Shows commit hash after the #
   ```

2. Update to latest version:
   ```bash
   npm update @nen/mcp-server
   ```

3. Verify tool is now present:
   ```bash
   grep -o '"name": "[^"]*"' node_modules/@nen/mcp-server/dist/index.js | grep -A1 tools
   # Should list all 8 tools including list_workflows
   ```

4. Restart Cursor completely:
   - Mac: Cmd+Q, then reopen
   - Linux/Windows: Ctrl+Q, then reopen

**Verification:**
Ask the AI agent: "Use list_workflows to verify the tool is now available"

---

### 8. Wrapper Script Has Syntax Error

**Symptom:** "syntax error near unexpected token"

**Solutions:**
1. Verify bash is available:
   ```bash
   which bash
   # Should output: /bin/bash or /usr/bin/bash
   ```

2. Re-download wrapper script (might be corrupted):
   ```bash
   git checkout start-mcp-server.sh
   chmod +x start-mcp-server.sh
   ```

3. Check for Windows line endings (CRLF):
   ```bash
   file start-mcp-server.sh
   # Should say "shell script" not "DOS executable"
   
   # Fix if needed:
   dos2unix start-mcp-server.sh  # or
   sed -i 's/\r$//' start-mcp-server.sh
   ```

---

### 9. ".env parsing failed" or weird characters

**Symptom:** Errors about invalid characters in environment variables

**Solutions:**
1. Ensure `.env` uses simple format:
   ```bash
   # No spaces, no special quoting
   NEN_API_KEY=sk_abc123
   NEN_DEPLOYMENT_ID=uuid-here
   ```

2. Remove any fancy quotes:
   ```bash
   # WRONG (curly quotes):
   NEN_API_KEY="sk_abc123"
   
   # CORRECT:
   NEN_API_KEY=sk_abc123
   ```

3. Check file encoding:
   ```bash
   file .env
   # Should say "ASCII text" or "UTF-8 Unicode text"
   ```

---

### 10. "exec: node: not found"

**Symptom:** Wrapper script can't find node

**Solutions:**
1. Verify node is installed:
   ```bash
   which node
   node --version
   ```

2. Install node if missing:
   - Mac: `brew install node`
   - Linux: `apt install nodejs` or `yum install nodejs`

3. Ensure node is in PATH:
   ```bash
   echo $PATH | grep -o '[^:]*node[^:]*'
   ```

4. Use absolute path in wrapper (temporary fix):
   ```bash
   # Edit start-mcp-server.sh, replace:
   exec node "$SCRIPT_DIR/..."
   # With:
   exec /usr/local/bin/node "$SCRIPT_DIR/..."  # your actual node path
   ```

---

## Advanced Debugging

### Enable Verbose Logging

Edit `start-mcp-server.sh` and add at the top:

```bash
#!/bin/bash
set -x  # Add this line for verbose output
```

Then check Cursor logs to see detailed execution.

### Test Wrapper Directly

```bash
# Run wrapper and check for errors
./start-mcp-server.sh 2>&1 | head -20

# Should see "Starting NenAI MCP Server..."
# Then MCP protocol output (JSON messages)
```

### Check Environment Loading

```bash
# Test if .env loads correctly
bash -c '
  set -a
  source .env
  set +a
  echo "API Key loaded: ${NEN_API_KEY:0:10}..."
'
```

### Verify MCP JSON Validity

```bash
# Check mcp.json is valid JSON
cat ~/.cursor/mcp.json | python3 -m json.tool

# Should print formatted JSON with no errors
```

---

## Security Check

Ensure credentials aren't exposed:

```bash
# This should return NOTHING:
grep -r "NEN_API_KEY.*sk_" ~/.cursor/

# If it returns results, you have exposed credentials!
# Re-run setup-mcp.sh to fix.
```

---

## Rollback to Previous Configuration

If you need to revert:

```bash
# Find backups
ls -lt ~/.cursor/mcp.json.backup.*

# Restore most recent backup
cp ~/.cursor/mcp.json.backup.YYYYMMDD_HHMMSS ~/.cursor/mcp.json

# Restart Cursor
```

---

## Still Having Issues?

1. Run full diagnostic:
   ```bash
   npm test
   ```

2. Collect debug info:
   ```bash
   echo "=== System Info ==="
   uname -a
   echo "=== Node Version ==="
   node --version
   echo "=== NPM Version ==="
   npm --version
   echo "=== .env Status ==="
   ls -la .env
   echo "=== Wrapper Status ==="
   ls -la start-mcp-server.sh
   echo "=== MCP Config ==="
   cat ~/.cursor/mcp.json
   ```

3. Contact support with the output from step 2
