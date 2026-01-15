# NenAI MCP Quick Setup

## 1. Clone & Install

```bash
git clone https://github.com/getnenai/mcp-quickstart.git
cd mcp-quickstart
npm install
```

## 2. Add API Key

Edit `.env` and add your key:
```bash
NEN_API_KEY=your_api_key_here
```

## 3. Configure Cursor

Run this command **from inside the mcp-quickstart directory**:

```bash
mkdir -p ~/.cursor && cat > ~/.cursor/mcp.json << EOF
{
  "mcpServers": {
    "nenai": {
      "command": "node",
      "args": ["$PWD/node_modules/@nen/mcp-server/dist/index.js"],
      "cwd": "$PWD"
    }
  }
}
EOF
```

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
