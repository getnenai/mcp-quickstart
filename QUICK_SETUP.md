# NenAI MCP Quick Setup

Get started with NenAI MCP server in 3 minutes.

---

## 1. Clone & Install

```bash
git clone https://github.com/getnenai/mcp-quickstart.git
cd mcp-quickstart
npm install
```

A `.env` file will be created automatically.

---

## 2. Add API Credentials

Edit `.env` and add your credentials:

```bash
NEN_API_KEY=your_api_key_here
NEN_DEPLOYMENT_ID=your_deployment_uuid_here  # Optional
```

Get these from your NenAI customer engineer.

---

## 3. Run Setup

```bash
npm run setup
```

This configures `~/.cursor/mcp.json` with your environment variables.

---

## 4. Restart Cursor

**Completely quit and reopen Cursor** (⌘Q or Ctrl+Q).

---

## 5. Verify

Ask the AI agent in Cursor:

> "Use list_workflows to verify the MCP server is working"

✅ You should see the MCP server tools responding!

---

## Next Steps

- Check **[README.md](README.md)** for full documentation
- See **[TOOLS_REFERENCE.md](TOOLS_REFERENCE.md)** for tool details
- Explore **[workflows/samples/](workflows/samples/)** for examples

---

## Troubleshooting

**MCP server not found:**
- Restart Cursor completely (⌘Q, not just reload)
- Check `~/.cursor/mcp.json` was created by setup script

**API key errors:**
- Verify `.env` has correct format (no spaces around `=`)
- Run `npm run setup` again after editing `.env`
- Restart Cursor

**Need help?**
Contact your NenAI customer engineer.

## 4. Restart Cursor

Quit Cursor completely (Cmd+Q) and reopen.

## 5. Verify

Ask the agent: *"Use nen_list_runs to verify the MCP server"*

---

## Tools

| Tool | Purpose |
|------|---------|
| `nen_create_workflow` | Generate workflow files |
| `nen_upload` | Deploy to platform |
| `nen_run` | Execute workflow |
| `nen_status` | Check run status |
| `nen_logs` | View logs |
| `nen_artifacts` | Download recordings |
| `nen_list_runs` | List run history |

---

## First Workflow

Ask: *"Create a workflow that navigates to google.com and takes a screenshot"*

---

**Get your API key from your NenAI customer engineer**
