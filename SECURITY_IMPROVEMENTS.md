# Security Improvements: Environment Variable Handling

## What Changed

Previously, the setup script wrote `NEN_API_KEY` and `NEN_DEPLOYMENT_ID` directly into `~/.cursor/mcp.json`. Now, credentials are kept secure in your local `.env` file and referenced at runtime.

## New Architecture

### Before
```json
{
  "mcpServers": {
    "nenai": {
      "command": "node",
      "args": ["..."],
      "env": {
        "NEN_API_KEY": "actual_key_here",
        "NEN_DEPLOYMENT_ID": "actual_id_here"
      }
    }
  }
}
```

### After
```json
{
  "mcpServers": {
    "nenai": {
      "command": "bash",
      "args": ["/path/to/start-mcp-server.sh"],
      "cwd": "/path/to/mcp-quickstart"
    }
  }
}
```

## How It Works

1. **Wrapper Script** (`start-mcp-server.sh`)
   - Loads environment variables from `.env` file
   - Exports them to the environment
   - Starts the MCP server with those variables

2. **Setup Script** (`setup-mcp.sh`)
   - Verifies `.env` exists and contains required credentials
   - Creates the wrapper script
   - Configures `mcp.json` to use the wrapper (no credentials written)

3. **Environment File** (`.env`)
   - Your credentials stay here and only here
   - Never committed to git (in `.gitignore`)
   - Easy to update without re-running setup

## Benefits

✅ **Security**: Credentials never written to `mcp.json`  
✅ **Flexibility**: Update `.env` without re-running setup  
✅ **Portability**: Share `mcp.json` safely (no secrets)  
✅ **Best Practice**: Follows 12-factor app methodology  

## Setup Process

Simply run:

```bash
npm run setup
```

This single command:
1. Creates the wrapper script
2. Updates `mcp.json` to use the wrapper
3. Validates the entire setup
4. Confirms no secrets leaked

Then restart Cursor completely (Cmd+Q or Ctrl+Q).

## Security Hardening Applied

### 1. Error Handling
- ✅ Wrapper fails fast if `.env` is missing (no silent failures)
- ✅ Setup validates wrapper script exists before configuring
- ✅ Both scripts validate required environment variables
- ✅ Configuration verification after writing `mcp.json`

### 2. Safe .env Parsing
- ✅ Using `source` instead of `cat | xargs` (prevents shell injection)
- ✅ Proper variable export with `set -a` / `set +a`
- ✅ No unsafe command substitution

### 3. Backup & Recovery
- ✅ Automatic backup of existing `mcp.json` with timestamp
- ✅ Easy rollback capability
- ✅ Non-destructive updates

### 4. Validation & Testing
- ✅ Test script (`test-setup.sh`) validates entire setup
- ✅ Checks for credential leakage in `mcp.json`
- ✅ Verifies file permissions and dependencies
- ✅ npm test integration

### 5. Documentation
- ✅ Comprehensive troubleshooting guide
- ✅ Security validation steps
- ✅ Clear error messages with remediation steps

## Files Involved

- `.env.example` - Template for creating `.env`
- `.env` - Your actual credentials (gitignored)
- `start-mcp-server.sh` - Hardened wrapper that loads `.env` and starts server
- `setup-mcp.sh` - Enhanced setup script with validation and backup
- `test-setup.sh` - Automated testing and validation script
- `TROUBLESHOOTING.md` - Comprehensive troubleshooting guide
- `~/.cursor/mcp.json` - Cursor config (no secrets, verified clean)
