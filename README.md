# NenAI MCP Quickstart

Build computer use automations using natural language in Cursor.

---

## Quick Setup (3 minutes)

### 1. Clone and install

```bash
git clone https://github.com/getnenai/mcp-quickstart.git
cd mcp-quickstart
npm install
```

The `postinstall` script will automatically create a `.env` file for you.

### 2. Add your API credentials

Edit the `.env` file and add your credentials:

```bash
NEN_API_KEY=your_api_key_here
NEN_DEPLOYMENT_ID=your_deployment_uuid_here  # Optional
```

> **Getting Your Credentials:** Contact your NenAI customer engineer.

### 3. Run the setup script

```bash
npm run setup
```

This script will:
- ✅ Read your `.env` file
- ✅ Configure `~/.cursor/mcp.json` with environment variables
- ✅ Set up absolute paths to the MCP server

### 4. Restart Cursor

**Completely quit and reopen Cursor** (⌘Q or Ctrl+Q) for the MCP server to load.

### 5. Verify setup

Ask the AI agent in Cursor:
> "Use list_workflows to verify the MCP server is working"

You should see the MCP server tools responding successfully! ✅

---

## What You Can Do

### Create Workflows

Ask the AI agent to create workflows from natural language:

```
"Create a workflow that:
 - Opens Firefox
 - Navigates to example.com
 - Fills out the contact form
 - Takes a screenshot of the confirmation page"
```

The agent will use `create_workflow` to generate FSM files in `workflows/my_workflows/`.

### Deploy and Run

```
1. Review generated workflow files
2. Upload with update_workflow
3. Run with create_run
4. Check status with get_run_status
5. Get results with get_run_video
```

### List and Inspect

```
- list_workflows: See all workflows in your deployment
- list_runs: See recent runs for a workflow
- get_run_logs: Fetch execution logs
```

---

## Available MCP Tools

| Tool | Description |
|------|-------------|
| `create_workflow` | Generate FSM workflow files from natural language |
| `update_workflow` | Upload workflow files to S3 and update registry |
| `create_run` | Trigger workflow execution on the NenAI platform |
| `get_run_status` | Check the status of a workflow run |
| `get_run_logs` | Fetch execution logs from the container |
| `get_run_video` | Get video recording URL for a completed run |
| `list_runs` | List recent runs for a workflow |
| `list_workflows` | List all workflows in your deployment |

> See **[TOOLS_REFERENCE.md](TOOLS_REFERENCE.md)** for detailed documentation of each tool.

---

## Project Structure

```
mcp-quickstart/
├── workflows/
│   ├── my_workflows/       # Your workflows go here
│   └── samples/            # Example workflows
│       ├── get-appointments/
│       └── download-documents/
├── .env                    # Your API credentials (gitignored)
├── setup-mcp.sh           # Setup script
└── package.json
```

---

## Troubleshooting

| Problem | Solution |
|---------|----------|
| MCP server not found | Restart Cursor completely (⌘Q or Ctrl+Q) |
| "API key not set" | Check `.env` has your `NEN_API_KEY`, then run `npm run setup` again |
| "401 Unauthorized" | Verify API key is valid with your customer engineer |
| "Cannot find module" | Run `npm install` in the mcp-quickstart directory |
| Setup script fails | Ensure `.env` file exists and has valid credentials |

### Common Issues

**Environment variables not loading:**
1. Verify `.env` file has correct format (no spaces around `=`)
2. Run `npm run setup` to update Cursor configuration
3. Completely restart Cursor (⌘Q, not just reload window)
4. Check `~/.cursor/mcp.json` has the `env` field with your keys

**MCP server tools not appearing:**
1. Check Cursor's output panel for MCP server errors
2. Verify node_modules/@nen/mcp-server exists
3. Try reinstalling: `rm -rf node_modules && npm install`

---

## Documentation

- **[QUICK_SETUP.md](QUICK_SETUP.md)** - Abbreviated setup guide
- **[TOOLS_REFERENCE.md](TOOLS_REFERENCE.md)** - Detailed tool documentation
- **[INSTALLATION.md](INSTALLATION.md)** - Advanced installation options
- **[workflows/samples/](workflows/samples/)** - Example workflows to learn from
- **[CONTRIBUTING.md](CONTRIBUTING.md)** - Contributing guidelines

---

## Environment Variables

The MCP server uses these environment variables (configured via setup script):

- **`NEN_API_KEY`** (required): API key for NenAI platform
  - Used by: `create_run`, `get_run_video`
  - Get from your NenAI customer engineer

- **`NEN_DEPLOYMENT_ID`** (optional): Your deployment UUID
  - Used by: `list_workflows`
  - Get from your customer engineer

These are passed to the MCP server via Cursor's `mcp.json` configuration file.

---

## Support

- **Documentation Issues:** Open an issue on GitHub
- **API Access:** Contact your NenAI customer engineer
- **Bug Reports:** Include MCP server version and Cursor logs

---

## License

See [LICENSE](LICENSE) for details.
