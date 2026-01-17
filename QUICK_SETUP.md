# NenAI MCP Quick Setup

Get started with the **remote Nen MCP server** in 3 minutes.

---

## 1. Clone

```bash
git clone https://github.com/getnenai/mcp-quickstart.git
cd mcp-quickstart
```

---

## 2. Set environment variables

Set these in the environment **Cursor runs with**:

```bash
export NEN_API_KEY="your_api_key_here"
export NEN_MCP_URL="your_remote_mcp_url_here"
```

Get `NEN_MCP_URL` from your NenAI customer engineer.

---

## 3. Configure Cursor MCP

```bash
bash setup-remote-mcp.sh
```

This writes/updates `~/.cursor/mcp.json` to use the remote MCP server.

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
- Check `~/.cursor/mcp.json` contains a `"url"` entry for `"nenai"`

**API key errors:**
- Verify `NEN_API_KEY` is set in your environment
- Re-run `bash setup-remote-mcp.sh` after changing `NEN_MCP_URL`
- Restart Cursor

**Need help?**
Contact your NenAI customer engineer.

---

## Tools

| Tool | Purpose |
|------|---------|
| `nen_create_workflow` | Generate workflow files |
| `nen_upload` | Deploy to platform |
| `nen_run` | Execute workflow |
| `get_run_status` | Check run status |
| `nen_logs` | View logs |
| `list_runs` | List run history |

---

## First Workflow

Ask: *"Create a workflow that navigates to google.com and takes a screenshot"*

---

**Get your API key from your NenAI customer engineer**
