# NenAI MCP Quickstart

Author computer use automations using natural language in Cursor or other AI-powered IDEs.

## What is this?

NenAI lets you create and run automated workflows that interact with desktop applications. This quickstart helps you:

1. Set up the NenAI MCP server in Cursor
2. Author workflows using natural language
3. Execute workflows on NenAI's computer use infrastructure

## Prerequisites

- **Node.js 18+** and npm
- **Cursor IDE** (or another MCP-compatible IDE)
- **NenAI API credentials** - [Contact us](mailto:hello@nen.ai) for access

---

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

This automatically:
- Creates a `.env` file for your credentials
- Configures the NenAI MCP server in Cursor (if `~/.cursor/mcp.json` doesn't exist)
- Sets up the workflows directory structure

### 3. Add your API credentials

Edit `.env` and add your NenAI API credentials:

```bash
NEN_API_KEY=your_api_key_here
NEN_DEPLOYMENT_ID=your_deployment_id
```

> **Don't have credentials?** [Request access](mailto:hello@nen.ai) to get your API key and deployment ID.

### 4. Restart Cursor

Restart Cursor to load the MCP server configuration.

> **Note:** If you already had `~/.cursor/mcp.json`, you may need to manually add the "nen" server. The setup script will tell you if this is needed.

### 5. Verify setup

In Cursor, ask the AI agent:

> "Use list_runs to verify the MCP server is working"

If you see a response from the NenAI API, you're all set!

### 6. Create your first workflow

Ask the AI agent to create a workflow:

> "Create a workflow that navigates to google.com and takes a screenshot"

The AI will:
- Generate FSM workflow files in `workflows/my_workflows/`
- Upload the workflow to your NenAI deployment
- Provide instructions to run it

---

## Available MCP Tools

Once configured, these tools are available to the AI agent in Cursor:

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

## What can you build?

Example workflows:

- **Data extraction:** "Download all invoices from vendor portal"
- **Form filling:** "Submit expense reports with attached receipts"
- **Monitoring:** "Check application status every hour and notify if changed"
- **Testing:** "Verify checkout flow works end-to-end"

See [sample workflows](workflows/samples/) for complete examples.

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
└── .env                  # Your API credentials (gitignored)
```

---

## Workflow Authoring

The `.cursorrules` file contains comprehensive documentation for creating workflows. Key concepts:

### State Types

- **LLMState:** Let the AI figure out how to complete a task
- **ToolState:** Execute specific actions (click, type, screenshot)
- **VerificationState:** Wait for conditions to be met
- **CoordinateToolState:** AI finds element, then performs action
- **CallbackState:** Generate dynamic values (TOTP, timestamps)

### Best Practices

1. Start workflows with environment normalization (launch browser, navigate to URL)
2. Use verification states after critical actions
3. Keep one clear goal per state
4. Use descriptive IDs and messages
5. Add appropriate max_iterations (5-15 typical)

See [.cursorrules](.cursorrules) for detailed authoring guide.

---

## Troubleshooting

### MCP server not loading in Cursor

1. Verify `~/.cursor/mcp.json` is valid JSON
2. Check the `cwd` path is absolute and correct
3. Restart Cursor completely (Cmd+Q, not just close window)
4. Check Cursor logs: View > Output > "Model Context Protocol"

### API authentication errors

1. Verify `.env` file exists and has correct format
2. No quotes around values: `NEN_API_KEY=sk_xxx` (not `"sk_xxx"`)
3. Restart Cursor after editing `.env`
4. Verify credentials are still valid

### Workflow creation fails

1. Start with a simple workflow: "Create a workflow that takes a screenshot"
2. Check generated JSON syntax: `cat workflows/my_workflows/*/workflow.json`
3. Review `.cursorrules` for FSM structure requirements

### Need more help?

Run the verification script:

```bash
npm run verify
```

This checks your setup and provides diagnostic information.

Still stuck? [Contact support](mailto:hello@nen.ai) with the output of `npm run verify`.

For detailed troubleshooting, see [TROUBLESHOOTING.md](TROUBLESHOOTING.md).

---

## Resources

- **[FSM Authoring Guide](.cursorrules)** - Complete workflow syntax reference
- **[Sample Workflows](workflows/samples/)** - Learn from examples
- **[Troubleshooting Guide](TROUBLESHOOTING.md)** - Detailed help for common issues
- **[Documentation](https://docs.nen.ai)** - Full platform documentation
- **[Support](mailto:hello@nen.ai)** - Get help from our team

---

## Next Steps

1. Explore the [sample workflows](workflows/samples/)
2. Try modifying an existing workflow
3. Create a workflow for your use case
4. Share feedback with your customer engineer

---

## License

This quickstart is MIT licensed. The NenAI platform requires an API key and is subject to separate terms of service.
