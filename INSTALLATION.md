# Nen Remote MCP Server Installation Guide

This repo no longer supports running a local MCP server. Cursor should connect to the **remote Nen MCP server** via `url`.

## Prerequisites

- **Cursor** (with support for remote MCP servers)
- **API Key** from your NenAI customer engineer
- **Remote MCP URL** from your NenAI customer engineer

---

## Installation

### Step 1: Clone

```bash
git clone https://github.com/getnenai/mcp-quickstart.git
cd mcp-quickstart
```

### Step 2: Set environment variables

Set these in the environment **Cursor runs with**:

```bash
export NEN_API_KEY="your_api_key_here"
export NEN_MCP_URL="your_remote_mcp_url_here"
```

### Step 3: Configure Cursor

Run:

```bash
bash setup-remote-mcp.sh
```

Or manually create/update `~/.cursor/mcp.json`:

```json
{
  "mcpServers": {
    "nenai": {
      "url": "${env:NEN_MCP_URL}",
      "headers": {
        "X-Api-Key": "${env:NEN_API_KEY}"
      }
    }
  }
}
```

### Step 4: Restart Cursor

Completely quit (Cmd+Q / Ctrl+Q) and reopen Cursor.

### Step 5: Verify

Ask the AI agent:
> "Use nen_list_workflows to verify the MCP server"

---

## Troubleshooting

### MCP tools not showing up

1. Validate JSON syntax in `~/.cursor/mcp.json`
2. Ensure Cursor was fully restarted (Cmd+Q / Ctrl+Q, not just reload window)
3. Confirm `mcp.json` uses `url` (remote) and not `command` (local)

### 401 Unauthorized

1. Verify `NEN_API_KEY` is correct
2. Ensure Cursor can read `${env:NEN_API_KEY}` (restart Cursor after changing env vars)
3. Contact your NenAI customer engineer to verify key validity/permissions

### Network errors

1. Check internet connection / proxy / firewall
2. Confirm `NEN_MCP_URL` is correct

---

## Updating

Remote MCP tools are updated server-side. Restart Cursor if you change `mcp.json` or environment variables.

---

## Uninstallation

1. Remove the `"nenai"` entry from `~/.cursor/mcp.json`
2. Restart Cursor

---

## Getting Help

Contact your NenAI customer engineer with:
- Full error message
- Contents of `~/.cursor/mcp.json` (redact any secrets if you added them)
