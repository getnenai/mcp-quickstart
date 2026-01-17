# Troubleshooting Guide

## Common Issues

### 1. MCP Server Not Found in Cursor

**Symptom:** AI agent doesn't have access to `nen_*` tools.

**Solutions:**
1. Check `mcp.json` exists:
   ```bash
   cat ~/.cursor/mcp.json
   ```

2. Confirm the server is configured as a **remote** MCP server (uses `url`, not `command`).

3. **Completely restart Cursor** (not just reload window):
   - Mac: Cmd+Q, then reopen
   - Linux/Windows: Ctrl+Q, then reopen

4. Check Cursor logs for MCP errors:
   - Open Cursor Developer Tools (Help → Toggle Developer Tools)
   - Look for errors mentioning "MCP" or "nenai"

---

### 2. 401 Unauthorized

**Symptom:** Tools exist, but calls fail with 401/403.

**Solutions:**
1. Verify `NEN_API_KEY` is set in the environment Cursor is using.
2. Restart Cursor after updating environment variables.
3. Contact your NenAI customer engineer to verify key validity/permissions.

---

### 3. Environment variables not picked up by Cursor

**Symptom:** `mcp.json` uses `${env:NEN_API_KEY}` / `${env:NEN_MCP_URL}`, but Cursor behaves as if they are empty.

**Solutions:**
1. Restart Cursor completely (Cmd+Q / Ctrl+Q).
2. Ensure you set `NEN_API_KEY` and `NEN_MCP_URL` in the environment **before** launching Cursor.
3. If you launch Cursor from the macOS Dock/Launcher, ensure your environment variables are available to GUI apps (your IT/dev environment may require a launchd config).

---

### 4. `mcp.json` syntax errors

**Symptom:** The MCP server doesn't load and Cursor shows JSON/config errors.

**Solutions:**
1. Validate JSON:
   ```bash
   python3 -m json.tool ~/.cursor/mcp.json >/dev/null && echo "OK"
   ```
2. Re-run `bash setup-remote-mcp.sh` to regenerate the Nen entry.

---

### 5. Network errors

**Symptom:** Requests fail with network/proxy errors.

**Solutions:**
1. Check internet connection / firewall / proxy settings.
2. Confirm `NEN_MCP_URL` is correct (from your NenAI customer engineer).

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
# Use `${env:NEN_API_KEY}` in `mcp.json` to avoid hardcoding secrets.
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

1. Collect debug info:
   ```bash
   echo "=== System Info ==="
   uname -a
   echo "=== MCP Config ==="
   cat ~/.cursor/mcp.json
   ```

2. Contact support with the output above
