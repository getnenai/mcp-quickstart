# NenAI MCP Quickstart

Build computer use automations using natural language in Cursor. Author, test, and run browser automation workflows directly from your IDE.

## Quick Setup

### 1. Configure environment variables

```bash
git clone https://github.com/getnenai/mcp-quickstart.git
cd mcp-quickstart
```

Export the variables Cursor will use to authenticate to the **remote Nen MCP server**:

```bash
export NEN_API_KEY="your_api_key_here"
export NEN_MCP_URL="your_remote_mcp_url_here"
```

Get `NEN_MCP_URL` from your NenAI customer engineer.

### 2. Configure Cursor MCP

```bash
bash setup-remote-mcp.sh
```

This writes/updates `~/.cursor/mcp.json` to use the remote MCP server (no local server process).

### 3. Restart Cursor

Quit Cursor completely (`Cmd+Q` / `Ctrl+Q`) and reopen it.

### 4. Verify

Ask the AI agent:

```
Use nen_list_workflows to verify the MCP server is working
```

## Usage

### Creating Workflows

Ask your AI agent to create a workflow:

```
Create a workflow that navigates to google.com and takes a screenshot
```

The AI will use `nen_create_workflow` to generate FSM files in `workflows/my_workflows/`, then upload and run them using the available MCP tools.

### Available MCP Tools

| Tool | Description |
|------|-------------|
| `nen_create_workflow` | Generate FSM workflow files from natural language |
| `nen_upload` | Upload workflow to NenAI platform |
| `nen_run` | Execute a workflow |
| `nen_status` | Check workflow run status |
| `nen_artifacts` | Download run artifacts (recording + logs) |
| `nen_list_runs` | List recent runs for a workflow |
| `nen_list_workflows` | List all workflows in a deployment |
| `nen_list_deployments` | List deployments available to your API key |

See [TOOLS_REFERENCE.md](TOOLS_REFERENCE.md) for detailed documentation.

## Troubleshooting

Common issues:

| Problem | Solution |
|---------|----------|
| MCP tools not available | Restart Cursor completely (`Cmd+Q` / `Ctrl+Q`) |
| "401 Unauthorized" | Verify `NEN_API_KEY` is correct and Cursor can read it |
| "401 Unauthorized" | Verify API key with your customer engineer |

See [TROUBLESHOOTING.md](TROUBLESHOOTING.md) for detailed solutions.

## Documentation

- [TROUBLESHOOTING.md](TROUBLESHOOTING.md) - Detailed troubleshooting guide
- [TOOLS_REFERENCE.md](TOOLS_REFERENCE.md) - Complete MCP tools reference
- [INSTALLATION.md](INSTALLATION.md) - Alternative installation methods
- [.cursorrules](.cursorrules) - FSM workflow authoring guide
- [workflows/samples/](workflows/samples/) - Example workflows

## Security

Credentials are provided via environment variables and referenced in `mcp.json` using `${env:...}`. They are never committed to git.
