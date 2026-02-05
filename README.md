# NenAI MCP Quickstart

Build computer use automations using natural language in Cursor. Author, test, and run browser automation workflows directly from your IDE.

---

## Prerequisites

- **Cursor** (with support for remote MCP servers)

---

## Installation

### Step 1: Clone the repository

```bash
git clone https://github.com/getnenai/mcp-quickstart.git
cd mcp-quickstart
```

### Step 2: Configure Cursor

Click the button below to automatically install the NenAI Platform MCP Server:

<a href="cursor://anysphere.cursor-deeplink/mcp/install?name=NenAI-Platform&config=eyJ1cmwiOiJodHRwczovL21jcC5nZXRuZW4uYWkvdjEifQ==">
  <img src="https://cursor.com/deeplink/mcp-install-dark.png" alt="Add NenAI Platform MCP server to Cursor" height="32" />
</a>

This will automatically add the server configuration to your `mcp.json` file.

<details>
<summary>Manual installation (alternative)</summary>

If the automatic installation doesn't work:

1. Within Cursor, open "Cursor Settings" (Cmd-Shift-J)
2. Select "Tools & MCP" along the left bar
3. Click on "New MCP Server"
4. In `mcp.json`, add the "NenAI Platform" key under `mcpServers`:

```json
{
  "mcpServers": {
    "NenAI Platform": {
      "url": "https://mcp.getnen.ai/v1"
    }
  }
}
```
</details>

### Step 3: Verify

Ask the AI agent in Cursor:

```
Show me the available NenAI Platform MCP tools
```

✅ You should see tools like nen_create_workflow, nen_run, nen_status, update_workflow, get_run_video, and get_run_logs!

---

## Usage

### Creating Your First Workflow

Ask your AI agent to create a workflow:

```
Create a workflow that navigates to google.com and takes a screenshot
```

The AI will use `nen_create_workflow` to generate FSM files in `workflows/my_workflows/`, then upload and run them using the available MCP tools.

---

## Troubleshooting

| Problem | Solution |
|---------|----------|
| MCP tools not showing up | Validate JSON syntax in `~/.cursor/mcp.json` |
| Network errors | Check internet connection / proxy / firewall |

See [TROUBLESHOOTING.md](TROUBLESHOOTING.md) for detailed solutions.

---

## Advanced

### Updating

Remote MCP tools are updated server-side automatically.

### Uninstallation

1. Remove the `"NenAI Platform"` entry from `~/.cursor/mcp.json`
2. Restart Cursor

---

## Documentation

- [TROUBLESHOOTING.md](TROUBLESHOOTING.md) - Detailed troubleshooting guide
- [TOOLS_REFERENCE.md](TOOLS_REFERENCE.md) - Complete MCP tools reference
- [.cursorrules](.cursorrules) - FSM workflow authoring guide
- [workflows/samples/](workflows/samples/) - Example workflows

---

## Security

The MCP server configuration uses a public URL endpoint. No credentials are stored in `mcp.json`.

---

## Getting Help

Contact your NenAI customer engineer with:
- Full error message
- Contents of `~/.cursor/mcp.json` (redact any secrets)
