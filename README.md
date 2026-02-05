# NenAI MCP Quickstart

Build computer use automations using natural language in Cursor. Author, test, and run browser automation workflows directly from your IDE.

---

## Prerequisites

- **Cursor** (with support for remote MCP servers)
- **API Key** from your NenAI customer engineer
- **Remote MCP URL** from your NenAI customer engineer

---

## Installation

### Step 1: Clone the repository

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

> **Note:** Get `NEN_MCP_URL` from your NenAI customer engineer.

### Step 3: Configure Cursor

1. Within Cursor, open "Cursor Settings" (Cmd-Shift-J)
2. Select "Tools & MCP" along the left bar
3. Click on "New MCP Server"
4. In `mcp.json`, add the "nen" key under `mcpServers`:

```json
{
  "mcpServers": {
    "nen": {
      "url": "${env:NEN_MCP_URL}",
      "headers": {
        "X-Api-Key": "${env:NEN_API_KEY}"
      }
    }
  }
}
```

### Step 4: Restart Cursor

**Completely quit and reopen Cursor** (Cmd+Q / Ctrl+Q, not just reload window).

### Step 5: Verify

Ask the AI agent in Cursor:

```
Use list_workflows to verify the MCP server is working
```

✅ You should see the MCP server tools responding!

---

## Usage

### Creating Your First Workflow

Ask your AI agent to create a workflow:

```
Create a workflow that navigates to google.com and takes a screenshot
```

The AI will use `nen_create_workflow` to generate FSM files in `workflows/my_workflows/`, then upload and run them using the available MCP tools.

### Available MCP Tools

| Tool | Description |
|------|-------------|
| `list_workflows` | List all workflows in a deployment |
| `update_workflow` | Upload workflow to NenAI platform |
| `list_runs` | List recent runs for a workflow |
| `create_run` | Execute a workflow |
| `get_run_status` | Check workflow run status |
| `get_run_logs` | View workflow logs |
| `get_run_video` | View workflow logs |

See [TOOLS_REFERENCE.md](TOOLS_REFERENCE.md) for detailed documentation.

---

## Troubleshooting

| Problem | Solution |
|---------|----------|
| MCP tools not showing up | Validate JSON syntax in `~/.cursor/mcp.json` |
| MCP tools not showing up | Ensure Cursor was fully restarted (Cmd+Q / Ctrl+Q) |
| MCP tools not showing up | Confirm `mcp.json` uses `url` (remote) not `command` (local) |
| "401 Unauthorized" | Verify `NEN_API_KEY` is correct |
| "401 Unauthorized" | Ensure Cursor can read `${env:NEN_API_KEY}` (restart after changing env vars) |
| "401 Unauthorized" | Contact your NenAI customer engineer to verify key validity |
| Network errors | Check internet connection / proxy / firewall |
| Network errors | Confirm `NEN_MCP_URL` is correct |

See [TROUBLESHOOTING.md](TROUBLESHOOTING.md) for detailed solutions.

---

## Advanced

### Updating

Remote MCP tools are updated server-side. Restart Cursor if you change `mcp.json` or environment variables.

### Uninstallation

1. Remove the `"nen"` entry from `~/.cursor/mcp.json`
2. Restart Cursor

---

## Documentation

- [TROUBLESHOOTING.md](TROUBLESHOOTING.md) - Detailed troubleshooting guide
- [TOOLS_REFERENCE.md](TOOLS_REFERENCE.md) - Complete MCP tools reference
- [.cursorrules](.cursorrules) - FSM workflow authoring guide
- [workflows/samples/](workflows/samples/) - Example workflows

---

## Security

Credentials are provided via environment variables and referenced in `mcp.json` using `${env:...}`. They are never committed to git.

---

## Getting Help

Contact your NenAI customer engineer with:
- Full error message
- Contents of `~/.cursor/mcp.json` (redact any secrets)
