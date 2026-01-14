# NenAI MCP Quickstart

Author computer use automations using natural language in Cursor or other AI-powered IDEs.

## Quick Start

### 1. Clone this repository

```bash
git clone https://github.com/getnenai/mcp-quickstart.git
cd mcp-quickstart
```

### 2. Install dependencies

```bash
npm install
```

This automatically creates a `.env` file with empty keys.

### 3. Add your API key

Edit `.env` and add the values provided by your customer engineer:

```bash
NEN_API_KEY=your_api_key_here
NEN_DEPLOYMENT_ID=your_deployment_id
```

### 4. Configure Cursor MCP

Add the following to `~/.cursor/mcp.json`:

```json
{
  "mcpServers": {
    "nen": {
      "command": "npx",
      "args": ["@nen/mcp-server"],
      "cwd": "/path/to/mcp-quickstart"
    }
  }
}
```

> **Note:** Replace `/path/to/mcp-quickstart` with your actual clone path.

Restart Cursor to pick up the MCP server.

### 5. Verify setup

Ask the AI agent:
> "Use list_runs to verify the MCP server is working"

If configured correctly, you'll see a response from the NenAI API.

### 6. Start authoring workflows

Ask the AI agent to create workflows:
> "Create a workflow that navigates to google.com and takes a screenshot"

---

## Available MCP Tools

| Tool | Description |
|------|-------------|
| `create_workflow` | Generate FSM workflow files from natural language |
| `update_workflow` | Upload workflow changes to NenAI platform |
| `create_run` | Trigger new workflow execution |
| `get_run_status` | Check run status |
| `get_run_logs` | Fetch execution logs |
| `get_run_video` | Get URL for run recording video |
| `list_runs` | List recent runs for a workflow |

---

## Directory Structure

```
mcp-quickstart/
├── .cursorrules          # FSM authoring guide for AI agents
├── workflows/
│   ├── samples/          # Example workflows to learn from
│   │   ├── get-appointments/
│   │   └── download-documents/
│   └── my_workflows/     # Your custom workflows go here
└── .env                  # Your API credentials (not committed)
```

---

## Resources

- **[.cursorrules](.cursorrules)** - FSM authoring reference for AI agents
- **[samples/](workflows/samples/)** - Example workflows
