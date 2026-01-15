# NenAI MCP Quickstart

Author computer use automations using natural language in Cursor.

## Quick Setup (3 minutes)

### 1. Clone and install

```bash
git clone https://github.com/getnenai/mcp-quickstart.git
cd mcp-quickstart
npm install
```

### 2. Add your API credentials

Edit the `.env` file and add your credentials:

```bash
NEN_API_KEY=your_api_key_here
NEN_DEPLOYMENT_ID=your_deployment_uuid_here  # Optional
```

> **Getting Your Credentials:** Contact your NenAI customer engineer.

### 3. Run the setup script

```bash
chmod +x setup-mcp.sh
./setup-mcp.sh
```

Or use npm:

```bash
npm run setup
```

This script will:
- ✅ Read your `.env` file
- ✅ Configure `~/.cursor/mcp.json` with environment variables
- ✅ Set up absolute paths to the MCP server

### 4. Restart Cursor

**Completely quit and reopen Cursor** (Cmd+Q or Ctrl+Q) for the MCP server to load.

### 5. Verify setup

Ask the AI agent:
> "Use list_workflows to verify the MCP server is working"

You should see the MCP server responding successfully!

---

## Available MCP Tools

| Tool | Description |
|------|-------------|
| `nen_create_workflow` | Generate FSM workflow files from natural language |
| `nen_upload` | Upload workflow files to S3 and update DynamoDB |
| `nen_run` | Trigger workflow execution on the NenAI platform |
| `nen_status` | Check the status of a running workflow |
| `nen_logs` | Fetch execution logs from the container |
| `nen_artifacts` | Download run artifacts (videos, logs, screenshots) |
| `nen_list_runs` | List recent runs for a workflow |

---

## Create Your First Workflow

Ask your AI agent:
> "Create a workflow that navigates to google.com and takes a screenshot"

The agent will use `nen_create_workflow` to generate FSM workflow files in `workflows/my_workflows/`.

Then:
1. Review the generated files
2. Upload with `nen_upload`
3. Run with `nen_run`
4. Check results with `nen_artifacts`

---

## Troubleshooting

| Problem | Solution |
|---------|----------|
| MCP server not found | Restart Cursor completely (Cmd+Q) |
| "API key not set" | Check `.env` has your `NEN_API_KEY` |
| "401 Unauthorized" | Verify API key is valid |
| "Cannot find module" | Run `npm install` in the mcp-quickstart directory |

---

## Resources

- **[.cursorrules](.cursorrules)** - FSM authoring guide for AI agents
- **[workflows/samples/](workflows/samples/)** - Example workflows
- **Support** - Contact your NenAI customer engineer
