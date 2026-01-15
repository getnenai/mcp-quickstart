# NenAI MCP Quickstart

Build computer use automations using natural language in Cursor. Author, test, and run browser automation workflows directly from your IDE.

## Quick Setup

### 1. Install

```bash
git clone https://github.com/getnenai/mcp-quickstart.git
cd mcp-quickstart
npm install
```

The postinstall script creates a `.env` file from `.env.example`.

### 2. Add Credentials

Edit `.env` with your API credentials:

```env
NEN_API_KEY=your_api_key_here
NEN_DEPLOYMENT_ID=your_deployment_id  # Optional
```

### 3. Configure

```bash
npm run setup
```

This configures Cursor's MCP settings and validates your setup.

### 4. Restart Cursor

Quit Cursor completely (`Cmd+Q` / `Ctrl+Q`) and reopen it.

### 5. Verify

Ask the AI agent:

```
Use list_workflows to verify the MCP server is working
```

## Usage

### Creating Workflows

Ask your AI agent to create a workflow:

```
Create a workflow that navigates to google.com and takes a screenshot
```

The AI will use `create_workflow` to generate FSM files in `workflows/my_workflows/`, then upload and run them using the available MCP tools.

### Available MCP Tools

| Tool | Description |
|------|-------------|
| `create_workflow` | Generate FSM workflow files from natural language |
| `update_workflow` | Upload workflow to NenAI platform (S3 + DynamoDB) |
| `create_run` | Execute a workflow |
| `get_run_status` | Check workflow run status |
| `get_run_logs` | Fetch execution logs from container |
| `get_run_video` | Get video recording URL for a completed run |
| `list_runs` | List recent runs for a workflow |
| `list_workflows` | List all workflows in a deployment |

See [TOOLS_REFERENCE.md](TOOLS_REFERENCE.md) for detailed documentation.

## Troubleshooting

Run diagnostics:

```bash
npm test
```

Common issues:

| Problem | Solution |
|---------|----------|
| MCP tools not available | Restart Cursor completely (`Cmd+Q` / `Ctrl+Q`) |
| "API key not set" | Check `.env` contains valid `NEN_API_KEY` |
| "401 Unauthorized" | Verify API key with your customer engineer |
| "Cannot find module" | Run `npm install` |

See [TROUBLESHOOTING.md](TROUBLESHOOTING.md) for detailed solutions.

## Documentation

- [TROUBLESHOOTING.md](TROUBLESHOOTING.md) - Detailed troubleshooting guide
- [TOOLS_REFERENCE.md](TOOLS_REFERENCE.md) - Complete MCP tools reference
- [INSTALLATION.md](INSTALLATION.md) - Alternative installation methods
- [.cursorrules](.cursorrules) - FSM workflow authoring guide
- [workflows/samples/](workflows/samples/) - Example workflows

## Security

Credentials are stored in `.env` and loaded at runtime via a wrapper script. They are never written to Cursor's configuration files. Run `npm test` to verify.
