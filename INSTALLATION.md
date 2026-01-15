# MCP Server Installation Guide

## Prerequisites

- **Node.js** 18+ ([download](https://nodejs.org))
- **API Key** from your NenAI customer engineer

---

## Installation

### Step 1: Clone and Install

```bash
git clone https://github.com/getnenai/mcp-quickstart.git
cd mcp-quickstart
npm install
```

This creates a `.env` file automatically.

### Step 2: Add Your API Key

Edit `.env` in the project root:

```bash
NEN_API_KEY=your_api_key_here
```

### Step 3: Configure Cursor

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

This uses `$PWD` to automatically insert the full path to your mcp-quickstart directory.

**Windows users:** Create the file manually at `%APPDATA%\Cursor\mcp.json`:

```json
{
  "mcpServers": {
    "nenai": {
      "command": "node",
      "args": ["C:\\path\\to\\mcp-quickstart\\node_modules\\@nen\\mcp-server\\dist\\index.js"],
      "cwd": "C:\\path\\to\\mcp-quickstart"
    }
  }
}
```

### Step 4: Restart Cursor

Completely quit (Cmd+Q on macOS, or close from system tray on Windows) and reopen Cursor.

### Step 5: Verify Installation

Ask the AI agent:
> "Use nen_list_runs to verify the MCP server"

**Expected:** A response from the NenAI API (even if it's an empty list).

---

## Troubleshooting

### "Cannot find module"

The path to the MCP server is incorrect.

1. Verify you ran `npm install` in the mcp-quickstart directory
2. Check that `node_modules/@nen/mcp-server/dist/index.js` exists
3. Verify the paths in `~/.cursor/mcp.json` are correct absolute paths

### "NEN_API_KEY environment variable not set"

1. Check `.env` file exists and has your API key
2. Restart Cursor completely (not just reload window)

### "API request failed with status 401"

1. Verify API key is correct (no typos)
2. Contact your NenAI customer engineer to verify key validity

### "Network error: fetch failed"

1. Check internet connection
2. Test: `curl https://api.getnen.ai/health`
3. Check firewall/proxy settings

### MCP server not appearing

1. Validate JSON syntax in `~/.cursor/mcp.json`
2. Ensure Cursor was fully restarted (Cmd+Q, not just reload)
3. Check Cursor's output panel for error messages

---

## Updating

```bash
cd mcp-quickstart
npm update @nen/mcp-server
```

Restart Cursor after updating.

---

## Uninstallation

1. Remove the "nenai" entry from `~/.cursor/mcp.json`
2. Restart Cursor

---

## Getting Help

Contact your NenAI customer engineer with:
- Full error message
- Output of `node --version`
- Contents of `~/.cursor/mcp.json`
